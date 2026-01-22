package com.hst.ViewController.Rooms;

import com.hst.entity.BookingSys.Room;
import com.hst.entity.BookingSys.RoomImage;
import com.hst.service.RoomService;

import jakarta.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

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
    public String roomList(Model model) {
        model.addAttribute("rooms", roomService.getAll());
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
        Room existing = null;

        // If edit
        if (room.getId() != null) {
            existing = roomService.getById(room.getId());

            existing.setRoomNumber(room.getRoomNumber());
            existing.setRoomType(room.getRoomType());
            existing.setFloor(room.getFloor());
            existing.setBasePrice(room.getBasePrice());
            existing.setStatus(room.getStatus());
            room = existing;
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
                    img.setRoom(room);

                    room.getImages().add(img);
                }
            }
        }

        room.setIsActive(true);
        roomService.save(room);

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
}
