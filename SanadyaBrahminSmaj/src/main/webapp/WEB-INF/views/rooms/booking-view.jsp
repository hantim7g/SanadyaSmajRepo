<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>

<style>
body{
  background:#fffaf4;
  font-family:'Segoe UI','Noto Sans Devanagari',sans-serif;
}
.main-width{max-width:1100px;margin:auto;}
.cardx{
  background:linear-gradient(93deg,#ffedc2 65%,#fca854 100%);
  border-radius:18px;
  padding:22px;
}
.section{
  font-weight:800;
  color:#7a4200;
  border-bottom:1px dashed #e7c089;
  margin:20px 0;
}
.timeline{
  display:flex;
  justify-content:space-between;
  margin:25px 0;
}
.step{
  text-align:center;
  flex:1;
  position:relative;
}
.step:before{
  content:'';
  position:absolute;
  top:12px;
  left:50%;
  width:100%;
  height:3px;
  background:#ccc;
  z-index:-1;
}
.step:first-child:before{display:none;}
.dot{
  width:18px;height:18px;
  border-radius:50%;
  margin:auto;
  background:#ccc;
}
.done .dot{background:#28a745;}
.active .dot{background:#f59e0b;}
</style>

<div class="container main-width my-4">

<h3>👁 बुकिंग विवरण</h3>

<div class="cardx">

<!-- ================= BOOKING INFO ================= -->
<div class="section">📌 बुकिंग जानकारी</div>
<p><b>बुकिंग कोड:</b> ${booking.bookingCode}</p>
<p><b>स्थिति:</b> ${booking.status}</p>
<p><b>स्रोत:</b> ${booking.bookingSource}</p>
<p><b>बुकिंग तिथि:</b> ${booking.createdAt}</p>

<!-- ================= TIMELINE ================= -->
<div class="section">🕒 बुकिंग स्थिति</div>
<div class="timeline">
  <div class="step done">
    <div class="dot"></div>
    <div>बुक्ड</div>
  </div>

  <div class="step ${booking.actualCheckIn != null ? 'done' : 'active'}">
    <div class="dot"></div>
    <div>चेक-इन</div>
  </div>

  <div class="step ${booking.actualCheckOut != null ? 'done' : ''}">
    <div class="dot"></div>
    <div>चेक-आउट</div>
  </div>
</div>

<!-- ================= ROOM ================= -->
<div class="section">🏨 रूम</div>
<p>${booking.room.roomTypeLabel} - रूम ${booking.room.roomNumber}</p>
<p><b>फ्लोर:</b> ${booking.room.floorLabel}</p>

<!-- ================= DATES ================= -->
<div class="section">📅 तिथियाँ</div>
<p><b>चेक-इन:</b> ${booking.checkInDate}</p>
<p><b>चेक-आउट:</b> ${booking.checkOutDate}</p>

<c:if test="${not empty booking.actualCheckIn}">
<p><b>वास्तविक चेक-इन:</b> ${booking.actualCheckIn}</p>
</c:if>
<c:if test="${not empty booking.actualCheckOut}">
<p><b>वास्तविक चेक-आउट:</b> ${booking.actualCheckOut}</p>
</c:if>

<!-- ================= GUEST ================= -->
<div class="section">👤 मुख्य अतिथि</div>
<p><b>नाम:</b> ${booking.guestName}</p>
<p><b>मोबाइल:</b> ${booking.phone}</p>
<c:if test="${not empty booking.email}">
<p><b>ईमेल:</b> ${booking.email}</p>
</c:if>
<p><b>लॉगिन उपयोगकर्ता मोबाइल:</b> ${booking.loginUserMobile}</p>

<!-- ================= COUNT ================= -->
<div class="section">👥 अतिथि संख्या</div>
<p><b>वयस्क:</b> ${booking.adults}</p>
<p><b>बच्चे:</b> ${booking.children}</p>

<!-- ================= ADDRESS ================= -->
<div class="section">🏠 पता</div>
<p>
${booking.address}<br>
${booking.city}, ${booking.state} - ${booking.pinCode}<br>
${booking.nationality}
</p>

<!-- ================= EMERGENCY ================= -->
<div class="section">🚨 आपातकालीन संपर्क</div>
<p><b>नाम:</b> ${booking.emergencyContactName}</p>
<p><b>मोबाइल:</b> ${booking.emergencyContactPhone}</p>

<!-- ================= ID PROOF ================= -->
<div class="section">🪪 पहचान पत्र</div>
<p><b>प्रकार:</b> ${booking.idProofType}</p>
<p><b>नंबर:</b> ${booking.idProofNumber}</p>

<c:if test="${not empty booking.idProofFileUrl}">
  <c:set var="file" value="${booking.idProofFileUrl}" />

      <a href="/images/id-proof/${file}" target="_blank"
         class="btn btn-outline-primary btn-sm">
        📄 ID प्रूफ देखें
      </a>
  
</c:if>

<!-- ================= EXTRA GUESTS ================= -->
<div class="section">👥 अतिरिक्त अतिथि</div>
<table class="table table-bordered bg-white">
<thead>
<tr><th>नाम</th><th>आयु</th><th>लिंग</th></tr>
</thead>
<tbody>
<c:forEach items="${guests}" var="g">
<tr>
  <td>${g.name}</td>
  <td>${g.age}</td>
  <td>${g.gender}</td>
</tr>
</c:forEach>
</tbody>
</table>

<!-- ================= PAYMENT ================= -->
<div class="section">💰 भुगतान</div>
<p><b>कमरे का मूल्य:</b> ₹${booking.roomPrice}</p>
<p><b>डिस्काउंट:</b> ₹${booking.discountAmount}</p>
<p><b>कर:</b> ₹${booking.taxAmount}</p>
<p><b>कुल राशि:</b> ₹${booking.totalAmount}</p>
<p><b>भुगतान:</b> ₹${booking.paidAmount}</p>
<p><b>बकाया:</b> ₹${booking.balanceAmount}</p>
<p><b>होटल पर भुगतान:</b>
<c:choose>
  <c:when test="${booking.payAtHotel}">हाँ</c:when>
  <c:otherwise>नहीं</c:otherwise>
</c:choose>
</p>

<!-- ================= OTHER ================= -->
<div class="section">📝 अन्य</div>
<c:if test="${not empty booking.remarks}">
<p>${booking.remarks}</p>
</c:if>

<!-- ================= ACTION ================= -->
<div class="text-end mt-3">
  <a href="/bookings/admin" class="btn btn-secondary">⬅ वापस</a>
  <a href="/bookings/admin/invoice/pdf/${booking.id}"
     class="btn btn-success">🧾 इनवॉइस</a>
  <button onclick="printReceipt()" class="btn btn-warning">
    🧾 रसीद प्रिंट करें
  </button>
</div>

</div>
</div>

<script>
function printReceipt(){
  const win = window.open('', '', 'width=900,height=650');
  win.document.write(`
  <html><head><title>Booking Receipt</title>
  <style>
  body{font-family:Segoe UI;padding:20px;}
  table{width:100%;border-collapse:collapse;}
  th,td{border:1px solid #000;padding:8px;}
  </style>
  </head>
  <body>
  <h2 style="text-align:center">बुकिंग रसीद</h2>
  <table>
    <tr><th>बुकिंग कोड</th><td>${booking.bookingCode}</td></tr>
    <tr><th>अतिथि</th><td>${booking.guestName}</td></tr>
    <tr><th>मोबाइल</th><td>${booking.phone}</td></tr>
    <tr><th>रूम</th>
        <td>${booking.room.roomTypeLabel} - ${booking.room.roomNumber}</td></tr>
    <tr><th>चेक-इन</th><td>${booking.checkInDate}</td></tr>
    <tr><th>चेक-आउट</th><td>${booking.checkOutDate}</td></tr>
    <tr><th>कुल राशि</th><td>₹${booking.totalAmount}</td></tr>
  </table>
  <p>धन्यवाद 🙏</p>
  </body></html>
  `);
  win.document.close();
  win.print();
}
</script>

<%@ include file="/WEB-INF/views/includes/footer.jsp" %>
