<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>

<title>Booking Receipt</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>

body{
    background:#f6f6f6;
    font-family: "Noto Sans Devanagari", sans-serif;
}

.receipt-card{
    background:white;
    border-radius:12px;
    padding:30px;
    box-shadow:0 5px 20px rgba(0,0,0,0.1);
}

.society-title{
    font-size:32px;
    font-weight:bold;
    color:#7a4200;
}

.sub-title{
    font-size:18px;
    font-weight:bold;
    color:#5e3400;
}

.table-header{
    background:#ffe0b3;
}

.total-row{
    background:#fff3d6;
    font-weight:bold;
}

.footer-note{
    font-size:12px;
    color:#777;
    text-align:center;
    margin-top:25px;
}

</style>

</head>


<body>

<div class="container mt-5">

<div class="receipt-card">

<!-- HEADER -->

<div class="row align-items-center">

<div class="col-md-8">

<div class="society-title">
सनाढ्य ब्राह्मण महासभा
</div>

<div class="sub-title">
बुकिंग रसीद
</div>

</div>

<div class="col-md-4 text-end">

<img src="/images/logo.png" width="90">

</div>

</div>

<hr>

<!-- BOOKING DETAILS -->

<div class="row mt-4">

<div class="col-md-6">

<p><b>बुकिंग कोड:</b> ${booking.bookingCode}</p>

<p><b>अतिथि का नाम:</b> ${booking.guestName}</p>

<p><b>मोबाइल नंबर:</b> ${booking.phone}</p>

</div>

<div class="col-md-6">

<p><b>रूम विवरण:</b> ${booking.room.roomNumber}</p>

<p><b>प्रवास अवधि:</b> ${booking.checkInDate} से ${booking.checkOutDate}</p>

</div>

</div>

<!-- PRICE TABLE -->

<table class="table table-bordered mt-4">

<thead class="table-header">

<tr>

<th>विवरण</th>

<th class="text-end">राशि (₹)</th>

</tr>

</thead>

<tbody>

<tr>

<td>रूम शुल्क</td>

<td class="text-end">${booking.roomPrice}</td>

</tr>

<tr>

<td>जीएसटी (12%)</td>

<td class="text-end">${gst}</td>

</tr>

<tr class="total-row">

<td>कुल देय राशि</td>

<td class="text-end">${total}</td>

</tr>

</tbody>

</table>

<!-- NOTES -->

<div class="mt-3">

<p>• जीएसटी लागू नियमों के अनुसार है</p>
<p>• भुगतान के पश्चात यह रसीद मान्य है</p>

</div>

<!-- FOOTER -->

<div class="footer-note">

यह कंप्यूटर द्वारा जनरेट की गई रसीद है | धन्यवाद

</div>

</div>

</div>

</body>
</html>