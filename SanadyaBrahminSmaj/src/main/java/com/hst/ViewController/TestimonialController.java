package com.hst.ViewController;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;

import com.hst.entity.Testimonial;
import com.hst.entity.User;
import com.hst.service.TestimonialService;
import com.hst.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.security.Principal;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Controller
public class TestimonialController {
	@Autowired
	private TestimonialService testimonialService;

	@Autowired
	private UserService userService;

	// Public: Approved + Active testimonials
	@GetMapping("/testimonials")
	public String viewTestimonials(@RequestParam(defaultValue = "0") int page,
	                               @RequestParam(defaultValue = "9") int size,
	                               @RequestParam(required = false) String q,
	                               Model model,
	                               Authentication auth) {

	    // Ensure page,size are sane
	    if (page < 0) page = 0;
	    if (size <= 0 || size > 100) size = 9;

	    // Fetch current user (nullable safe)
	    User user = null;
	    if (auth != null && auth.isAuthenticated()) {
	        user = userService.findByMobile(auth.getName());
	    }
	    model.addAttribute("currentUser", user);

	    // Get paged approved testimonials (optionally filtered by q)
	    Page<Testimonial> pageData = testimonialService.findApprovedPaged(
	            q, PageRequest.of(page, size, Sort.by(Sort.Direction.DESC, "createdDate"))
	    );

	    model.addAttribute("testimonials", pageData.getContent());
	    model.addAttribute("currentPage", pageData.getNumber());
	    model.addAttribute("totalPages", pageData.getTotalPages());
	    model.addAttribute("totalItems", pageData.getTotalElements());
	    model.addAttribute("size", size);
	    model.addAttribute("q", q);

	    return "testimonial/testimonialView";
	}


	// Member: show add form
	@GetMapping("/member/add-testimonial")
	public String showAddTestimonialForm(Model model, Authentication auth, RedirectAttributes redirect) {
	    if (auth == null || !auth.isAuthenticated()) {
	        return "redirect:/login";
	    }
	    User user = userService.findByMobile(auth.getName());
	    
	List<Testimonial> testimonials = testimonialService.getUserTestimonials(user.getId());
			
	if(testimonials.size()>0)
	{
	    model.addAttribute("testimonial", testimonials.get(0));
	} 

		
		model.addAttribute("user", user);
	    return "testimonial/add-testimonial";
	}

	// Member: save new testimonial
	@PostMapping("/member/update-testimonial")
	public String saveOrUpdateTestimonial(@ModelAttribute Testimonial testimonial,
	                                      Authentication auth,
	                                      RedirectAttributes redirectAttributes) {
	    if (auth == null || !auth.isAuthenticated()) {
	        return "redirect:/login";
	    }

	    User user = userService.findByMobile(auth.getName());
	    testimonial.setUser(user);

	    // ✅ Case 1: New Testimonial (no id)
	    if (testimonial.getId() == null) {
	        testimonialService.saveTestimonial(testimonial);
	        redirectAttributes.addFlashAttribute("success",
	                "आपका प्रशंसापत्र सफलतापूर्वक सबमिट हो गया है। अनुमोदन की प्रतीक्षा करें।");

	    } 
	    // ✅ Case 2: Update existing testimonial (id present)
	    else {
	        Testimonial existing = testimonialService.findById(testimonial.getId()).get();
	        if (existing == null || !existing.getUser().getId().equals(user.getId())) {
	            redirectAttributes.addFlashAttribute("error", "अमान्य अनुरोध।");
	            return "redirect:/testimonial/my-testimonials";
	        }

	        // only update editable fields
	        existing.setStatus("प्रक्रिया में");
	        existing.setMessage(testimonial.getMessage());
	        existing.setDesignation(testimonial.getDesignation());

	        testimonialService.saveTestimonial(existing);
	        redirectAttributes.addFlashAttribute("success", "आपका प्रशंसापत्र अपडेट कर दिया गया है।");
	    }

	    return "redirect:/testimonial/my-testimonials";
	}
	
	@PostMapping("/member/save-testimonial")
	public String saveOrUpdateTestimonialEtc(@ModelAttribute Testimonial testimonial,
	                                      Authentication auth,
	                                      RedirectAttributes redirectAttributes) {
	    if (auth == null || !auth.isAuthenticated()) {
	        return "redirect:/login";
	    }

	    User user = userService.findByMobile(auth.getName());
	    testimonial.setUser(user);

	    // ✅ Case 1: New Testimonial (no id)
	    if (testimonial.getId() == null) {
	        testimonialService.saveTestimonial(testimonial);
	        redirectAttributes.addFlashAttribute("success",
	                "आपका प्रशंसापत्र सफलतापूर्वक सबमिट हो गया है। अनुमोदन की प्रतीक्षा करें।");

	    } 
	    // ✅ Case 2: Update existing testimonial (id present)
	    else {
	        Testimonial existing = testimonialService.findById(testimonial.getId()).get();
	        if (existing == null || !existing.getUser().getId().equals(user.getId())) {
	            redirectAttributes.addFlashAttribute("error", "अमान्य अनुरोध।");
	            return "redirect:/testimonial/my-testimonials";
	        }

	        // only update editable fields
	        existing.setStatus("प्रक्रिया में");
	        existing.setMessage(testimonial.getMessage());
	        existing.setDesignation(testimonial.getDesignation());

	        testimonialService.saveTestimonial(existing);
	        redirectAttributes.addFlashAttribute("success", "आपका प्रशंसापत्र अपडेट कर दिया गया है।");
	    }

	    return "redirect:/testimonial/my-testimonials";
	}

