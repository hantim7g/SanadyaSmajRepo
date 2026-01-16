package com.hst.controller;

import java.sql.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hst.entity.Event;
import com.hst.entity.Testimonial;
import com.hst.service.EventService;
import com.hst.service.TestimonialService;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class CustomErrorController implements ErrorController {
	@Autowired
	private EventService eventService;
	@Autowired
	private  TestimonialService testimonialService;

    @RequestMapping("/error")
    public String handleError(Model model, HttpServletRequest request) {

    	 List<Event> carouselEvents = eventService.findByIsCorosalTrueAndEventStatusTrue();
    	    model.addAttribute("carouselEvents", carouselEvents);
    	    
    	    List<Event> upcomingEvents = eventService.findByEventStatusTrueAndEventDateAfter(new Date(System.currentTimeMillis()));
    	    model.addAttribute("upcomingEvents", upcomingEvents);
    	    
    	    // Add testimonials for home page
    	    List<Testimonial> testimonials = testimonialService.getApprovedTestimonials();
    	    List<Testimonial> testimonialActive=  testimonials.stream().filter(t->t.isActive()).collect(Collectors.toList());
    	    
    	    model.addAttribute("testimonials", testimonialActive);
    	    
        return "home"; // returns error.jsp
    }
}
