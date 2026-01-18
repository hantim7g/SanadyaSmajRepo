package com.hst.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.hst.entity.GotraMaster;

public interface GotraMasterRepository extends JpaRepository<GotraMaster, Long> {

    List<GotraMaster> findByActiveTrueOrderByGotraNameAsc();
}
