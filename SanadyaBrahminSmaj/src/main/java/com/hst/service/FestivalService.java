package com.hst.service;

import com.hst.entity.Festival;
import com.hst.repository.FestivalRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FestivalService {

    private final FestivalRepository repo;

    public FestivalService(FestivalRepository repo) {
        this.repo = repo;
    }

    public List<Festival> findAllActive() {
        return repo.findByActiveTrueOrderByFestivalDateAsc();
    }

    public Festival findById(Long id) {
        return repo.findById(id).orElse(null);
    }

    public Festival save(Festival festival) {
        return repo.save(festival);
    }

    public void delete(Long id) {
        repo.deleteById(id);
    }
}
