package com.hst.repository;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import com.hst.entity.BookingSys.Room;

public interface RoomRepository extends JpaRepository<Room, Long> {
    List<Room> findByIsActiveTrue();
}
