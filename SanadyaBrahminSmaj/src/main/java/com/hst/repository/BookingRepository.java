package com.hst.repository;

import java.time.LocalDate;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.hst.entity.Booking;
import com.hst.entity.Building;
import com.hst.entity.Room;

public interface BookingRepository extends JpaRepository<Booking, Long> {
    List<Booking> findByBuildingAndDate(Building building, LocalDate date);
    
    List<Booking> findByRoomAndDate(Room room, LocalDate date);

    List<Booking> findByBuildingAndRoomIsNullAndDate(Building building, LocalDate date); // whole bldg
}
