package com.hst.ViewController;


import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.Objects;
import java.util.Set;
import java.util.UUID;
import java.util.stream.Collector;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
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

	@Value("${upload.image.dir}")
	private String uploadDir;
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
    @PostMapping(value = "/event/save", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public String saveEvent(
            @RequestParam(value = "mainImage",  required = false) MultipartFile mainImage,
            @RequestParam(value = "imageFiles", required = false) List<MultipartFile> imageFiles,
            @ModelAttribute Event eventDto,                         // ← DTO sent by the form
            @RequestParam(value = "corosal",      required = false) String corosalBox,
            @RequestParam(value = "eventStatus",  required = false) String eventStatusBox,
            HttpServletRequest request,
            Model model
    ) throws IOException {

        /* ---------------------------------------------------------
         * 1.  Resolve upload directory (create once if missing)
         * --------------------------------------------------------- */
      //  String uploadDir = uploadDir;//request.getServletContext().getRealPath("/uploads/");
        File dir = new File(uploadDir+"/events/");
        if (!dir.exists()) {
            dir.mkdirs();
        }

        /* ---------------------------------------------------------
         * 2.  Load the MANAGED entity (or use new one for inserts)
         * --------------------------------------------------------- */
        Event target = (eventDto.getId() != null)
                ? eventService.getEvent(eventDto.getId())
                             .orElseThrow(() -> new IllegalArgumentException("Event not found"))
                : eventDto;   // brand-new event; still detached but will be saved for the first time

        /* ---------------------------------------------------------
         * 3.  Copy scalar fields from the DTO to the managed entity
         *     (repeat for every simple property you expose on the form)
         * --------------------------------------------------------- */
        target.setTitle(eventDto.getTitle());
        target.setContent(eventDto.getContent());
        target.setEventDate(eventDto.getEventDate());
        target.setPublishDate(eventDto.getPublishDate());
        target.setAuthor(eventDto.getAuthor());
        target.setEventUrl(eventDto.getEventUrl());
        
        // … add the rest of your scalar setters here …

        /* ---------------------------------------------------------
         * 4.  Main image
         * --------------------------------------------------------- */
        if (mainImage != null && !mainImage.isEmpty()) {
            String storedName = UUID.randomUUID() + "_" + mainImage.getOriginalFilename();
            mainImage.transferTo(new File(uploadDir+"/events/" , storedName));
            target.setMainImageUrl("/images/events/" + storedName);
        }

        /* ---------------------------------------------------------
         * 5.  Gallery images (orphanRemoval=true)
         * --------------------------------------------------------- */
        List<EventImage> incomingImages = (eventDto.getImages() == null)
                ? java.util.Collections.emptyList()
                : eventDto.getImages();

     // Extract IDs of images provided by the client
        Set<Long> incomingImgIds = incomingImages.stream()
            .filter(img -> img.getId() != null)
            .map(EventImage::getId)
            .collect(Collectors.toSet());

        // Remove images from the managed entity that aren’t in the incoming IDs
        target.getImages().removeIf(storedImg -> 
            storedImg.getId() != null && !incomingImgIds.contains(storedImg.getId())
        );
        
        
        // Keep the SAME collection instance to avoid “collection was no longer referenced” error
      //  target.getImages().clear();
        for (int i = 0; i < incomingImages.size(); i++) {
            EventImage img = incomingImages.get(i);

            // If the image is existing, find it in the target's image list
            EventImage managedImage = null;
            if (img.getId() != null) {
                for (EventImage t : target.getImages()) {
                    if (Objects.equals(t.getId(), img.getId())) {
                        managedImage = t;
                        break;
                    }
                }
            }

            if (managedImage != null) {
                // Existing managed image: update its fields
                managedImage.setCaption(img.getCaption());
                managedImage.setAltText(img.getAltText());
                managedImage.setEvent(target);

                MultipartFile file = (imageFiles != null && i < imageFiles.size()) ? imageFiles.get(i) : null;
                handleGalleryFile(managedImage, file, uploadDir, request);
                
                if (managedImage.getUrl() == null && img.getUrl() != null) {
                    managedImage.setUrl(img.getUrl());
                }

                // Do NOT add managedImage again to target.getImages(): it’s already there
            } else {
                // New image: set relation and fields, then add to collection
                img.setEvent(target);
                MultipartFile file = (imageFiles != null && i < imageFiles.size()) ? imageFiles.get(i) : null;
                handleGalleryFile(img, file, uploadDir, request);
                target.getImages().add(img);
            }
        }

        /* ---------------------------------------------------------
         * 6.  Checkbox values
         * --------------------------------------------------------- */
        target.setCorosal("true".equalsIgnoreCase(corosalBox) || "on".equalsIgnoreCase(corosalBox));
        target.setEventStatus("true".equalsIgnoreCase(eventStatusBox) || "on".equalsIgnoreCase(eventStatusBox));

        /* ---------------------------------------------------------
         * 7.  Persist and redirect
         * --------------------------------------------------------- */
        eventService.saveEvent(target);
        model.addAttribute("success", "Event saved!");
        return "redirect:/admin/events";
    }

    private void handleGalleryFile(EventImage img,
            MultipartFile file,
            String uploadDir,
            HttpServletRequest request) throws IOException {

if (file != null && !file.isEmpty()) {
String storedName = UUID.randomUUID() + "_" + file.getOriginalFilename();
file.transferTo(new File(uploadDir+"/events/", storedName));
img.setUrl("/images/events/" + storedName);
} else if (img.getId() != null) {
/* The row already exists in DB and no new file was uploaded:
leave the URL untouched (it was loaded in 'img' by Spring). */
}  // for brand-new rows with no file: keep URL null or validate accordingly
}

    
    // DELETE
    @GetMapping("/event/delete")
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
