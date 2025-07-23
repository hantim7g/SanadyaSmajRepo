package com.hst.ViewController;


import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hst.entity.Event;
import com.hst.entity.EventImage;
import com.hst.repository.EventRepository;
import com.hst.service.EventService;


import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/admin")
public class AdminEventController {

    @Autowired
    private EventService eventService;

    @GetMapping("/events")
    public String listEvents(
        @RequestParam(defaultValue = "0") int page,
        @RequestParam(defaultValue = "10") int size,
        @RequestParam(required = false) String search,           // search term
        @RequestParam(required = false) String author,           // author filter
        @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate publishDate,  // single date
        @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate publishDateStart, // range start
        @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate publishDateEnd,   // range end
        @RequestParam(required = false) String isCorosal,
        @RequestParam(required = false) String eventStatus,
        Model model
    ) {
        Pageable pageable = PageRequest.of(page, size, Sort.by(Sort.Direction.DESC, "publishDate"));
        // You can use publishDate (exact) or publishDateStart / publishDateEnd (range)
        Page<Event> eventPage = eventService.getEventsPagedFiltered(
        	    search, author, publishDate, publishDateStart, publishDateEnd, isCorosal, eventStatus, pageable
        	);
        	model.addAttribute("isCorosal", isCorosal);
        	model.addAttribute("eventStatus", eventStatus);

        model.addAttribute("eventPage", eventPage);
        model.addAttribute("search", search);
        model.addAttribute("author", author);
        model.addAttribute("publishDate", publishDate);
        model.addAttribute("publishDateStart", publishDateStart);
        model.addAttribute("publishDateEnd", publishDateEnd);
        model.addAttribute("page", page);
        model.addAttribute("size", size);
        return "event/adminEventList";
    }

    @GetMapping("/event-form")
    public String showForm(@RequestParam(required = false) Long id, Model model) {
    	model.addAttribute("event", id != null ? eventService.getEvent(id).orElse(new Event()) : new Event());
        return "event/event-form";
    }

    @PostMapping(value="/event/save", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public String saveEvent(
        @RequestParam(value = "mainImage", required = false) MultipartFile mainImage,
        @RequestParam(value = "imageFiles", required = false) List<MultipartFile> imageFiles,
        @ModelAttribute Event event,
        @RequestParam(value = "corosal", required = false) String corosalBox,
        @RequestParam(value = "eventStatus", required = false) String eventStatusBox,
        HttpServletRequest req,
        Model model
    ) throws IOException {

        // Directory for uploads
        String uploadDir = req.getServletContext().getRealPath("/uploads/");
        File dir = new File(uploadDir);
        if (!dir.exists()) dir.mkdirs();

        // --- Fetch existing event from DB if update ---
        Event existingEvent = (event.getId() != null) ? eventService.getEvent(event.getId()).orElse(null) : null;

        // --- MAIN IMAGE handling ---
        if (mainImage != null && !mainImage.isEmpty()) {
            String mainName = UUID.randomUUID() + "_" + mainImage.getOriginalFilename();
            mainImage.transferTo(new File(uploadDir, mainName));
            event.setMainImageUrl(req.getContextPath() + "/uploads/" + mainName);
        } else if (existingEvent != null) {
            event.setMainImageUrl(existingEvent.getMainImageUrl());
        }

        // --- GALLERY IMAGES handling ---
        List<EventImage> images = event.getImages();
        List<EventImage> existingImages = (existingEvent != null && existingEvent.getImages() != null) 
            ? existingEvent.getImages() : java.util.Collections.emptyList();

        if (images != null) {
            for (int i = 0; i < images.size(); i++) {
                EventImage img = images.get(i);
                img.setEvent(event);

                // If file uploaded, update url
                if (imageFiles != null && i < imageFiles.size() && imageFiles.get(i) != null && !imageFiles.get(i).isEmpty()) {
                    MultipartFile file = imageFiles.get(i);
                    String imgName = UUID.randomUUID() + "_" + file.getOriginalFilename();
                    file.transferTo(new File(uploadDir, imgName));
                    img.setUrl(req.getContextPath() + "/uploads/" + imgName);
                } else if (img.getId() != null) {
                    // No file uploaded: preserve the url from DB
                    EventImage oldImg = existingImages.stream()
                        .filter(ei -> img.getId().equals(ei.getId()))
                        .findFirst().orElse(null);
                    if (oldImg != null) {
                        img.setUrl(oldImg.getUrl());
                    }
                }
                // caption and altText come from form (always present if row exists)
            }
        }

        // Checkbox handling
        event.setCorosal(corosalBox != null && (corosalBox.equals("true") || corosalBox.equals("on")));
        event.setEventStatus(eventStatusBox != null && (eventStatusBox.equals("true") || eventStatusBox.equals("on")));

        eventService.saveEvent(event);
        model.addAttribute("success", "Event saved!");
        return "redirect:/admin/events";
    }

    // DELETE
    @PostMapping("/event/delete")
    public String deleteEvent(@RequestParam("id") Long id, Model model) {
        eventService.deleteEventById(id);
        model.addAttribute("success", "Event deleted!");
        return "redirect:/admin/events";
    }

    @PostMapping("/event-toggle-status")
    public String toggleEventStatus(@RequestParam("id") Long eventId, RedirectAttributes redirectAttributes) {
        Event event = eventService.getEventById(eventId).orElse(null);
        if (event != null) {
            event.setEventStatus(!event.isEventStatus());
            eventService.saveEvent(event);
            redirectAttributes.addFlashAttribute("msg", "Status updated!");
        } else {
            redirectAttributes.addFlashAttribute("error", "Event not found.");
        }
        return "redirect:/admin/events";
    }
    @PostMapping("/event-toggle-corosal")
    public String toggleCorosal(@RequestParam("id") Long eventId, RedirectAttributes redirectAttributes) {
        Event event = eventService.getEventById(eventId).orElse(null);
        if (event != null) {
            event.setCorosal(!event.isCorosal());
            eventService.saveEvent(event);
            redirectAttributes.addFlashAttribute("msg", "Corosal स्थिति अपडेट हो गई!");
        } else {
            redirectAttributes.addFlashAttribute("error", "Event नहीं मिला।");
        }
        return "redirect:/admin/events";
    }

}
