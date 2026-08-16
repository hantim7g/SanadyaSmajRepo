package com.hst.util;

import java.math.BigDecimal;
import java.time.temporal.ChronoUnit;
import java.util.List;

import com.hst.entity.BookingSys.Booking;
import com.hst.entity.BookingSys.BookingGuest;

public class InvoiceXmlBuilder {

	 public static String build(Booking booking, List<BookingGuest> guests) {

//	        BigDecimal gst = booking.getTotalAmount()
//	                .multiply(new BigDecimal("0.12"));
//
//	        BigDecimal total = booking.getTotalAmount().add(gst);

	        long nights = ChronoUnit.DAYS.between(
	                booking.getCheckInDate(),
	                booking.getCheckOutDate()
	        );

	        StringBuilder guestXml = new StringBuilder();
	        guestXml.append("""
                    <guest>
                        <name>%s</name>
                        <age>%s</age>
                    </guest>
                    """.formatted(
                    booking.getGuestName(),
                    "N/A" // age not stored at booking level
            ));
	        for (BookingGuest g : guests) {

	            guestXml.append("""
	                    <guest>
	                        <name>%s</name>
	                        <age>%s</age>
	                    </guest>
	                    """.formatted(
	                    g.getName(),
	                    g.getAge()
	            ));
	        }

	        String qrPath = "classpath:/qr/" + booking.getBookingCode() + ".png";

	        return """
	        <invoice>

	            <bookingCode>%s</bookingCode>
	            <guestName>%s</guestName>
	            <phone>%s</phone>
	            <room>%s</room>

	            <checkIn>%s</checkIn>
	            <checkOut>%s</checkOut>

	            <nights>%s</nights>

	            <bookingStatus>%s</bookingStatus>

	            <roomPrice>%s</roomPrice>
	            <gst>%s</gst>
	            <total>%s</total>

	            <transactionId>%s</transactionId>
	            <paymentMode>%s</paymentMode>
	            <paymentStatus>%s</paymentStatus>
	            <paymentDate>%s</paymentDate>

	            <guests>
	                %s
	            </guests>

	        </invoice>
	        """.formatted(
//	            <qrCodePath>%s</qrCodePath>

	                booking.getBookingCode(),
	                booking.getGuestName(),
	                booking.getPhone(),
	                booking.getRoom().getRoomNumber(),

	                booking.getCheckInDate(),
	                booking.getCheckOutDate(),

	                nights,

	                booking.getStatus(),

	                booking.getRoomPrice(),
	                booking.getTaxAmount(),
	                booking.getTotalAmount(),

	                booking.getPaymentTransactionId(), // transactionId fallback
	                booking.getPayAtHotel() ? "Pay At Hotel" : "Online",
	                booking.getBalanceAmount().compareTo(BigDecimal.ZERO) == 0
	                        ? "Success"
	                        : "Pending",
	                booking.getCreatedAt(),

//	                qrPath,

	                guestXml.toString()
	        );
	    }

}
