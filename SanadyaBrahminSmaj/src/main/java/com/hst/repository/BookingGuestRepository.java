package com.hst.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import com.hst.entity.BookingSys.BookingGuest;

public interface BookingGuestRepository extends JpaRepository<BookingGuest, Long> {
	
	 List<BookingGuest> findByBookingId(Long bookingId);
}
