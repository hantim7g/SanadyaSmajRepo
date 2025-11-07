package com.hst.ViewController;

import com.hst.entity.Event;
import com.hst.entity.Testimonial;
import com.hst.entity.User;
import com.hst.repository.UserRepository;
import com.hst.service.EventService;
import com.hst.service.PaymentService;
import com.hst.service.TestimonialService;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.sql.Date;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collector;
import java.util.stream.Collectors;

@Controller
public class HomeController {
@Autowired
    private  UserRepository userRepository;
@Autowired
    private  PaymentService paymentService;
@Autowired
	private EventService eventService;

@Autowired
private  TestimonialService testimonialService;

    // Map both / and /home
@GetMapping({"/","/home"})
public String home(Model model) {
    List<Event> carouselEvents = eventService.findByIsCorosalTrueAndEventStatusTrue();
    model.addAttribute("carouselEvents", carouselEvents);
    
    List<Event> upcomingEvents = eventService.findByEventStatusTrueAndEventDateAfter(new Date(System.currentTimeMillis()));
    model.addAttribute("upcomingEvents", upcomingEvents);
    
    // Add testimonials for home page
    List<Testimonial> testimonials = testimonialService.getApprovedTestimonials();
    List<Testimonial> testimonialActive=  testimonials.stream().filter(t->t.isActive()).collect(Collectors.toList());
    
    model.addAttribute("testimonials", testimonialActive);
    
    return "home";
}


    @GetMapping("/member/profile")
    public String memberProfile(Model model, Authentication authentication) {
        if (authentication == null || !authentication.isAuthenticated()) {
            return "redirect:/home";
        }

        String mobile = authentication.getName();
        Optional<User> userOpt = userRepository.findByMobile(mobile);

        if (userOpt.isPresent()) {
            model.addAttribute("user", userOpt.get());
            model.addAttribute("paymentList", paymentService.getPaymentsByMobile(mobile));
            return "profile"; // member-profile.jsp
        } else {
            model.addAttribute("error", "यूज़र प्रोफ़ाइल नहीं मिली।");
            return "error";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpServletResponse response, Authentication authentication) {
        SecurityContextHolder.clearContext();

        Cookie cookie = new Cookie("authToken", null);
        cookie.setPath("/");
        cookie.setHttpOnly(true);
        cookie.setMaxAge(0);
        response.addCookie(cookie);

        // 🔁 Redirect to home page ("/")
        return "redirect:/";    }
    @GetMapping("/member/payment")
    public String memberPayment(Model model, Authentication authentication) {
        if (authentication == null || !authentication.isAuthenticated()) {
            return "redirect:/home";
        }

        String mobile = authentication.getName();
        Optional<User> userOpt = userRepository.findByMobile(mobile);

        if (userOpt.isPresent()) {
            model.addAttribute("user", userOpt.get());
            model.addAttribute("paymentList", paymentService.getPaymentsByMobile(mobile));
            return "payment"; // member-profile.jsp
        } else {
            model.addAttribute("error", "यूज़र प्रोफ़ाइल नहीं मिली।");
            return "error";
        }
    }


}
