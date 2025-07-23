package com.hst.ViewController;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hst.entity.Building;
import com.hst.entity.Room;
import com.hst.repository.BuildingRepository;
import com.hst.repository.RoomRepository;
import com.hst.service.BookingService;

@Controller
public class BookingController {
    @Autowired BuildingRepository buildingRepo;
    @Autowired RoomRepository roomRepo;
    @Autowired BookingService bookingService;

    // Show booking form
    @GetMapping("/booking")
    public String bookingPage(Model model, @RequestParam(required = false) LocalDate date) {
        model.addAttribute("buildings", buildingRepo.findAll());
        model.addAttribute("rooms", roomRepo.findAll());
        model.addAttribute("date", date == null ? LocalDate.now() : date);
        return "booking"; // JSP page
    }

    // AJAX call for availability
    @GetMapping("/api/availability")
    @ResponseBody
    public Map<String, Object> checkAvailability(@RequestParam Long buildingId, @RequestParam String date) {
        LocalDate d = LocalDate.parse(date);
        Map<String, Object> map = new HashMap<>();
        map.put("buildingBooked", bookingService.isBuildingBooked(buildingId, d));
        map.put("roomsBooked", bookingService.isAnyRoomBooked(buildingId, d));
        return map;
    }

    // Make a booking
    @PostMapping("/book")
    public String makeBooking(@RequestParam Long buildingId,
                              @RequestParam(required = false) Long roomId,
                              @RequestParam String status,
                              @RequestParam String bookedBy,
                              @RequestParam(required = false) String specialRequest,
                              @RequestParam String date,
                              Model model) {
        Building building = buildingRepo.findById(buildingId).orElseThrow();
        Room room = (roomId != null) ? roomRepo.findById(roomId).orElse(null) : null;
        String result = bookingService.book(building, room, LocalDate.parse(date), status, bookedBy, specialRequest);
        model.addAttribute("message", result);
        return "redirect:/booking?date=" + date;
    }
}
