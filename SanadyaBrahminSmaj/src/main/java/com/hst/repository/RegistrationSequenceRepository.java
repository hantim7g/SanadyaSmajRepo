package com.hst.repository;

import com.hst.entity.RegistrationSequence;
import jakarta.persistence.LockModeType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Lock;
import org.springframework.data.jpa.repository.Query;

public interface RegistrationSequenceRepository extends JpaRepository<RegistrationSequence, Long> {

    @Lock(LockModeType.PESSIMISTIC_WRITE)
    @Query("SELECT rs FROM RegistrationSequence rs")
    java.util.List<RegistrationSequence> findAllWithPessimisticLock();
}
