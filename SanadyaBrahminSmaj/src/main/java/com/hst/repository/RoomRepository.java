package com.hst.repository;

import java.time.LocalDate;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.hst.entity.BookingSys.BookingStatus;
import com.hst.entity.BookingSys.Room;
import com.hst.entity.BookingSys.RoomStatus;

public interface RoomRepository extends JpaRepository<Room, Long>, JpaSpecificationExecutor<Room>  {
    List<Room> findByIsActiveTrue();
    
    @Query("""
    	    SELECT r FROM Room r
    	    WHERE r.isActive = true
    	    AND r.status = :availableStatus

    	    AND NOT EXISTS (
    	        SELECT b FROM Booking b
    	        WHERE b.room = r
    	        AND b.status IN (:bookingStatuses)
    	        AND b.checkInDate < :toDate
    	        AND b.checkOutDate > :fromDate
    	    )

    	    AND NOT EXISTS (
    	        SELECT fb FROM Booking fb
    	        WHERE fb.status IN (:bookingStatuses)
    	        AND fb.room.roomType IN ('COMPLETE_FLOOR','COMPLETE_Building')
    	        AND fb.room.floor = r.floor
    	        AND fb.checkInDate < :toDate
    	        AND fb.checkOutDate > :fromDate
    	    )
    	    """)
    	    List<Room> findAvailableRooms(
    	            @Param("fromDate") LocalDate fromDate,
    	            @Param("toDate") LocalDate toDate,
    	            @Param("availableStatus") RoomStatus availableStatus,
    	            @Param("bookingStatuses") List<BookingStatus> bookingStatuses
    	    );

    @Query("""
    	    SELECT r FROM Room r
    	    WHERE r.isActive = true
    	    AND r.status = :availableStatus
    	    
    	    -- 1. अगर 'पूरा भवन' बुक है, तो कुछ भी न दिखाएं (Rooms, Floors, Building सब गायब)
    	    AND NOT EXISTS (
    	        SELECT bb FROM Booking bb
    	        WHERE bb.status IN (:bookingStatuses)
    	        AND bb.room.roomType = 'COMPLETE_BUILDING'
    	        AND bb.checkInDate < :toDate
    	        AND bb.checkOutDate > :fromDate
    	    )

    	    -- 2. अगर यह विशिष्ट कमरा (r) बुक है, तो इसे न दिखाएं
    	    AND NOT EXISTS (
    	        SELECT b FROM Booking b
    	        WHERE b.room = r
    	        AND b.status IN (:bookingStatuses)
    	        AND b.checkInDate < :toDate
    	        AND b.checkOutDate > :fromDate
    	    )

    	    -- 3. अगर जिस फ्लोर पर यह कमरा है, उसका 'पूरा फ्लोर' बुक है, तो इसे न दिखाएं
    	    AND NOT EXISTS (
    	        SELECT fb FROM Booking fb
    	        WHERE fb.status IN (:bookingStatuses)
    	        AND fb.room.roomType = 'COMPLETE_FLOOR'
    	        AND fb.room.floor = r.floor
    	        AND fb.checkInDate < :toDate
    	        AND fb.checkOutDate > :fromDate
    	    )

    	    -- 4. फ्लोर बुकिंग नियम: अगर कोई 'COMPLETE_FLOOR' सर्च कर रहा है, 
    	    -- और उस फ्लोर का कोई भी एक कमरा बुक है, तो 'COMPLETE_FLOOR' हटा दें
    	    AND NOT (
    	        r.roomType = 'COMPLETE_FLOOR' 
    	        AND EXISTS (
    	            SELECT rb FROM Booking rb
    	            WHERE rb.status IN (:bookingStatuses)
    	            AND rb.room.floor = r.floor
    	            AND rb.room.roomType != 'COMPLETE_FLOOR'
    	            AND rb.checkInDate < :toDate
    	            AND rb.checkOutDate > :fromDate
    	        )
    	    )

    	    -- 5. भवन बुकिंग नियम (New): अगर कोई 'COMPLETE_BUILDING' सर्च कर रहा है,
    	    -- और डेटाबेस में किसी भी कमरे/फ्लोर की बुकिंग पहले से है, तो 'COMPLETE_BUILDING' हटा दें
    	    AND NOT (
    	        r.roomType = 'COMPLETE_BUILDING'
    	        AND EXISTS (
    	            SELECT anyB FROM Booking anyB
    	            WHERE anyB.status IN (:bookingStatuses)
    	            AND anyB.checkInDate < :toDate
    	            AND anyB.checkOutDate > :fromDate
    	        )
    	    )
    	    """)
    	List<Room> findAvailableRoomsWithStrictFloorRule(
    	        @Param("fromDate") LocalDate fromDate,
    	        @Param("toDate") LocalDate toDate,
    	        @Param("availableStatus") RoomStatus availableStatus,
    	        @Param("bookingStatuses") List<BookingStatus> bookingStatuses
    	);
    }



//AND NOT EXISTS (
//    SELECT ab FROM Booking ab
//    WHERE ab.status IN (:bookingStatuses)
//    AND ab.room.floor = r.floor
//    AND ab.checkInDate < :toDate
//    AND ab.checkOutDate > :fromDate
//)

