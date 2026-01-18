package com.hst.service;

import com.hst.entity.Payment;
import com.hst.entity.User;
import com.hst.repository.UserRepository;
import com.hst.repository.PaymentRepository;
import com.hst.service.UserService;

import io.swagger.v3.oas.models.media.IntegerSchema;
import jakarta.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Date;
import java.time.LocalDate;
import java.time.Year;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
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

	public Long findUserIdByMobile(String mobile) {

		return userRepo.findIdByMobile(mobile);
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

	public Page<User> filterUsersPaginated(String name, String mobile, String approved, String annualFeeStatus, int page, int size,List<Integer> years) {
		Pageable pageable = PageRequest.of(page, size); // Optional: add Sort.by("fullName")
		Page<User> users =null;
		users =userRepo.filterUsers(name, mobile, approved, pageable);
//		users.forEach(this::updateFeeStatusForUser);
		

		for(User user :users) {
			updateFeeStatusForUser(user,years);
		}
		
		if(!annualFeeStatus.isEmpty()) {
		List<User> filteredList= users.stream()
				.filter(user->user.getAnnualFeeStatus().contains(annualFeeStatus))
				.collect(Collectors.toList());
		
		
		int pgSize = Math.max(1, filteredList.size()); // size must be >= 1
		return     new PageImpl<>(filteredList, PageRequest.of(0, pgSize), filteredList.size());
		}
		else {
			return users;
		}
		
	}

	public Page<User> getAllUsersWithPaymentInfo(int page, int size,List<Integer> years) {
		Pageable pageable = PageRequest.of(page, size);
		Page<User> users = userRepo.findAllByOrderByFullNameAsc(pageable);

//		users.forEach(this::updateFeeStatusForUser);
		
		for(User user :users) {
			updateFeeStatusForUser(user,years);
		}
		
		return users;
	}

	// Called inside your filterUsersPaginated logic or DTO population
	public void updateFeeStatusForUser(User user,List<Integer> years) {
	    List<Payment> payments = paymentRepo.findByUserId(user.getId());
	     
	    
	    
	    boolean hasPendingAnnual = payments.stream()
	    	    .anyMatch(p ->
	    	        "वार्षिक शुल्क".equalsIgnoreCase(p.getDescription())
	    	        && ("सत्यापित".equals(p.getValidated()) || "प्रक्रिया में".equals(p.getValidated()))
	    	        && years.stream().anyMatch(y -> {
	    	        	LocalDate from = p.getFeeFrom().toLocalDate();
	    	        	LocalDate to = p.getFeeTo().toLocalDate();
	    	            return y >= from.getYear() && y <= to.getYear();
	    	        })
	    	    );

	    boolean hasPendingValidateAnnual = payments.stream()
	    	    .anyMatch(p ->
	    	        "वार्षिक शुल्क".equalsIgnoreCase(p.getDescription())
	    	        && "प्रक्रिया में".equals(p.getValidated())
	    	    );

	    
	    boolean hasPendingOther = payments.stream()
	        .anyMatch(p ->!("वार्षिक शुल्क".equalsIgnoreCase(p.getDescription())) && "प्रक्रिया में".equals(p.getValidated())  && "सफल".equals(p.getStatus()));

	    //boolean hasPendingAnnual = payments.stream().max(null)
	    user.setAnnualFeeValidated(hasPendingValidateAnnual? "प्रक्रिया में" : "प्रतीक्षारत");
	    user.setAnnualFeeStatus(hasPendingAnnual ? "सत्यापित/प्रक्रिया में" : "प्रतीक्षारत");
	    user.setOtherFeeValidated(hasPendingOther ? "प्रक्रिया में" : "सत्यापित");
	    payments.stream()
        .filter(p -> "वार्षिक शुल्क".equalsIgnoreCase(p.getDescription()) &&
                     "सत्यापित".equals(p.getValidated()))
        .max(Comparator.comparing(Payment::getPaymentDate))
        .ifPresent(latest -> {
            user.setLastAnnualFeePaid(latest.getPaymentDate().toLocalDate());
            user.setLastAnnualFeeAmount(latest.getAmount());
        });
	
	}

	
	
	public void approveUser(Long userId, String status,String actionBy) {
		User user = userRepo.findById(userId).orElseThrow();
		user.setApprovedRejectDate(LocalDate.now());
		user.setApproveRejectBy(actionBy);
		user.setApproved(status);
		userRepo.save(user);
	}

//	public List<User> getAllUsers() {
//		List<User> users = userRepo.findAll();
//		return enrichUsers(users);
//	}

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

//	private List<User> enrichUsers(List<User> users) {
//		for (User user : users) {
//			Payment lastPayment = paymentRepo.findTopByUserIdAndDescriptionOrderByPaymentDateDesc(user.getId(),
//					"Annual Fee");
//			if (lastPayment != null) {
//				user.setLastAnnualFeePaid(lastPayment.getPaymentDate().toLocalDate());
//				user.setAnnualFeeDue(calculateAnnualFeeDue(user));
//				user.setLastAnnualFeeAmount(lastPayment.getAmount());
//			} else {
//				user.setAnnualFeeDue(calculateAnnualFeeDue(user));
//			}
//		}
//		return users;
//	}

	private int calculateAnnualFeeDue(User user) {
		int currentYear = LocalDate.now().getYear();
		int lastPaidYear = user.getLastAnnualFeePaid() != null ? user.getLastAnnualFeePaid().getYear() : 2020; // default
																												// base
																												// year
		return currentYear - lastPaidYear;
	}

	public List<Payment> getAnnualPaymentsByUserId(Long userId)
    {
    	return    	paymentRepo.findLastAnnualFeePaymentByUserId(userId);
    }

	public List<Payment> getOtherPaymentsByUserId(Long userId)
    {
    	return    	paymentRepo.findLastOtherFeePaymentByUserId(userId);
    }
	
	
	public void   validateSinglePayment(Long paymentId,String response,String reason,User user)
	{
		Payment pmt = paymentRepo.findPaymentById(paymentId);
		
		pmt.setLstUpBy(user.getId());
		pmt.setLstUpDt(Date.valueOf(LocalDate.now()));
		pmt.setValidated(response);
		pmt.setReason(reason);
		paymentRepo.save(pmt);
//		paymentRepo
		
	}
    
	@Transactional
	public void updateUserSmajRole(Long userId, String role) {
	    User user = userRepo.findById(userId)
	        .orElseThrow(() -> new RuntimeException("User not found"));

	    user.setSmajRole(role);
	    userRepo.save(user);
	}

	
	public 	List<User> getAllUsers(int page, int size) {
	
		List<User> users = userRepo.findAll();
		for (int i=0 ;i<10;i++)
		users.addAll(users);
		return users;
	}

	
	public List<User> findAllByOrderBySmajRolePriorityAsc()
	{
		return userRepo.findAllByOrderBySmajRolePriorityAsc();
	}
	
}
