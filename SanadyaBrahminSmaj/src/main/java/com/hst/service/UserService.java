package com.hst.service;

import org.springframework.stereotype.Service;

import com.hst.entity.User;
import com.hst.repository.UserRepository;

@Service
public class UserService {

    private final UserRepository userRepo;

    public UserService(UserRepository userRepo) {
        this.userRepo = userRepo;
    }

    public User findByMobile(String mobile) {
        return userRepo.findByMobile(mobile).orElseThrow(() -> new RuntimeException("User not found"));
    }

    public void updateProfile(String mobile, User updated) {
        User user = findByMobile(mobile);

        user.setFullName(updated.getFullName());
        user.setFatherName(updated.getFatherName());
        user.setEmail(updated.getEmail());
        user.setGender(updated.getGender());
        user.setDateOfBirth(updated.getDateOfBirth());
        user.setAddress(updated.getAddress());
        user.setEducation(updated.getEducation());
        user.setOccupation(updated.getOccupation());
        user.setBloodGroup(updated.getBloodGroup());
        user.setMaritalStatus(updated.getMaritalStatus());

        userRepo.save(user);
    }
}
