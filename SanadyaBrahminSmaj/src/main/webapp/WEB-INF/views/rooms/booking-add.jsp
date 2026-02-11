<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>

<!DOCTYPE html>
<html lang="hi">
<head>
<title>नई बुकिंग</title>

<style>
body{
  background:#fffaf4;
  font-family:'Segoe UI','Noto Sans Devanagari',sans-serif;
}
.main-width{max-width:1200px;margin:auto;}
.cardx{
  background:linear-gradient(93deg,#ffedc2 65%,#fca854 100%);
  border-radius:18px;
  padding:24px;
}
.section{
  font-weight:800;
  color:#7a4200;
  border-bottom:1px dashed #e7c089;
  margin:24px 0 12px;
}
.readonly{
  background:#fff3d6;
  font-weight:700;
}
.btnn{
  background:linear-gradient(95deg,#0ca100 60%,#32d653 100%);
  color:#fff;
  font-weight:700;
  border:none;
  border-radius:8px;
}
.text-danger{font-weight:700;}
.room-carousel{
  border-radius:18px;
  overflow:hidden;
  box-shadow:0 6px 22px rgba(160,128,32,0.35);
  margin-bottom:24px;
}
.room-carousel img{
  height:520px;
  object-fit:cover;
}
@media(max-width:768px){
  .room-carousel img{height:260px;}
}

/* only asterisk style */
.req{
  color:#c40000;
  font-weight:900;
}
</style>
</head>

<body>
<div class="container main-width my-4">

<h3 class="mb-3">➕ नई बुकिंग</h3>
<p><span class="req">*</span> चिन्हित फ़ील्ड अनिवार्य हैं</p>

<form:form modelAttribute="booking"
           method="post"
           action="/bookings/save"
           enctype="multipart/form-data"
           class="cardx">

<!-- ================= ROOM CAROUSEL ================= -->
<div class="room-carousel">
  <div id="roomCarousel" class="carousel slide" data-bs-ride="carousel">

    <div class="carousel-indicators">
      <c:forEach items="${booking.room.images}" var="img" varStatus="s">
        <button type="button"
                data-bs-target="#roomCarousel"
                data-bs-slide-to="${s.index}"
                class="${s.first?'active':''}"></button>
      </c:forEach>
    </div>

    <div class="carousel-inner">
      <c:forEach items="${booking.room.images}" var="img" varStatus="s">
        <div class="carousel-item ${s.first?'active':''}">
          <img src="${img.imageUrl}" class="d-block w-100">
        </div>
      </c:forEach>
    </div>

    <button class="carousel-control-prev" type="button" data-bs-target="#roomCarousel" data-bs-slide="prev">
      <span class="carousel-control-prev-icon"></span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#roomCarousel" data-bs-slide="next">
      <span class="carousel-control-next-icon"></span>
    </button>
  </div>
</div>

<!-- ================= ROOM INFO ================= -->
<div class="section">रूम चयन</div>

<select class="form-select readonly" disabled>
  <option>
    ${booking.room.roomTypeLabel} - ${booking.room.roomNumber}
    (${booking.room.priceLabel})
  </option>
</select>

<input type="hidden" name="room.id" value="${booking.room.id}"/>

<!-- ================= GUEST ================= -->
<div class="section">अतिथि <span class="req">*</span></div>

<input name="guestName" class="form-control" placeholder="अतिथि का नाम *" required>
<form:errors path="guestName" class="text-danger"/>

<input name="phone" class="form-control mt-2" placeholder="मोबाइल नंबर *" required>
<form:errors path="phone" class="text-danger"/>


<input name="email" class="form-control mt-2" placeholder="ईमेल (वैकल्पिक)">

<!-- ================= DATES ================= -->
<div class="section">तिथियाँ <span class="req">*</span></div>

<input type="date" name="checkInDate"
       class="form-control readonly"
       value="${booking.checkInDate}" readonly>

<input type="date" name="checkOutDate"
       class="form-control mt-2 readonly"
       value="${booking.checkOutDate}" readonly>

<!-- ================= PRICE ================= -->
<div class="section">बुकिंग सारांश</div>

<div class="row g-3">
  <div class="col-md-4">
    <label>कुल रातें</label>
    <input id="totalNights" class="form-control readonly" readonly>
  </div>
  <div class="col-md-4">
    <label>प्रति रात (₹)</label>
    <input id="pricePerNight"
           class="form-control readonly"
           value="${booking.room.basePrice}"
           readonly>
  </div>
  <div class="col-md-4">
    <label>कुल राशि (₹)</label>
    <input id="estimatedAmount" class="form-control readonly" readonly>
  </div>
</div>

<!-- ================= ADDRESS ================= -->
<div class="section">पता <span class="req">*</span></div>

<input name="address" class="form-control" placeholder="पूरा पता *" required>
<input name="city" class="form-control mt-2" placeholder="शहर *" required>
<input name="state" class="form-control mt-2" placeholder="राज्य *" required>
<input name="pinCode" class="form-control mt-2" placeholder="पिन कोड *" required>
<input name="nationality" class="form-control mt-2" value="भारतीय" placeholder="राष्ट्रीयता *" required>

<!-- ================= EMERGENCY ================= -->
<div class="section">आपातकालीन संपर्क <span class="req">*</span></div>

<input name="emergencyContactName" class="form-control" placeholder="नाम *" required>
<input name="emergencyContactPhone" class="form-control mt-2" placeholder="मोबाइल *" required>

<!-- ================= ID PROOF ================= -->
<div class="section">पहचान पत्र <span class="req">*</span></div>

<select name="idProofType" class="form-select" required>
  <option value="">ID प्रूफ चुनें *</option>
  <option value="AADHAR">आधार</option>
  <option value="PAN">पैन</option>
  <option value="PASSPORT">पासपोर्ट</option>
</select>

<input name="idProofNumber" class="form-control mt-2" placeholder="ID नंबर *" required>

<input type="file"
       name="idProofFile"
       class="form-control mt-2"
       accept=".jpg,.jpeg,.png,.pdf"
       required>

<!-- ================= EXTRA GUESTS ================= -->
<div class="section">अतिरिक्त अतिथि</div>

<table class="table table-bordered" id="guestTable">
<thead>
<tr><th>नाम</th><th>आयु</th><th>लिंग</th><th></th></tr>
</thead>
<tbody></tbody>
</table>

<button type="button" class="btn btn-info btn-sm" onclick="addGuest()">➕ अतिथि जोड़ें</button>

<!-- ================= REMARKS ================= -->
<div class="section">अन्य</div>
<textarea name="remarks" class="form-control" rows="3"></textarea>

<!-- ================= ACTION ================= -->
<div class="text-end mt-4">
  <button class="btn btnn px-4">बुकिंग सहेजें</button>
  <a href="/rooms/view" class="btn btn-secondary ms-2">वापस</a>
</div>

</form:form>
</div>

<!-- ================= JS ================= -->
<script>
(function(){
  const inD="${booking.checkInDate}";
  const outD="${booking.checkOutDate}";
  const price=document.getElementById("pricePerNight").value;
  if(!inD||!outD||!price)return;
  const a=new Date(inD+"T12:00");
  const b=new Date(outD+"T12:00");
  const n=(b-a)/(1000*60*60*24);
  document.getElementById("totalNights").value=n;
  document.getElementById("estimatedAmount").value="₹"+(n*price).toFixed(2);
})();

function addGuest(){
  document.querySelector("#guestTable tbody").insertAdjacentHTML("beforeend",`
  <tr>
    <td><input name="guestNames" class="form-control"></td>
    <td><input name="guestAges" type="number" class="form-control"></td>
    <td>
      <select name="guestGenders" class="form-select">
        <option value="पुरुष">पुरुष</option>
        <option value="महिला">महिला</option>
      </select>
    </td>
    <td>
      <button type="button" class="btn btn-danger btn-sm"
        onclick="this.closest('tr').remove()">❌</button>
    </td>
  </tr>
  `);
}
</script>

<%@ include file="/WEB-INF/views/includes/footer.jsp" %>
</body>
</html>
