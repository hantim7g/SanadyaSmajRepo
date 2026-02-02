package com.hst.service;

import com.hst.entity.GotraMaster;
import com.hst.repository.GotraMasterRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class GotraMasterService {

    private final GotraMasterRepository repo;

    public GotraMasterService(GotraMasterRepository repo) {
        this.repo = repo;
    }

    public List<GotraMaster> findAllActive() {
        return repo.findByActiveTrueOrderByGotraNameAsc();
    }

    public GotraMaster findById(Long id) {
        return repo.findById(id).orElse(null);
    }

    public void save(GotraMaster g) {
        repo.save(g);
    }

    public void delete(Long id) {
        GotraMaster g = findById(id);
        if (g != null) {
            g.setActive(false); // soft delete
            repo.save(g);
        }
    }
}