	// Member: show edit form
	@GetMapping("/member/edit-testimonial/{id}")
	public String showEditTestimonialForm(@PathVariable Long id, Model model, Authentication auth, RedirectAttributes redirect) {
	    if (auth == null || !auth.isAuthenticated()) {
	        return "redirect:/login";
	    }
	    User user = userService.findByMobile(auth.getName());
	    if (!testimonialService.canUserEditTestimonial(id, user)) {
	        redirect.addFlashAttribute("error", "आपको इस प्रशंसापत्र को संपादित करने की अनुमति नहीं है।");
	        return "redirect:/testimonial/my-testimonials";
	    }
	    Optional<Testimonial> testimonialOpt = testimonialService.findById(id);
	    if (testimonialOpt.isEmpty()) {
	        redirect.addFlashAttribute("error", "प्रशंसापत्र नहीं मिला।");
	        return "redirect:/testimonial/my-testimonials";
	    }
	    model.addAttribute("testimonial", testimonialOpt.get());
	    model.addAttribute("user", user);
	    model.addAttribute("isEdit", true);
	    return "testimonial/edit-testimonial";
	}

	// Member: update testimonial
	@PostMapping("/member/update-testimonial/{id}")
	public String updateTestimonial(@PathVariable Long id,
	                                @RequestParam String message,
	                                @RequestParam(required = false) String designation,
	                                Authentication auth,
	                                RedirectAttributes redirectAttributes) {
	    if (auth == null || !auth.isAuthenticated()) {
	        return "redirect:/login";
	    }
	    User user = userService.findByMobile(auth.getName());

	    if (!testimonialService.canUserEditTestimonial(id, user)) {
	        redirectAttributes.addFlashAttribute("error", "आपको इस प्रशंसापत्र को संपादित करने की अनुमति नहीं है।");
	        return "redirect:/testimonial/my-testimonials";
	    }
	    if (message == null || message.trim().isEmpty()) {
	        redirectAttributes.addFlashAttribute("error", "संदेश खाली नहीं हो सकता।");
	        return "redirect:/member/edit-testimonial/" + id;
	    }
	    if (message.length() > 1000) {
	        redirectAttributes.addFlashAttribute("error", "संदेश 1000 अक्षरों से अधिक नहीं हो सकता।");
	        return "redirect:/member/edit-testimonial/" + id;
	    }

	    Testimonial updated = testimonialService.updateTestimonial(id, message.trim(), designation, user);
	    if (updated != null) {
	        redirectAttributes.addFlashAttribute("success", "आपका प्रशंसापत्र सफलतापूर्वक अपडेट हो गया है।");
	    } else {
	        redirectAttributes.addFlashAttribute("error", "प्रशंसापत्र अपडेट करने में त्रुटि हुई।");
	    }
	    return "redirect:/testimonial/my-testimonials";
	}

	// Member: list own testimonials
	@GetMapping("/testimonial/my-testimonials")
	public String myTestimonials(Model model, Authentication auth) {
	    if (auth == null || !auth.isAuthenticated()) {
	        return "redirect:/login";
	    }
	    User user = userService.findByMobile(auth.getName());
	    List<Testimonial> testimonials = testimonialService.getUserTestimonials(user.getId());
	    model.addAttribute("testimonials", testimonials);
	    model.addAttribute("user", user);
	    return "testimonial/my-testimonials";
	}

	// Member: delete testimonial (AJAX)
	@PostMapping("/member/testimonial/delete/{id}")
	@ResponseBody
	public ResponseEntity<?> deleteTestimonial(@PathVariable Long id, Authentication auth) {
	    if (auth == null || !auth.isAuthenticated()) {
	        return ResponseEntity.status(401).body(Map.of("message", "कृपया लॉगिन करें।"));
	    }
	    User user = userService.findByMobile(auth.getName());
	    try {
	        testimonialService.deleteTestimonial(id, user);
	        return ResponseEntity.ok(Map.of("message", "प्रशंसापत्र सफलतापूर्वक हटा दिया गया।"));
	    } catch (Exception e) {
	        return ResponseEntity.status(403).body(Map.of("message", "आपको इस प्रशंसापत्र को हटाने की अनुमति नहीं है।"));
	    }
	}

	// Admin: dashboard
	@GetMapping("/admin/testimonials")
	public String adminTestimonials(Model model) {
	    List<Testimonial> pendingTestimonials = testimonialService.getPendingTestimonials();
	    List<Testimonial> approvedTestimonials = testimonialService.getApprovedTestimonials();
	    model.addAttribute("pendingTestimonials", pendingTestimonials);
	    model.addAttribute("approvedTestimonials", approvedTestimonials);
	    return "admin/testimonial-management";
	}

	// Admin: approve
	@PostMapping("/admin/testimonial/approve/{id}")
	@ResponseBody
	public ResponseEntity<?> approveTestimonial(@PathVariable Long id, Principal principal) {
	    testimonialService.approveTestimonial(id, principal.getName());
	    return ResponseEntity.ok(Map.of("message", "प्रशंसापत्र स्वीकृत किया गया।"));
	}

	// Admin: reject
	@PostMapping("/admin/testimonial/reject/{id}")
	@ResponseBody
	public ResponseEntity<?> rejectTestimonial(@PathVariable Long id, Principal principal) {
	    testimonialService.rejectTestimonial(id, principal.getName());
	    return ResponseEntity.ok(Map.of("message", "प्रशंसापत्र अस्वीकृत किया गया।"));
	}

	// Admin: toggle active
	@PostMapping("/admin/testimonial/toggle/{id}")
	@ResponseBody
	public ResponseEntity<?> toggleTestimonial(@PathVariable Long id) {
	    testimonialService.toggleActive(id);
	    return ResponseEntity.ok(Map.of("message", "स्थिति अपडेट की गई।"));
	}


}