package com.hst.repository;


import java.time.LocalDate;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.hst.entity.BookingSys.Booking;
import com.hst.entity.BookingSys.BookingStatus;

public interface BookingRepository extends JpaRepository<Booking, Long> {
    List<Booking> findByStatus(BookingStatus status);

    @Query("""
        SELECT b FROM Booking b
        WHERE (:bookingCode IS NULL OR b.bookingCode LIKE %:bookingCode%)
          AND (:guestName IS NULL OR
               LOWER(b.guestName) LIKE LOWER(CONCAT('%', :guestName, '%'))
               OR b.phone LIKE %:guestName%)
          AND (:status IS NULL OR b.status = :status)
          AND (:fromDate IS NULL OR b.checkInDate >= :fromDate)
          AND (:toDate IS NULL OR b.checkOutDate <= :toDate)
        ORDER BY b.createdAt DESC
    """)
    List<Booking> filterBookings(
        @Param("bookingCode") String bookingCode,
        @Param("guestName") String guestName,
        @Param("status") BookingStatus status,
        @Param("fromDate") LocalDate fromDate,
        @Param("toDate") LocalDate toDate
    );
    @Query("""
            SELECT COUNT(b)
            FROM Booking b
            WHERE YEAR(b.createdAt) = :year
        """)
        long countByYear(@Param("year") int year);
    
    @Query("""
    		SELECT COUNT(b) > 0 FROM Booking b
    		WHERE b.status IN ('CONFIRMED', 'CHECKED_IN')
    		AND b.room.floor = :floor
    		AND b.checkInDate < :toDate
    		AND b.checkOutDate > :fromDate
    		""")
    		boolean existsFloorConflict(
    		        String floor,
    		        LocalDate fromDate,
    		        LocalDate toDate
    		);

    List<Booking> findByLoginUserMobileOrderByCreatedAtDesc(String loginUserMobile);

//	boolean existsByRoomAndDates(Long id, LocalDate fromDate, LocalDate toDate);
	@Query("""
	        SELECT COUNT(b) > 0 FROM Booking b 
	        WHERE (b.room.id = :roomId 
	               OR (b.room.roomType = 'COMPLETE_FLOOR' AND b.room.floor = :floor)
	               OR b.room.roomType = 'COMPLETE_BUILDING')
	        AND b.status IN (com.hst.entity.BookingSys.BookingStatus.CONFIRMED, 
	                         com.hst.entity.BookingSys.BookingStatus.CHECKED_IN)
	        AND b.checkInDate < :toDate 
	        AND b.checkOutDate > :fromDate
	    """)
	    boolean hasExistingBooking(
	        @Param("roomId") Long roomId, 
	        @Param("floor") String floor,
	        @Param("fromDate") LocalDate fromDate, 
	        @Param("toDate") LocalDate toDate
	    );
}
