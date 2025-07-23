package com.hst.service;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hst.entity.Booking;
import com.hst.entity.Building;
import com.hst.entity.Room;
import com.hst.repository.BookingRepository;
import com.hst.repository.BuildingRepository;
import com.hst.repository.RoomRepository;

@Service
public class BookingService {
    @Autowired BookingRepository bookingRepo;
    @Autowired RoomRepository roomRepo;
    @Autowired BuildingRepository buildingRepo;

    // Check if the building (whole) is already booked for this date
    public boolean isBuildingBooked(Long buildingId, LocalDate date) {
        Building building = buildingRepo.findById(buildingId).orElseThrow();
        return !bookingRepo.findByBuildingAndRoomIsNullAndDate(building, date).isEmpty();
    }
    // Check if any room is booked
    public boolean isAnyRoomBooked(Long buildingId, LocalDate date) {
        Building building = buildingRepo.findById(buildingId).orElseThrow();
        List<Room> rooms = roomRepo.findAll().stream()
           .filter(r -> r.getBuilding().getId().equals(buildingId))
           .collect(Collectors.toList());
        for (Room room : rooms) {
            if (!bookingRepo.findByRoomAndDate(room, date).isEmpty()) return true;
        }
        return false;
    }
    // Attempt booking
    public String book(Building building, Room room, LocalDate date, String status, String bookedBy, String specialRequest) {
        // Whole building booking
        if ("building".equals(status)) {
            if (isAnyRoomBooked(building.getId(), date) || isBuildingBooked(building.getId(), date)) {
                return "Cannot book: Rooms or Hall already booked!";
            }
            // Create booking for building
            Booking b = new Booking();
            b.setBuilding(building);
            b.setRoom(null);
            b.setDate(date);
            b.setStatus("building");
            b.setBookedBy(bookedBy);
            b.setSpecialRequest(specialRequest);
            bookingRepo.save(b);
            return "BUILDING_BOOKED";
        } else if ("room".equals(status) && room != null) {
            if (isBuildingBooked(building.getId(), date)) {
                return "Cannot book: Whole building already booked!";
            }
            // Create booking for room/hall
            Booking b = new Booking();
            b.setBuilding(building);
            b.setRoom(room);
            b.setDate(date);
            b.setStatus("room");
            b.setBookedBy(bookedBy);
            b.setSpecialRequest(specialRequest);
            bookingRepo.save(b);
            return "ROOM_BOOKED";
        }
        return "Booking failed.";
    }
}
