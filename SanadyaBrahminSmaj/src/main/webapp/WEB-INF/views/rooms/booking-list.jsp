<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>

<style>
body{background:#fffaf4;font-family:'Segoe UI','Noto Sans Devanagari',sans-serif;}
.main-width{max-width:1300px;margin:auto;}

.cardx{
  background:linear-gradient(93deg,#ffedc2 65%,#fca854 100%);
  border-radius:18px;padding:18px;
  box-shadow:0 2px 16px rgba(160,128,32,.15);
}

.section-title{
  font-weight:800;color:#7a4200;
  border-bottom:1px dashed #e7c089;
  margin-bottom:14px;
}

.badge-status{
  padding:6px 10px;
  border-radius:12px;
  font-weight:700;
  font-size:12px;
  display:inline-block;
}
.PENDING{background:#ffe082;}
.CONFIRMED{background:#81d4fa;}
.CHECKED_IN{background:#a5d6a7;}
.COMPLETED{background:#cfd8dc;}
.CANCELLED{background:#ef9a9a;}

.btn-action{padding:4px 8px;font-size:13px;}
</style>

<div class="container main-width my-4">

<h3 class="mb-3">📋 बुकिंग प्रबंधन (Admin)</h3>

<!-- ================= FILTER ================= -->
<div class="cardx mb-4">
<div class="section-title">🔍 फ़िल्टर</div>

<form method="get" action="/bookings/admin">
<div class="row g-3">

  <div class="col-md-2">
    <input name="bookingCode"
           value="${param.bookingCode}"
           class="form-control"
           placeholder="बुकिंग कोड">
  </div>

  <div class="col-md-2">
    <input name="guestName"
           value="${param.guestName}"
           class="form-control"
           placeholder="अतिथि नाम / फोन">
  </div>

  <div class="col-md-2">
    <select name="status" class="form-select">
      <option value="">सभी स्थिति</option>
      <c:forEach items="${statuses}" var="st">
        <option value="${st}"
          ${param.status==st ? 'selected' : ''}>
          ${st}
        </option>
      </c:forEach>
    </select>
  </div>

  <div class="col-md-2">
    <input type="date"
           name="fromDate"
           value="${param.fromDate}"
           class="form-control">
  </div>

  <div class="col-md-2">
    <input type="date"
           name="toDate"
           value="${param.toDate}"
           class="form-control">
  </div>

  <div class="col-md-2 text-end">
    <button class="btn btn-success btn-sm">खोजें</button>
    <a href="/bookings/admin"
       class="btn btn-secondary btn-sm">रीसेट</a>
  </div>

</div>
</form>
</div>

<!-- ================= LIST ================= -->
<div class="cardx">
<div class="section-title">📑 बुकिंग सूची</div>

<table class="table table-bordered table-hover bg-white align-middle">
<thead class="table-light">
<tr>
  <th>कोड</th>
  <th>अतिथि</th>
  <th>रूम</th>
  <th>तिथियाँ</th>
  <th>रातें</th>
  <th>राशि</th>
  <th>स्थिति</th>
  <th>एक्शन</th>
</tr>
</thead>

<tbody>
<c:forEach items="${bookings}" var="b">

<tr>
  <td><strong>${b.bookingCode}</strong></td>

  <td>
    ${b.guestName}<br>
    <small>${b.phone}</small>
  </td>

  <td>
    ${b.room.roomTypeLabel}<br>
    <small>रूम ${b.room.roomNumber}</small>
  </td>

  <td>
    ${b.checkInDate} → ${b.checkOutDate}
  </td>


  <td>
    ${b.checkOutDate.toEpochDay() - b.checkInDate.toEpochDay()}
  </td>

  <td>
    ₹${b.totalAmount}<br>
    <small>Paid: ₹${b.paidAmount}</small>
  </td>

  <td>
    <span class="badge-status ${b.status}">
      ${b.status}
    </span>
  </td>

  <td>

    <!-- VIEW (ALL) -->
    <a href="/bookings/admin/view/${b.id}"
       class="btn btn-info btn-action"
       title="देखें">
       👁
    </a>

    <!-- CONFIRM -->
    <c:if test="${b.status=='PAYMENT_RECIVED_AWAITING_CONFIRMATION'}">
      <a href="/bookings/admin/confirm/${b.id}"
         class="btn btn-primary btn-action"
         title="कन्फर्म करें">
         ✔ Confirm
      </a>
    </c:if>

    <!-- CHECK-IN -->
    <c:if test="${b.status=='CONFIRMED'}">
      <a href="/bookings/checkin/${b.id}"
         class="btn btn-success btn-action"
         title="चेक-इन">
         ✔ Check-In
      </a>
    </c:if>

    <!-- CHECK-OUT -->
    <c:if test="${b.status=='CHECKED_IN'}">
      <a href="/bookings/checkout/${b.id}"
         class="btn btn-warning btn-action"
         title="चेक-आउट">
         🚪 Check-Out
      </a>
    </c:if>

    <!-- INVOICE -->
    <c:if test="${b.status=='CHECKED_IN' || b.status=='COMPLETED' ||b.status=='PAYMENT_RECIVED_AWAITING_CONFIRMATION'}">
      <a href="/bookings/admin/invoice/pdf/${b.id}"
         class="btn btn-secondary btn-action"
         title="इनवॉइस">
         🧾
      </a>
    </c:if>

    <!-- CANCEL -->
    <c:if test="${b.status=='PENDING' || b.status=='PAYMENT_RECIVED_AWAITING_CONFIRMATION' || b.status=='CONFIRMED'}">
      <a href="/bookings/admin/cancel/${b.id}"
         onclick="return confirm('क्या बुकिंग रद्द करें?')"
         class="btn btn-danger btn-action"
         title="रद्द करें">
         ❌
      </a>
    </c:if>

  </td>

</tr>

</c:forEach>
</tbody>
</table>

<c:if test="${empty bookings}">
  <div class="text-center fw-bold">
    कोई बुकिंग नहीं मिली
  </div>
</c:if>

</div>
</div>

<%@ include file="/WEB-INF/views/includes/footer.jsp" %>
