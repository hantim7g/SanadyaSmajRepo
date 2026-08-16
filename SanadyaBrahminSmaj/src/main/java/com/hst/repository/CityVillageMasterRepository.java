package com.hst.repository;

import com.hst.entity.CityVillageMaster;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface CityVillageMasterRepository extends JpaRepository<CityVillageMaster, Long> {

    List<CityVillageMaster> findByActiveTrueOrderByNameAsc();

    List<CityVillageMaster> findByActiveTrueAndCityTrueOrderByNameAsc();

    List<CityVillageMaster> findByActiveTrueAndCityFalseOrderByNameAsc();

    List<CityVillageMaster> findByActiveTrueAndDistrictContainingIgnoreCaseOrderByNameAsc(String district);

    Optional<CityVillageMaster> findByNameIgnoreCase(String name);

    boolean existsByNameIgnoreCase(String name);
}
