package com.hst.service;

import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import com.hst.entity.BookingSys.Room;
import com.hst.entity.BookingSys.RoomImage;
import com.hst.repository.RoomRepository;

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

}
