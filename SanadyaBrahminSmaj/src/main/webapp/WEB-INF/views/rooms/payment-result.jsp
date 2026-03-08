<h2>Payment Result</h2>

<c:if test="${booking.status == 'CONFIRMED'}">
    <h3 style="color:green;">Payment Successful</h3>
    Booking Code: ${booking.bookingCode}
</c:if>

<c:if test="${booking.status == 'PAYMENT_FAILED'}">
    <h3 style="color:red;">Payment Failed</h3>
</c:if>