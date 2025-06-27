package com.hst.service;



import com.hst.entity.Payment;
import com.hst.entity.User;
import com.hst.repository.UserRepository;
import com.hst.repository.PaymentRepository;
import com.hst.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Date;
import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;


@Service
public class UserService {
	   private static final int ANNUAL_FEE = 100;
	    private static final int START_YEAR = 2020;
	    
    private final UserRepository userRepo;


    @Autowired
    private PaymentRepository paymentRepo;

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

    
    public Page<User> filterUsersPaginated(String name, String city, Boolean approved, Boolean due, int page, int size) {
        Pageable pageable = PageRequest.of(page, size); // Optional: add Sort.by("fullName")
        return userRepo.filterUsers(name, city, approved, due, pageable);
    }
    
    public Page<User>  getAllUsersWithPaymentInfo(int page, int size) {
    	Pageable pageable = PageRequest.of(page, size); 
    	Page<User> users = userRepo.findAllByOrderByFullNameAsc(pageable);

//        for (User user : users) {
//            Payment lastAnnual = paymentRepo.findLastAnnualFeePaymentByUserId(user.getId());
//
//            LocalDate lastPaidDate = null;
//            double lastPaidAmount = 0;
//
//            if (lastAnnual != null) {
//                lastPaidDate = lastAnnual.getPaymentDate().toLocalDate();
//                lastPaidAmount = lastAnnual.getAmount();
//            }
//
//            // Due logic (one payment per year expected)
//            int currentYear = LocalDate.now().getYear();
//            int startYear = 2020;
//            int expectedPayments = currentYear - startYear + 1;
//
//            // Simplified due logic
//            int paidYears = (int) (lastPaidAmount / 100);
//            int due = Math.max(0, (expectedPayments - paidYears) * 100);
//
//            user.setLastAnnualFeePaid(lastPaidDate);
//            user.setLastAnnualFeeAmount(lastPaidAmount);
//            user.setAnnualFeeDue(due);
//        }
//
        return users;
    }    
    public void approveUser(Long userId) {
        User user = userRepo.findById(userId).orElseThrow();
        user.setApproved(true);
        userRepo.save(user);
    }

    
    public List<User> getAllUsers() {
        List<User> users = userRepo.findAll();
        return enrichUsers(users);
    }

//    public List<User> filterUsers(String name, String city, Boolean approved, Boolean due) {
//        List<User> users = userRepo.findFiltered(name, city, approved);
//        if (due != null) {
//            users = users.stream().filter(u -> {
//                int annualDue = calculateAnnualFeeDue(u);
//                return due ? annualDue > 0 : annualDue <= 0;
//            }).collect(Collectors.toList());
//        }
//        return enrichUsers(users);
//    }

    private List<User> enrichUsers(List<User> users) {
        for (User user : users) {
            Payment lastPayment = paymentRepo.findTopByUserIdAndDescriptionOrderByPaymentDateDesc(user.getId(), "Annual Fee");
            if (lastPayment != null) {
                user.setLastAnnualFeePaid(lastPayment.getPaymentDate().toLocalDate());
                user.setAnnualFeeDue(calculateAnnualFeeDue(user));
                user.setLastAnnualFeeAmount(lastPayment.getAmount());
            } else {
                user.setAnnualFeeDue(calculateAnnualFeeDue(user));
            }
        }
        return users;
    }

    private int calculateAnnualFeeDue(User user) {
        int currentYear = LocalDate.now().getYear();
        int lastPaidYear = user.getLastAnnualFeePaid() != null ? user.getLastAnnualFeePaid().getYear() : 2020; // default base year
        return currentYear - lastPaidYear;
    }

}
