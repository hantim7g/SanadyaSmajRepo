package com.hst.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hst.entity.PasswordResetRequest;
import com.hst.repository.PasswordResetRequestRepository;

@Service
public class PasswordResetRequestService {
@Autowired
private  PasswordResetRequestRepository	passwordResetRequestRepository;

public void save(PasswordResetRequest req) {
	
	passwordResetRequestRepository.save(req);
	
	
}
	
public PasswordResetRequest findById(Long id) {
	
	Optional<PasswordResetRequest> passwordResetRequest=	passwordResetRequestRepository.findById(id);
	
			if(passwordResetRequest.isPresent()) {
			return passwordResetRequestRepository.findById(id).get();
			}
			else
				return null;
	
}

public List<PasswordResetRequest> findByStatus(String status){
	return passwordResetRequestRepository.findByStatus(status);
	
	
}

}
