package com.hst.repository;


import com.hst.entity.Festival;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface FestivalRepository extends JpaRepository<Festival, Long> {

    List<Festival> findByActiveTrueOrderByFestivalDateAsc();
}
