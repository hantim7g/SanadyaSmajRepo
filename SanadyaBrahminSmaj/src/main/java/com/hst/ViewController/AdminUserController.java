package com.hst.ViewController;

import com.hst.dto.UserRoleUpdateRequest;
import com.hst.entity.PasswordResetRequest;
import com.hst.entity.Payment;
import com.hst.entity.User;
import com.hst.service.PasswordResetRequestService;
import com.hst.service.UserService;

import jakarta.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/admin")
public class AdminUserController {

	@Autowired
	private UserService userService;

	@Autowired
	private 	PasswordResetRequestService passwordResetRequestService;
	@GetMapping("/memberList")
	public String listUsers(Model model, @RequestParam(defaultValue = "0") int page,
			@RequestParam(defaultValue = "10") int size) {
		List<Integer> years= new ArrayList<Integer>();
		years.add(LocalDate.now().getYear());
		Page<User> userList = userService.getAllUsersWithPaymentInfo(page, size,years);
		model.addAttribute("userList", userList.getContent());
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPages", userList.getTotalPages());
		model.addAttribute("totalItems", userList.getTotalElements());
		return "memberListAdmin"; // users.jsp
	}

	@PostMapping("/approveProfile/{id}")
	@ResponseBody
	public ResponseEntity<?> approveUser(@PathVariable Long id,Principal Principal ) {
		userService.approveUser(id, "स्वीकृत",Principal.getName());
		return ResponseEntity.ok().build();
	}

	@PostMapping("/rejectProfile/{id}")
	public ResponseEntity<?> rejectProfile(@PathVariable Long id ,Principal Principal ) {
		userService.approveUser(id, "अस्वीकृत", Principal.getName() );
		return ResponseEntity.ok().build();
	}

	@GetMapping("/users/filter")
	public String filterUsers(@RequestParam(required = false) String name, @RequestParam(required = false) String mobile,
			@RequestParam(required = false) String approved, @RequestParam(required = false) String annualFeeStatus,
			@RequestParam(defaultValue = "0") int page, @RequestParam(defaultValue = "10") int size,@RequestParam(required = true)String yearDropdown, Model model) {

		if (StringUtils.isEmpty(mobile))
			mobile = null;
		if (StringUtils.isEmpty(name))
			name = null;
		if (StringUtils.isEmpty(approved))
			approved = null;
		
		
		List<Integer> years = new ArrayList<>();

        if (yearDropdown.startsWith("last")) {
            // Extract the number after "last"
            int yearsBack = Integer.parseInt(yearDropdown.replace("last", "").replace("years", "").trim());

            int currentYear = java.time.Year.now().getValue();
            for (int i = 0; i < yearsBack; i++) {
                years.add(currentYear - i);
            }
        } else {
            // If it is just a specific year (e.g., "2023")
            years.add(Integer.parseInt(yearDropdown));
        }
		Page<User> userPage = userService.filterUsersPaginated(name, mobile, approved, annualFeeStatus, page, size,years);
		model.addAttribute("userList", userPage.getContent());
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPages", userPage.getTotalPages());
		model.addAttribute("totalItems", userPage.getTotalElements());
		return "fragments/user-cards";
	}

	@GetMapping("/user/{id}/annualPayments")
	public String getAnnualPayments(@PathVariable Long id, Model model) {
		
		List<Payment> payments = userService.getAnnualPaymentsByUserId(id);
		

		model.addAttribute("paymentList", payments);
		return "fragments/annual-payment-table";
	}

	@GetMapping("/user/{id}/otherPayments")
	public String getOtherPaymentsByUserId(@PathVariable Long id, Model model) {
		
		List<Payment> payments = userService.getOtherPaymentsByUserId(id);
		

		model.addAttribute("paymentList", payments);
		return "fragments/annual-payment-table";
	}
	
	
	@PostMapping("/validatePayment/{paymentId}/{reason}")
	@ResponseBody
	public ResponseEntity<?> validatePayment(@PathVariable Long paymentId, @PathVariable String reason , Principal principal)
	{
	    String mobile = principal.getName(); // current admin user
	    User user= userService.findByMobile(mobile);
	    userService.validateSinglePayment(paymentId,"सत्यापित",reason,user); // Include reason
	    return ResponseEntity.ok().build();
	}

	@PostMapping("/rejectPayment/{paymentId}/{reason}")
	@ResponseBody
	public ResponseEntity<?> rejectPayment(@PathVariable Long paymentId, @PathVariable String reason,Principal principal) {
		 String mobile = principal.getName(); // current admin user
		    User user= userService.findByMobile(mobile);
		userService.validateSinglePayment(paymentId,"अस्वीकृत", reason,user); // Implement this
		return ResponseEntity.ok().build();
	}
	@GetMapping("/reset-requests")
	public String showResetRequests(Model model) {
	    List<PasswordResetRequest> requests = passwordResetRequestService.findByStatus("PENDING");
	    model.addAttribute("resetRequests", requests);
	    return "resetRequests"; // JSP name without .jsp
	}
	@PostMapping("/users/update-role")
	public ResponseEntity<?> updateUserRole(@RequestBody UserRoleUpdateRequest request) {

	    userService.updateUserSmajRole(
	        request.getUserId(),
	        request.getRole()
	    );

	    return ResponseEntity.ok().build();
	}

}
