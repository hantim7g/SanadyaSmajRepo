package com.hst.controller;

import com.hst.entity.CityVillageMaster;
import com.hst.service.CityVillageMasterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/cities")
public class CityVillageMasterController {

    @Autowired
    private CityVillageMasterService service;

    /**
     * Get all active cities and villages for dropdown.
     */
    @GetMapping
    public ResponseEntity<List<CityVillageMaster>> getAll() {
        return ResponseEntity.ok(service.getAllActive());
    }

    /**
     * Get only cities (for city dropdown).
     */
    @GetMapping("/cities")
    public ResponseEntity<List<CityVillageMaster>> getCities() {
        return ResponseEntity.ok(service.getCitiesOnly());
    }

    /**
     * Get only villages (for village dropdown).
     */
    @GetMapping("/villages")
    public ResponseEntity<List<CityVillageMaster>> getVillages() {
        return ResponseEntity.ok(service.getVillagesOnly());
    }

    /**
     * Filter by district name.
     */
    @GetMapping("/by-district")
    public ResponseEntity<List<CityVillageMaster>> getByDistrict(@RequestParam String district) {
        return ResponseEntity.ok(service.getByDistrict(district));
    }

    /**
     * Validate if a city/village name exists in master data.
     */
    @GetMapping("/validate")
    public ResponseEntity<Boolean> validate(@RequestParam String name) {
        return ResponseEntity.ok(service.isValidCityOrVillage(name));
    }
}
