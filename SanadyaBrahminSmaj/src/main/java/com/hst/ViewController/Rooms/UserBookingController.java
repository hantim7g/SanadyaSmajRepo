package com.hst.ViewController.Rooms;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.hst.entity.BookingSys.Booking;
import com.hst.entity.BookingSys.BookingStatus;
import com.hst.repository.BookingRepository;

@Controller
public class UserBookingController {

    @Autowired
    private BookingRepository bookingRepo;

    /* ================= MY BOOKINGS ================= */
    @GetMapping("/my-bookings")
    public String myBookings(Principal principal, Model model) {

        String loginMobile = principal.getName(); 
        // ⬆ assumes username = mobile (as per your pattern)

        List<Booking> bookings =
                bookingRepo.findByLoginUserMobileOrderByCreatedAtDesc(loginMobile);

        model.addAttribute("bookings", bookings);
        return "rooms/my-bookings";
    }

    /* ================= VIEW BOOKING ================= */
    @GetMapping("/bookings/view/{id}")
    public String viewBooking(@PathVariable Long id,
                              Principal principal,
                              Model model) {

        Booking booking = bookingRepo.findById(id).orElseThrow();

        if (!booking.getLoginUserMobile().equals(principal.getName())) {
            throw new RuntimeException("Unauthorized access");
        }

        model.addAttribute("booking", booking);
        return "rooms/booking-view";
    }

    /* ================= CANCEL BOOKING ================= */
    @GetMapping("/bookings/cancel/{id}")
    public String cancelBooking(@PathVariable Long id,
                                Principal principal) {

        Booking booking = bookingRepo.findById(id).orElseThrow();

        if (!booking.getLoginUserMobile().equals(principal.getName())) {
            throw new RuntimeException("Unauthorized access");
        }

        if (booking.getStatus() == BookingStatus.PENDING
         || booking.getStatus() == BookingStatus.CONFIRMED) {

            booking.setStatus(BookingStatus.CANCELLED);
            bookingRepo.save(booking);
        }

        return "redirect:/my-bookings";
    }
}
