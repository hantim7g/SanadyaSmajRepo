package com.hst.service;

import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;

import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

import com.hst.dto.RoomFilterDTO;
import com.hst.entity.BookingSys.BookingStatus;
import com.hst.entity.BookingSys.Room;
import com.hst.entity.BookingSys.RoomImage;
import com.hst.entity.BookingSys.RoomStatus;
import com.hst.repository.RoomRepository;

import jakarta.persistence.criteria.Predicate;
import jakarta.transaction.Transactional;
@Service
public class RoomService {

    @Autowired
    private RoomRepository repo;

    public List<Room> getAll() {
        return repo.findAll();
    }

    public List<Room> getActive() {
        return repo.findByIsActiveTrue();
    }

    public Room getById(Long id) {
        return repo.findById(id)
                .orElseThrow(() -> new RuntimeException("Room not found"));
    }
    public Room save(Room room) {
        return repo.save(room);
    }

    public void delete(Long id) {
        repo.deleteById(id);
    }
    @Transactional
    public void deleteWithImages(Long id, String uploadDir) {
        Room room = getById(id);

        for (RoomImage img : room.getImages()) {
            try {
                Path path = Paths.get(uploadDir + "/" + img.getImageUrl());
                Files.deleteIfExists(path);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        repo.delete(room);
    }
    public List<Room> search(RoomFilterDTO f) {

        if (f.getFromDate() != null && f.getToDate() != null) {
        	return repo.findAvailableRoomsWithStrictFloorRule(
        	        f.getFromDate(),
        	        f.getToDate(),
        	        RoomStatus.AVAILABLE,
        	        List.of(
        	            BookingStatus.CONFIRMED,
        	            BookingStatus.CHECKED_IN
        	        )
        	);

            
        }

        // fallback (no date filter)
        return repo.findAll((root, query, cb) -> {

            List<Predicate> predicates = new ArrayList<>();

            predicates.add(cb.isTrue(root.get("isActive")));
            predicates.add(cb.equal(root.get("status"), RoomStatus.AVAILABLE));

            if (f.getRoomType() != null)
                predicates.add(cb.equal(root.get("roomType"), f.getRoomType()));

            if (f.getFloor() != null)
                predicates.add(cb.equal(root.get("floor"), f.getFloor()));

            if (f.getMinPrice() != null)
                predicates.add(cb.ge(root.get("basePrice"), f.getMinPrice()));

            if (f.getMaxPrice() != null)
                predicates.add(cb.le(root.get("basePrice"), f.getMaxPrice()));

            return cb.and(predicates.toArray(new Predicate[0]));
        });
    }

    public List<Room> adminSearch(
    	    String roomType,
    	    RoomStatus status,
    	    Boolean isActive,
    	    String floor,
    	    BigDecimal maxPrice
    	) {
    	    return repo.findAll((root, q, cb) -> {
    	        List<Predicate> p = new ArrayList<>();

    	        if (roomType != null && !roomType.isBlank())
    	            p.add(cb.equal(root.get("roomType"), roomType));

    	        if (status != null)
    	            p.add(cb.equal(root.get("status"), status));

    	        if (isActive != null)
    	            p.add(cb.equal(root.get("isActive"), isActive));

    	        if (floor != null && !floor.isBlank())
    	            p.add(cb.equal(root.get("floor"), floor));

    	        if (maxPrice != null)
    	            p.add(cb.lessThanOrEqualTo(root.get("basePrice"), maxPrice));

    	        return cb.and(p.toArray(new Predicate[0]));
    	    });
    	}
 
}
