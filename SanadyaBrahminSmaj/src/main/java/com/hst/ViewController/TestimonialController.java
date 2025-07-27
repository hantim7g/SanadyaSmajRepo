package com.hst.ViewController;

import com.hst.entity.Testimonial;
import com.hst.entity.User;
import com.hst.service.TestimonialService;
import com.hst.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.security.Principal;
import java.util.List;
import java.util.Map;

@Controller
public class TestimonialController {

    @Autowired
    private TestimonialService testimonialService;

    @Autowired
    private UserService userService;

    // Display testimonials for users
    @GetMapping("/testimonials")
    public String viewTestimonials(Model model) {
        List<Testimonial> testimonials = testimonialService.getApprovedTestimonials();
        model.addAttribute("testimonials", testimonials);
        return "testimonial/testimonial-carousel";
    }

    // Add testimonial form
    @GetMapping("/member/add-testimonial")
    public String showAddTestimonialForm(Model model, Authentication auth) {
        if (auth == null || !auth.isAuthenticated()) {
            return "redirect:/login";
        }

        User user = userService.findByMobile(auth.getName());
        
        // Check if user can add testimonial
        if (!testimonialService.canUserAddTestimonial(user.getId())) {
            model.addAttribute("error", "आपका पहले से ही एक प्रशंसापत्र प्रक्रिया में है या स्वीकृत है।");
            return "redirect:/member/profile";
        }

        model.addAttribute("testimonial", new Testimonial());
        model.addAttribute("user", user);
        return "testimonial/add-testimonial";
    }

    // Save testimonial
    @PostMapping("/member/save-testimonial")
    public String saveTestimonial(@ModelAttribute Testimonial testimonial, 
                                 Authentication auth, 
                                 RedirectAttributes redirectAttributes) {
        if (auth == null || !auth.isAuthenticated()) {
            return "redirect:/login";
        }

        User user = userService.findByMobile(auth.getName());
        
        if (!testimonialService.canUserAddTestimonial(user.getId())) {
            redirectAttributes.addFlashAttribute("error", "आपका पहले से ही एक प्रशंसापत्र प्रक्रिया में है।");
            return "redirect:/member/profile";
        }

        testimonial.setUser(user);
        testimonialService.saveTestimonial(testimonial);
        
        redirectAttributes.addFlashAttribute("success", "आपका प्रशंसापत्र सफलतापूर्वक सबमिट हो गया है। अनुमोदन की प्रतीक्षा करें।");
        return "redirect:/member/profile";
    }

    // Admin: View pending testimonials
    @GetMapping("/admin/testimonials")
    public String adminTestimonials(Model model) {
        List<Testimonial> pendingTestimonials = testimonialService.getPendingTestimonials();
        List<Testimonial> approvedTestimonials = testimonialService.getApprovedTestimonials();
        
        model.addAttribute("pendingTestimonials", pendingTestimonials);
        model.addAttribute("approvedTestimonials", approvedTestimonials);
        return "admin/testimonial-management";
    }

    // Admin: Approve testimonial
    @PostMapping("/admin/testimonial/approve/{id}")
    @ResponseBody
    public ResponseEntity<?> approveTestimonial(@PathVariable Long id, Principal principal) {
        testimonialService.approveTestimonial(id, principal.getName());
        return ResponseEntity.ok(Map.of("message", "प्रशंसापत्र स्वीकृत किया गया।"));
    }

    // Admin: Reject testimonial
    @PostMapping("/admin/testimonial/reject/{id}")
    @ResponseBody
    public ResponseEntity<?> rejectTestimonial(@PathVariable Long id, Principal principal) {
        testimonialService.rejectTestimonial(id, principal.getName());
        return ResponseEntity.ok(Map.of("message", "प्रशंसापत्र अस्वीकृत किया गया।"));
    }

    // Admin: Toggle active status
    @PostMapping("/admin/testimonial/toggle/{id}")
    @ResponseBody
    public ResponseEntity<?> toggleTestimonial(@PathVariable Long id) {
        testimonialService.toggleActive(id);
        return ResponseEntity.ok(Map.of("message", "स्थिति अपडेट की गई।"));
    }
}
