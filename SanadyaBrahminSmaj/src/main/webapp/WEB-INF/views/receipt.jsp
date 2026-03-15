<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>

<!--<!DOCTYPE html>
<html lang="hi">
<head>-->
<!DOCTYPE html>
<html>

<head>

<title>Booking Receipt</title>

<!--<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">


-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/qrcodejs/qrcode.min.js"></script>

<style>

body{
background:#f5f5f5;
font-family:"Noto Sans Devanagari", sans-serif;
}

.invoice-card{
background:white;
padding:35px;
border-radius:10px;
box-shadow:0 5px 20px rgba(0,0,0,0.15);
}

.header-title{
font-size:30px;
font-weight:bold;
color:#7a4200;
}

.sub-title{
font-size:18px;
color:#5e3400;
font-weight:bold;
}

.section{
margin-top:20px;
font-weight:bold;
color:#7a4200;
}

.table-head{
background:#ffe0b3;
}

.total-row{
background:#fff3d6;
font-weight:bold;
}

.footer{
font-size:12px;
color:#777;
text-align:center;
margin-top:20px;
}

</style>

</head>

<body>
	<div  id="invoicePrint">
<div class="container mt-5">

<div class="invoice-card" id="invoice">

<div class="row">

<div class="col-md-8">

<div class="header-title">सनाढ्य ब्राह्मण महासभा</div>
<div class="sub-title">बुकिंग रसीद</div>

</div>

<div class="col-md-4 text-end">
<!--<img src="/images/logo.png" width="90">-->
</div>

</div>

<hr>

<!-- BOOKING DETAILS -->

<div class="section">बुकिंग विवरण</div>

<p>
<b>बुकिंग कोड :</b> ${booking.bookingCode} <br>
<b>रूम :</b> ${booking.room.roomNumber} <br>
<b>स्थिति :</b> ${booking.status}
</p>

<!-- GUEST -->

<div class="section">अतिथि</div>

<p>
<b>नाम :</b> ${booking.guestName} <br>
<b>मोबाइल :</b> ${booking.phone}
</p>

<!-- GUEST TABLE -->

<div class="section">अतिथि सूची</div>

<table class="table table-bordered">

<thead class="table-head">

<tr>
<th>#</th>
<th>नाम</th>
<th>आयु</th>
</tr>

</thead>

<tbody>
	<tr>
	<td>${s.index+1}</td>
	<td>${booking.guestName}</td>
	<td>NA</td>
	</tr>
<c:forEach items="${guests}" var="g" varStatus="s">

<tr>
<td>${s.index+2}</td>
<td>${g.name}</td>
<td>${g.age}</td>
</tr>

</c:forEach>

</tbody>

</table>

<!-- STAY -->

<div class="section">प्रवास</div>

<p>

<b>चेक-इन :</b> ${booking.checkInDate} <br>
<b>चेक-आउट :</b> ${booking.checkOutDate} <br>
<b>रातें :</b> ${nights}

</p>

<!-- PAYMENT -->

<div class="section">भुगतान</div>

<table class="table table-bordered">

<thead class="table-head">

<tr>
<th>विवरण</th>
<th>मूल्य</th>
</tr>

</thead>

<tbody>

<tr>
<td>ट्रांजैक्शन आईडी</td>
<td>${payment.transactionId}</td>
</tr>

<tr>
<td>भुगतान मोड</td>
<td>${payment.paymentMode}</td>
</tr>

<tr>
<td>भुगतान तिथि</td>
<td>${payment.paymentDate}</td>
</tr>

<tr>
<td>स्थिति</td>
<td>

<span class="badge 
${payment.status=='Success'?'bg-success':
payment.status=='Pending'?'bg-warning':'bg-danger'}">

${payment.status}

</span>

</td>
</tr>

<tr>
<td>राशि</td>
<td>₹ ${payment.amount}</td>
</tr>

</tbody>

</table>

<!-- INVOICE -->

<div class="section">GST विवरण</div>

<table class="table table-bordered">

<thead class="table-head">

<tr>
<th>विवरण</th>
<th class="text-end">राशि</th>
</tr>

</thead>

<tbody>

<tr>
<td>रूम शुल्क</td>
<td class="text-end">${booking.roomPrice}</td>
</tr>

<tr>
<td>छूट</td>
<td class="text-end">${booking.discountAmount}</td>
</tr>

<tr>
<td>कर</td>
<td class="text-end">${booking.taxAmount}</td>
</tr>

<tr class="total-row">
<td>कुल राशि</td>
<td class="text-end">${booking.totalAmount}</td>
</tr>

<tr>
<td>भुगतान</td>
<td class="text-end">${booking.paidAmount}</td>
</tr>

<tr class="total-row">
<td>शेष</td>
<td class="text-end">${booking.balanceAmount}</td>
</tr>

</tbody>

</table>

<!-- QR -->

<div class="row mt-4">

<div class="col-md-8">

<!--<div class="section">QR सत्यापन</div>

<div id="qrcode"></div>
-->
</div>

<div class="col-md-4 text-end">
<button>	<a href="/bookings/invoice/pdf/${booking.id}"
	         class="btn btn-secondary btn-action"
	         title="इनवॉइस">
	         🧾इनवॉइस
	      </a></button>
	
</div>

</div>

<div class="footer">

यह कंप्यूटर द्वारा जनरेट की गई रसीद है | धन्यवाद

</div>

</div>

</div>
</div>
<script>

//var verifyUrl =
//location.origin + "/verify-booking/${booking.bookingCode}";

//new QRCode(document.getElementById("qrcode"),{
//text:verifyUrl,
//width:120,
//height:120
//});

function downloadPDF(){
 
const element = document.getElementById("invoicePrint");

html2pdf()
.from(element)
.save("booking-${booking.bookingCode}.pdf");

}

</script>

</body>
</html>