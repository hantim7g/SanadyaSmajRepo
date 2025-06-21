package com.hst.service;

import com.hst.entity.RegistrationSequence;
import com.hst.repository.RegistrationSequenceRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RegistrationNumberService {

    private final RegistrationSequenceRepository sequenceRepo;

    @Autowired
    public RegistrationNumberService(RegistrationSequenceRepository sequenceRepo) {
        this.sequenceRepo = sequenceRepo;
    }

    @Transactional
    public String generateRegistrationNumber() {
        RegistrationSequence seq;

        if (sequenceRepo.count() == 0) {
            seq = new RegistrationSequence(1L);
        } else {
            seq = sequenceRepo.findAll().get(0);
            seq.setLastNumber(seq.getLastNumber() + 1);
        }

        sequenceRepo.save(seq);

        String regNo = "REG" + String.format("%04d", seq.getLastNumber());
        return regNo;
    }
}
