<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>

<style>
body{background:#fffaf4;font-family:'Segoe UI','Noto Sans Devanagari',sans-serif;}
.main-width{max-width:1100px;margin:auto;}
.cardx{background:linear-gradient(93deg,#ffedc2 65%,#fca854 100%);
border-radius:18px;padding:22px;}
.section{font-weight:800;color:#7a4200;border-bottom:1px dashed #e7c089;margin:20px 0;}
</style>

<div class="container main-width my-4">

<h3>👁 बुकिंग विवरण</h3>

<div class="cardx">

<div class="section">📌 बुकिंग जानकारी</div>
<p><b>बुकिंग कोड:</b> ${booking.bookingCode}</p>
<p><b>स्थिति:</b> ${booking.status}</p>
<p><b>स्रोत:</b> ${booking.bookingSource}</p>

<div class="section">🏨 रूम</div>
<p>${booking.room.roomTypeLabel} - रूम ${booking.room.roomNumber}</p>

<div class="section">📅 तिथियाँ</div>
<p>${booking.checkInDate} → ${booking.checkOutDate}</p>

<div class="section">👤  अतिथि</div>
<p>${booking.guestName} (${booking.phone})</p>

<div class="section">👥 अतिरिक्त अतिथि</div>
<table class="table table-bordered bg-white">
<tr><th>नाम</th><th>आयु</th><th>लिंग</th></tr>
<c:forEach items="${guests}" var="g">
<tr>
<td>${g.name}</td>
<td>${g.age}</td>
<td>${g.gender}</td>
</tr>
</c:forEach>
</table>

<div class="section">💰 भुगतान</div>
<p>कुल राशि: ₹${booking.totalAmount}</p>
<p>भुगतान: ₹${booking.paidAmount}</p>
<p>बकाया: ₹${booking.balanceAmount}</p>

<div class="text-end mt-3">
<a href="/bookings/admin" class="btn btn-secondary">⬅ वापस</a>
<a href="/bookings/admin/invoice/${booking.id}"
   class="btn btn-success">🧾 इनवॉइस</a>
</div>

</div>
</div>

<%@ include file="/WEB-INF/views/includes/footer.jsp" %>
