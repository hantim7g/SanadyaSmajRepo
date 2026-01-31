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

        return repo.findAll((root, query, cb) -> {

            List<Predicate> predicates = new ArrayList<>();

            // ===== DEFAULT / MANDATORY FILTERS =====
            predicates.add(cb.isTrue(root.get("isActive")));
            predicates.add(cb.equal(root.get("status"), RoomStatus.AVAILABLE));

            // ===== ROOM TYPE =====
            if (f.getRoomType() != null && !f.getRoomType().isBlank()) {
                predicates.add(cb.equal(root.get("roomType"), f.getRoomType()));
            }

            // ===== FLOOR =====
            if (f.getFloor() != null && !f.getFloor().isBlank()) {
                predicates.add(cb.equal(root.get("floor"), f.getFloor()));
            }

            // ===== PRICE RANGE =====
            if (f.getMinPrice() != null) {
                predicates.add(cb.ge(root.get("basePrice"), f.getMinPrice()));
            }

            if (f.getMaxPrice() != null) {
                predicates.add(cb.le(root.get("basePrice"), f.getMaxPrice()));
            }

            // ===== AVAILABILITY DATE LOGIC =====
            if (f.getFromDate() != null) {
                predicates.add(
                    cb.lessThanOrEqualTo(root.get("availableFrom"), f.getFromDate())
                );
            }

            if (f.getToDate() != null) {
                predicates.add(
                    cb.greaterThanOrEqualTo(root.get("availableTo"), f.getToDate())
                );
            }
            if (f.getStatus() != null) {
                
                    predicates.add(cb.equal(root.get("status"), f.getStatus()));
                
            }
            
            else {

                 predicates.add(cb.equal(root.get("status"), RoomStatus.AVAILABLE));

            }
            if (f.getIsActive() != null) {
              	 predicates.add(cb.equal(root.get("isActive"),f.getIsActive()));
            }else
           	 predicates.add(cb.isTrue(root.get("isActive")));

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
