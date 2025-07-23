package com.hst.repository;

import java.time.LocalDate;

import org.springframework.data.jpa.repository.JpaRepository;

import com.hst.entity.Booking;
import com.hst.entity.Building;
import com.hst.entity.Room;

public interface BuildingRepository extends JpaRepository<Building, Long> {}
