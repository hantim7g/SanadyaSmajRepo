package com.hst.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.hst.entity.OfficeBearer;

public interface OfficeBearerRepository extends JpaRepository<OfficeBearer, Long> {

    List<OfficeBearer> findByActiveTrueOrderByDisplayOrderAsc();
}

