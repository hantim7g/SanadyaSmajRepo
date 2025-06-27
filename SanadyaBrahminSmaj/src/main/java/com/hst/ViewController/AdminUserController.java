package com.hst.ViewController;

import com.hst.entity.Payment;
import com.hst.entity.User;
import com.hst.service.UserService;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminUserController {

	@Autowired
	private UserService userService;

	@GetMapping("/memberList")
	public String listUsers(Model model, @RequestParam(defaultValue = "0") int page,
			@RequestParam(defaultValue = "10") int size) {
		Page<User> userList = userService.getAllUsersWithPaymentInfo(page, size);
		model.addAttribute("userList", userList.getContent());
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPages", userList.getTotalPages());
		model.addAttribute("totalItems", userList.getTotalElements());
		return "memberListAdmin"; // users.jsp
	}

	@PostMapping("/approveUser/{id}")
	@ResponseBody
	public ResponseEntity<?> approveUser(@PathVariable Long id) {
		userService.approveUser(id);
		return ResponseEntity.ok("User approved");
	}

	@GetMapping("/users/filter")
	public String filterUsers(@RequestParam(required = false) String name, @RequestParam(required = false) String city,
			@RequestParam(required = false) Boolean approved, @RequestParam(required = false) Boolean due,
			@RequestParam(defaultValue = "0") int page, @RequestParam(defaultValue = "10") int size, Model model) {

		if (StringUtils.isEmpty(city))
			city = null;
		if (StringUtils.isEmpty(name))
			name = null;

		Page<User> userPage = userService.filterUsersPaginated(name, city, approved, due, page, size);
		model.addAttribute("userList", userPage.getContent());
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPages", userPage.getTotalPages());
		model.addAttribute("totalItems", userPage.getTotalElements());
		return "fragments/user-cards";
	}

//	@GetMapping("/user/{id}/annualPayments")
//	public String getAnnualPayments(@PathVariable Long id, Model model) {
//	    List<Payment> payments = userService.getAnnualPaymentsByUserId(id);
//	    model.addAttribute("paymentList", payments);
//	    return "fragments/annual-payment-table";
//	}
//
//	
//	@PostMapping("/validatePayment/{paymentId}")
//	@ResponseBody
//	public ResponseEntity<?> validatePayment(@PathVariable Long paymentId) {
//	    userService.validateSinglePayment(paymentId); // implement in your service
//	    return ResponseEntity.ok().build();
//	}

}
