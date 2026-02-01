package com.hst.util;

import java.math.BigDecimal;
import java.util.List;

import com.hst.entity.BookingSys.Booking;
import com.hst.entity.BookingSys.BookingGuest;

public class InvoiceXmlBuilder {

    public static String build(Booking b, List<BookingGuest> guests) {

        BigDecimal gst = b.getTotalAmount()
                .multiply(new BigDecimal("0.12"));

        return """
        <invoice>
            <bookingCode>%s</bookingCode>
            <guestName>%s</guestName>
            <phone>%s</phone>
            <room>%s</room>
            <checkIn>%s</checkIn>
            <checkOut>%s</checkOut>
            <roomPrice>%s</roomPrice>
            <gst>%s</gst>
            <total>%s</total>
        </invoice>
        """.formatted(
                b.getBookingCode(),
                b.getGuestName(),
                b.getPhone(),
                b.getRoom().getRoomNumber(),
                b.getCheckInDate(),
                b.getCheckOutDate(),
                b.getRoomPrice(),
                gst,
                b.getTotalAmount().add(gst)
        );
    }
}
