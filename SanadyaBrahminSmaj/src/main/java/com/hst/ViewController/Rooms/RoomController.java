package com.hst.ViewController.Rooms;

import com.hst.dto.RoomFilterDTO;
import com.hst.entity.BookingSys.Room;
import com.hst.entity.BookingSys.RoomBlock;
import com.hst.entity.BookingSys.RoomImage;
import com.hst.entity.BookingSys.RoomStatus;
import com.hst.service.RoomBlockService;
import com.hst.service.RoomService;

import jakarta.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.util.*;

@Controller
@RequestMapping("/rooms")
public class RoomController {

    @Value("${upload.image.dir}")
    private String uploadDir;

    @Autowired
    private RoomService roomService;

 // List page
    @Autowired
    private RoomBlockService roomBlockService;
    @GetMapping("/admin")
    public String adminRoomList(RoomFilterDTO filter, Model model) {
        
        // 1. यदि तारीखें नहीं चुनी गई हैं, तो आज और कल की तारीख डिफॉल्ट सेट करें
        if (filter.getFromDate() == null) {
            filter.setFromDate(LocalDate.now());
        }
        if (filter.getToDate() == null) {
            filter.setToDate(LocalDate.now().plusDays(1));
        }

        // 2. रिक्त स्ट्रिंग्स को नल में बदलें (SQL के लिए सुरक्षित)
        if (filter.getRoomType() != null && filter.getRoomType().isBlank()) filter.setRoomType(null);
        if (filter.getFloor() != null && filter.getFloor().isBlank()) filter.setFloor(null);

        // 3. सर्विस से Map प्राप्त करें: Key = Room, Value = 'AVAILABLE' | 'BOOKED' | 'BLOCKED'
        Map<Room, String> roomStatusMap = roomService.searchAdminRooms(filter);

        model.addAttribute("rooms", roomStatusMap);
        model.addAttribute("filter", filter); // फॉर्म में वैल्यू बनाए रखने के लिए
        
        // सक्रिय ब्लॉक्स की सूची (Management Table के लिए)
        model.addAttribute("activeBlocks", roomBlockService.getAllActiveBlocks());
        
        return "rooms/room-list";
    }

    /**
     * रूम ब्लॉक करने के लिए API
     */
    @PostMapping("/admin/block")
    @ResponseBody
    public ResponseEntity<?> handleBlockRoom(@RequestBody Map<String, String> payload) {
        try {
            Long roomId = Long.parseLong(payload.get("roomId"));
            LocalDate from = LocalDate.parse(payload.get("fromDate"));
            LocalDate to = LocalDate.parse(payload.get("toDate"));
            String reason = payload.get("reason");

            Room room = roomService.getById(roomId);
            
            RoomBlock block = new RoomBlock();
            block.setRoom(room);
            block.setFromDate(from);
            block.setToDate(to);
            block.setReason(reason);

            roomBlockService.createBlock(block);
            
            return ResponseEntity.ok(Map.of(
                "success", true, 
                "message", "रूम सफलतापूर्वक ब्लॉक कर दिया गया है।"
            ));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of(
                "success", false, 
                "message", e.getMessage()
            ));
        }
    }

    /**
     * रूम अनब्लॉक (डिलीट) करने के लिए API
     */
    @DeleteMapping("/admin/unblock/{id}")
    @ResponseBody
    public ResponseEntity<?> unblock(@PathVariable Long id) {
        try {
            roomBlockService.deleteBlock(id);
            return ResponseEntity.ok(Map.of("success", true));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of("success", false, "message", e.getMessage()));
        }
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
    	RoomFilterDTO filter=new RoomFilterDTO();
	
    	filter.setFromDate(LocalDate.now());
    	filter.setToDate(LocalDate.now().plusDays(1));
		

    	
    	if (filter.getFromDate() == null || filter.getToDate() == null) {
    	    return "rooms/room-cards"; // empty
    	}
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
        return "rooms/rooms-view";
    }
    @GetMapping("/filter")
    public String filter(RoomFilterDTO filter, Model model) {
    	if (filter.getFromDate() == null || filter.getToDate() == null) {
    	    return "rooms/room-cards"; // empty
    	}
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
