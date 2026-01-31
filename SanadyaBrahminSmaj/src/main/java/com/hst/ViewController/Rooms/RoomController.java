package com.hst.ViewController.Rooms;

import com.hst.dto.RoomFilterDTO;
import com.hst.entity.BookingSys.Room;
import com.hst.entity.BookingSys.RoomImage;
import com.hst.entity.BookingSys.RoomStatus;
import com.hst.service.RoomService;

import jakarta.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;

@Controller
@RequestMapping("/rooms")
public class RoomController {

    @Value("${upload.image.dir}")
    private String uploadDir;

    @Autowired
    private RoomService roomService;

 // List page
    @GetMapping("/admin")
    public String roomList(RoomFilterDTO filter, Model model) {

        // empty string → null (important for LIKE / equals)
        if (filter.getRoomType() != null && filter.getRoomType().isBlank()) {
            filter.setRoomType(null);
        }

        if (filter.getFloor() != null && filter.getFloor().isBlank()) {
            filter.setFloor(null);
        }

        model.addAttribute("rooms", roomService.search(filter));
        return "rooms/room-list";
    }


    // Add form
    @GetMapping("/admin/add")
    public String addRoom(Model model) {
        model.addAttribute("room", new Room());
        return "rooms/room-form";
    }

    // Edit form
    @GetMapping("/admin/edit/{id}")
    public String editRoom(@PathVariable Long id, Model model) {
        model.addAttribute("room", roomService.getById(id));
        return "rooms/room-form";
    }

    
    
    
    // Admin page
//    @GetMapping("/admin")
//    public String adminRooms(Model model) {
//        model.addAttribute("rooms", roomService.getAll());
//        model.addAttribute("room", new Room());
//        return "rooms/rooms";
//    }

    // ================= EDIT (AJAX GET) =================
    @ResponseBody
    @GetMapping("/get/{id}")
    public Room getRoom(@PathVariable Long id) {
        return roomService.getById(id);
    }

    
//    @PostMapping("/save")
//    public String saveRoom(@Valid @ModelAttribute Room room,
//                           BindingResult result,
//                           @RequestParam("files") MultipartFile[] files,
//                           Model model) throws Exception {
//
//        if (result.hasErrors()) {
//            model.addAttribute("room", room);
//            return "rooms/room-form"; // back to form with errors
//        }
//
//        roomService.saveOrUpdate(room, files);
//        return "redirect:/rooms/admin";
//    }
    // ================= SAVE / UPDATE =================
    @PostMapping("/save")
    public String saveRoom(@Valid @ModelAttribute Room room,BindingResult result,
                           @RequestParam(value = "files", required = false) MultipartFile[] files,Model model) throws Exception {

    	 if (result.hasErrors()) {
             model.addAttribute("room", room);
             return "rooms/room-form"; // back to form with errors
         }
    	  Room entity;

    	    if (room.getId() != null) {
    	        // ===== UPDATE =====
    	        entity = roomService.getById(room.getId());

    	        // 🔑 MERGE ONLY NON-NULL VALUES
    	        mergeNonNull(room, entity);

    	    } else {
    	        // ===== CREATE =====
    	        entity = room;
    	    }


        // Handle images
        if (files != null && files.length > 0) {
            for (MultipartFile file : files) {
                if (!file.isEmpty()) {

                    String fileName = UUID.randomUUID() + "_" + file.getOriginalFilename();
                    String relativePath = "rooms/" + fileName;
                    Path fullPath = Paths.get(uploadDir + "/" + relativePath);

                    Files.createDirectories(fullPath.getParent());
                    Files.copy(file.getInputStream(), fullPath);

                    RoomImage img = new RoomImage();
                    img.setImageUrl(relativePath);
                    img.setRoom(entity);

                    entity.getImages().add(img);
                }
            }
        }

        entity.setIsActive(true);
        roomService.save(entity);

        return "redirect:/rooms/admin";
    }

    // ================= DELETE =================
    @GetMapping("/delete/{id}")
    public String delete(@PathVariable Long id) {
        roomService.deleteWithImages(id, uploadDir);
        return "redirect:/rooms/admin";
    }

    // User view
    @GetMapping("/view")
    public String viewRooms(Model model) {
        model.addAttribute("rooms", roomService.getActive());
        return "rooms/rooms-view";
    }
    @GetMapping("/filter")
    public String filter(RoomFilterDTO filter, Model model) {
    	if(filter!=null &&filter.getRoomType()!=null && filter.getRoomType().isEmpty()) {
    		filter.setRoomType(null);
    	}
    	if (filter.getRoomType() != null && filter.getRoomType().isBlank()) {
    	    filter.setRoomType(null);
    	}

    	if (filter.getFloor() != null && filter.getFloor().isBlank()) {
    	    filter.setFloor(null);
    	}

      model.addAttribute("rooms", roomService.search(filter));
      return "rooms/room-cards";
    }
    
    private void mergeNonNull(Room src, Room dest) {

        // BASIC INFO
        if (src.getRoomNumber() != null)
            dest.setRoomNumber(src.getRoomNumber());

        if (src.getRoomType() != null)
            dest.setRoomType(src.getRoomType());

        if (src.getFloor() != null)
            dest.setFloor(src.getFloor());

        // PRICING
        if (src.getBasePrice() != null)
            dest.setBasePrice(src.getBasePrice());

        // STATUS
        if (src.getStatus() != null)
            dest.setStatus(src.getStatus());

        if (src.getIsActive() != null)
            dest.setIsActive(src.getIsActive());

        // STAY RULES
        if (src.getMinStay() != null)
            dest.setMinStay(src.getMinStay());

        if (src.getMaxStay() != null)
            dest.setMaxStay(src.getMaxStay());

        if (src.getAdvanceBookingDays() != null)
            dest.setAdvanceBookingDays(src.getAdvanceBookingDays());

        // AVAILABILITY
        if (src.getAvailableFrom() != null)
            dest.setAvailableFrom(src.getAvailableFrom());

        if (src.getAvailableTo() != null)
            dest.setAvailableTo(src.getAvailableTo());
    }

}
