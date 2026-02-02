<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>

<style>
body{
  background:#fffaf4;
  font-family:'Segoe UI','Noto Sans Devanagari',sans-serif;
}
.main-width{max-width:1200px;margin:auto;}

.cardx{
  background:linear-gradient(93deg,#ffedc2 65%,#fca854 100%);
  border-radius:18px;
  padding:18px;
  box-shadow:0 2px 16px rgba(160,128,32,.15);
}

.section-title{
  font-weight:800;
  color:#7a4200;
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

.btn-action{
  padding:4px 8px;
  font-size:13px;
}
</style>

<div class="container main-width my-4">

<h3 class="mb-3">📋 मेरी बुकिंग</h3>

<div class="cardx">
<div class="section-title">📑 आपकी बुकिंग सूची</div>

<table class="table table-bordered table-hover bg-white align-middle">
<thead class="table-light">
<tr>
  <th>बुकिंग कोड</th>
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

  <!-- BOOKING CODE -->
  <td><strong>${b.bookingCode}</strong></td>

  <!-- ROOM -->
  <td>
    ${b.room.roomTypeLabel}<br>
    <small>रूम ${b.room.roomNumber}</small>
  </td>

  <!-- DATES -->
  <td>
    ${b.checkInDate} → ${b.checkOutDate}
  </td>

  <!-- NIGHTS -->
  <td>
    ${b.checkOutDate.toEpochDay() - b.checkInDate.toEpochDay()}
  </td>

  <!-- AMOUNT -->
  <td>
    ₹${b.totalAmount}<br>
    <small>Paid: ₹${b.paidAmount}</small>
  </td>

  <!-- STATUS -->
  <td>
    <span class="badge-status ${b.status}">
      ${b.status}
    </span>
  </td>

  <!-- ACTIONS -->
  <td>

    <!-- VIEW DETAILS -->
    <a href="/bookings/view/${b.id}"
       class="btn btn-info btn-action"
       title="बुकिंग देखें">
       👁 देखें
    </a>

    <!-- INVOICE (ONLY AFTER STAY STARTED / COMPLETED) -->
    <c:if test="${b.status == 'CHECKED_IN' || b.status == 'COMPLETED'}">
      <a href="/bookings/invoice/pdf/${b.id}"
         class="btn btn-secondary btn-action"
         title="इनवॉइस">
         🧾
      </a>
    </c:if>

    <!-- CANCEL (ONLY BEFORE CHECK-IN) -->
    <c:if test="${b.status == 'PENDING' || b.status == 'CONFIRMED'}">
      <a href="/bookings/cancel/${b.id}"
         onclick="return confirm('क्या आप बुकिंग रद्द करना चाहते हैं?')"
         class="btn btn-danger btn-action"
         title="बुकिंग रद्द करें">
         ❌ रद्द करें
      </a>
    </c:if>

  </td>

</tr>

</c:forEach>
</tbody>
</table>

<c:if test="${empty bookings}">
  <div class="text-center fw-bold">
    आपकी कोई बुकिंग उपलब्ध नहीं है
  </div>
</c:if>

</div>
</div>

<%@ include file="/WEB-INF/views/includes/footer.jsp" %>
