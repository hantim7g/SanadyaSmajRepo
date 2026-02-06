package com.hst.ViewController.Rooms;

import java.time.LocalDate;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hst.entity.BookingSys.Room;
import com.hst.entity.BookingSys.RoomBlock;
import com.hst.service.RoomBlockService;
import com.hst.service.RoomService;
@Controller
public class RoomBlockController {

//	@Autowired private RoomService roomService;
//	@Autowired private RoomBlockService roomBlockService;
//	
//	@PostMapping("rooms/admin/block")
//	@ResponseBody
//	public ResponseEntity<?> handleBlockRoom(@RequestBody Map<String, String> payload) {
//	    try {
//	        Long roomId = Long.parseLong(payload.get("roomId"));
//	        LocalDate from = LocalDate.parse(payload.get("fromDate"));
//	        LocalDate to = LocalDate.parse(payload.get("toDate"));
//	        String reason = payload.get("reason");
//
//	        Room room = roomService.getById(roomId);
//	        
//	        RoomBlock block = new RoomBlock();
//	        block.setRoom(room);
//	        block.setFromDate(from);
//	        block.setToDate(to);
//	        block.setReason(reason);
//
//	        roomBlockService.createBlock(block);
//	        
//	        return ResponseEntity.ok(Map.of("success", true, "message", "सफलतापूर्वक ब्लॉक किया गया"));
//	    } catch (Exception e) {
//	        return ResponseEntity.ok().body(Map.of("success", false, "message", e.getMessage()));
//	    }
//	}
	}
