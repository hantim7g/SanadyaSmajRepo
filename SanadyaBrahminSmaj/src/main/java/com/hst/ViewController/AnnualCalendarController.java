package com.hst.ViewController;


import com.hst.entity.AnnualCalendar;
import com.hst.service.AnnualCalendarService;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class AnnualCalendarController {

    private final AnnualCalendarService service;

    public AnnualCalendarController(AnnualCalendarService service) {
        this.service = service;
    }

//    /* VIEW PAGE */
//    @GetMapping("/calendar")
//    public String calendar(Model model, Principal principal) {
//
//    	 boolean isAdmin = principal != null &&
//                 SecurityContextHolder.getContext().getAuthentication()
//                         .getAuthorities().stream()
//                         .anyMatch(a -> a.getAuthority().equals("ADMIN"));
//        model.addAttribute("calendarList", service.findAllActive());
//        model.addAttribute("isAdmin", isAdmin);
//
//        return "annual-calendar";
//    }
    
    
    
    @GetMapping("/calendar")
    public String calendar(Model model, Principal principal) {

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd MMM yyyy");

        List<Map<String, Object>> viewList = service.findAllActive()
            .stream()
            .map(c -> {
                Map<String, Object> m = new HashMap<>();
                m.put("id", c.getId());
                m.put("eventDate", c.getEventDate().format(formatter));
                m.put("rawDate", c.getEventDate()); // for edit
                m.put("description", c.getDescription());
                return m;
            }).toList();
        boolean isAdmin = principal != null &&
                SecurityContextHolder.getContext().getAuthentication()
                        .getAuthorities().stream()
                        .anyMatch(a -> a.getAuthority().equals("ADMIN"));
       
        model.addAttribute("calendarList", viewList);
        model.addAttribute("isAdmin",isAdmin);

        return "annual-calendar";
    }

    @PostMapping("/admin/calendar/save")
    @ResponseBody
    public String save(
            @RequestParam(required = false) Long id,
            @RequestParam String eventDate,
            @RequestParam String description
    ) {
        AnnualCalendar c = (id != null) ? service.findById(id) : new AnnualCalendar();

        c.setEventDate(LocalDate.parse(eventDate));
        c.setDescription(description);

        service.save(c);
        return "OK";
    }


    /* DELETE */
    @DeleteMapping("/admin/calendar/delete/{id}")
    @ResponseBody
    public String delete(@PathVariable Long id) {
        service.delete(id);
        return "OK";
    }
}
