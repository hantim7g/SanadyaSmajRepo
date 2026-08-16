package com.hst.service;

import com.hst.entity.CityVillageMaster;
import com.hst.repository.CityVillageMasterRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CityVillageMasterService {

    @Autowired
    private CityVillageMasterRepository repository;

    public List<CityVillageMaster> getAllActive() {
        return repository.findByActiveTrueOrderByNameAsc();
    }

    public List<CityVillageMaster> getCitiesOnly() {
        return repository.findByActiveTrueAndCityTrueOrderByNameAsc();
    }

    public List<CityVillageMaster> getVillagesOnly() {
        return repository.findByActiveTrueAndCityFalseOrderByNameAsc();
    }

    public List<CityVillageMaster> getByDistrict(String district) {
        return repository.findByActiveTrueAndDistrictContainingIgnoreCaseOrderByNameAsc(district);
    }

    public boolean isValidCityOrVillage(String name) {
        return repository.existsByNameIgnoreCase(name);
    }

    public CityVillageMaster addCityVillage(String name, String district, boolean isCity) {
        CityVillageMaster cvm = new CityVillageMaster(name, district, isCity);
        return repository.save(cvm);
    }
}
