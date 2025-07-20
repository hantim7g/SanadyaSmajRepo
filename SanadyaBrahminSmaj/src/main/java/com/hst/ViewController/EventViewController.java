package com.hst.ViewController;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.hst.entity.Event;
import com.hst.entity.EventImage;
import com.hst.repository.EventRepository;
import com.hst.service.EventService;

@RequestMapping("/events")
@Controller
public class EventViewController {
	
	
	@Autowired
	private EventService eventService;
	
	@GetMapping("")
	public String getEventList(
	        @RequestParam(defaultValue = "0") int page,
	        @RequestParam(defaultValue = "6") int size,
	        Model model) {

	    Pageable pageable = PageRequest.of(page, size, Sort.by("publishDate").descending());
	    Page<Event> eventPage = eventService.getPaginatedEvent(pageable);
	    model.addAttribute("eventPage", eventPage);
	    return "event/eventList";
	}
	@GetMapping("/{id}")
	public String getEventDetail(@PathVariable Long id, Model model) {
	    Event event = eventService.getEventById(id).get();
	    model.addAttribute("event", event);
	    return "event/eventDetail";
	}

    @Autowired
    private EventRepository eventRepo;

    @GetMapping("/form")
    public String showEventForm(@RequestParam(required = false) Long id, Model model) {
        Event event = (id != null) ? eventRepo.findById(id).orElse(new Event()) : new Event();
        model.addAttribute("event", event);
        return "event/event-form";
    }

    @PostMapping("/save")
    public String saveEvent(@ModelAttribute Event event) {
        if (event.getImages() != null) {
            for (EventImage img : event.getImages()) {
                img.setEvent(event); // Important!
            }
        }
        eventRepo.save(event);
        return "redirect:/events/list";
    }

    @GetMapping("/list")
    public String listEvents(Model model) {
        model.addAttribute("events", eventRepo.findAll());
        return "event/event-list";
    }
}


