package com.hst.repository;

import com.hst.entity.AnnualCalendar;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface AnnualCalendarRepository extends JpaRepository<AnnualCalendar, Long> {

    List<AnnualCalendar> findByActiveTrueOrderByEventDateAsc();
}
