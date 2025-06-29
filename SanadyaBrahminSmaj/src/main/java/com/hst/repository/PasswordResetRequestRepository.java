package com.hst.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.hst.entity.PasswordResetRequest;

public interface PasswordResetRequestRepository extends JpaRepository<PasswordResetRequest, Long> {
 
	
	List<PasswordResetRequest> findByStatus(String status);

  Optional<PasswordResetRequest> findById(Long id);
}
