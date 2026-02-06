package com.hst.repository;

import java.math.BigDecimal;
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
    	    

    	    AND NOT EXISTS (
    	        SELECT b FROM Booking b
    	        WHERE (b.room = r 
    	               OR (b.room.roomType = 'COMPLETE_FLOOR' AND b.room.floor = r.floor)
    	               OR b.room.roomType = 'COMPLETE_BUILDING')
    	        AND b.status IN (:bookingStatuses)
    	        AND b.checkInDate < :toDate
    	        AND b.checkOutDate > :fromDate
    	    )

    	    AND NOT EXISTS (
    	        SELECT rb FROM RoomBlock rb
    	        WHERE (rb.room = r 
    	               OR (rb.room.roomType = 'COMPLETE_FLOOR' AND rb.room.floor = r.floor)
    	               OR rb.room.roomType = 'COMPLETE_BUILDING')
    	        AND rb.fromDate < :toDate
    	        AND rb.toDate > :fromDate
    	    )

    	    AND NOT (
    	        r.roomType = 'COMPLETE_FLOOR' 
    	        AND (
    	            EXISTS (SELECT b2 FROM Booking b2 WHERE b2.room.floor = r.floor AND b2.room.roomType != 'COMPLETE_FLOOR' AND b2.checkInDate < :toDate AND b2.checkOutDate > :fromDate)
    	            OR 
    	            EXISTS (SELECT rb2 FROM RoomBlock rb2 WHERE rb2.room.floor = r.floor AND rb2.room.roomType != 'COMPLETE_FLOOR' AND rb2.fromDate < :toDate AND rb2.toDate > :fromDate)
    	        )
    	    )
    	    AND NOT (
    	        r.roomType = 'COMPLETE_BUILDING'
    	        AND (
    	            EXISTS (SELECT b3 FROM Booking b3 WHERE b3.checkInDate < :toDate AND b3.checkOutDate > :fromDate)
    	            OR 
    	            EXISTS (SELECT rb3 FROM RoomBlock rb3 WHERE rb3.fromDate < :toDate AND rb3.toDate > :fromDate)
    	        )
    	    )
    	    """)
    	List<Room> findAvailableRoomsWithStrictFloorRule(
    	        @Param("fromDate") LocalDate fromDate,
    	        @Param("toDate") LocalDate toDate,
    	        @Param("availableStatus") RoomStatus availableStatus,
    	        @Param("bookingStatuses") List<BookingStatus> bookingStatuses
    	);
  
    @Query("""
    	    SELECT r, 
    	    (CASE 
    	        WHEN EXISTS (
    	            SELECT b FROM Booking b 
    	            WHERE (b.room = r 
    	                   OR (b.room.roomType = 'COMPLETE_FLOOR' AND b.room.floor = r.floor) 
    	                   OR b.room.roomType = 'COMPLETE_BUILDING')
    	            AND b.status IN :bookingStatuses
    	            AND b.checkInDate < :toDate AND b.checkOutDate > :fromDate
    	        ) THEN 'BOOKED'
    	        WHEN EXISTS (
    	            SELECT rb FROM RoomBlock rb 
    	            WHERE (rb.room = r 
    	                   OR (rb.room.roomType = 'COMPLETE_FLOOR' AND rb.room.floor = r.floor) 
    	                   OR rb.room.roomType = 'COMPLETE_BUILDING')
    	            AND rb.fromDate < :toDate AND rb.toDate > :fromDate
    	        ) THEN 'BLOCKED'
    	        ELSE 'AVAILABLE'
    	    END) as availabilityStatus
    	    FROM Room r
    	    WHERE (:isActive IS NULL OR r.isActive = :isActive)
    	    AND (:status IS NULL OR r.status = :status)
    	    AND (:roomType IS NULL OR r.roomType = :roomType)
    	    AND (:floor IS NULL OR r.floor = :floor)
    	    AND (:minPrice IS NULL OR r.basePrice >= :minPrice)
    	    AND (:maxPrice IS NULL OR r.basePrice <= :maxPrice)
    	""")
    	List<Object[]> findAdminRoomsWithStatus(
    	    @Param("isActive") Boolean isActive,
    	    @Param("status") RoomStatus status,
    	    @Param("roomType") String roomType,
    	    @Param("floor") String floor,
    	    @Param("minPrice") BigDecimal minPrice,
    	    @Param("maxPrice") BigDecimal maxPrice,
    	    @Param("fromDate") LocalDate fromDate,
    	    @Param("toDate") LocalDate toDate,
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

