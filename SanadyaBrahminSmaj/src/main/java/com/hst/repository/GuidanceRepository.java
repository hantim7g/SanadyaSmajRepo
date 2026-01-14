package com.hst.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.hst.entity.Guidance;

public interface GuidanceRepository extends JpaRepository<Guidance, Long> {
    List<Guidance> findByActiveTrueOrderByCreatedDateDesc();
}