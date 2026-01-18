package com.hst.service;

import com.hst.entity.AnnualCalendar;
import com.hst.repository.AnnualCalendarRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AnnualCalendarService {

    private final AnnualCalendarRepository repo;

    public AnnualCalendarService(AnnualCalendarRepository repo) {
        this.repo = repo;
    }
    public List<AnnualCalendar> findAllActive() {
        return repo.findByActiveTrueOrderByEventDateAsc();
    }

    public AnnualCalendar save(AnnualCalendar calendar) {
        return repo.save(calendar);
    }

    public void delete(Long id) {
        repo.deleteById(id);
    }

    public AnnualCalendar findById(Long id) {
        return repo.findById(id).orElse(null);
    }
}
