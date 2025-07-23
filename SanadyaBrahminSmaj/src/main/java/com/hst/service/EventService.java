package com.hst.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import com.hst.entity.Event;
import com.hst.repository.EventRepository;

import java.sql.Date;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Service
public class EventService  {

    @Autowired
    private EventRepository eventRepository;

    public Page<Event> getPaginatedEvent(Pageable pageable) {
        return eventRepository.findAll(pageable);
    }

    public Optional<Event> getEventById(Long id) {
        return eventRepository.findById(id);
    }

    public Event saveEvent(Event news) {
        return eventRepository.save(news);
    }

    public void deleteEventById(Long id) {
        eventRepository.deleteById(id);
    }
    public List<Event> findAll() {
        return eventRepository.findAll();
    }

    public Optional<Event> getEvent(Long id) {
        return eventRepository.findById(id);
    }
    
    
    public Page<Event> getEventsPagedFiltered(
    	    String search,
    	    String author,
    	    LocalDate publishDate,
    	    LocalDate publishDateStart,
    	    LocalDate publishDateEnd,
    	    String isCorosal,
    	    String eventStatus,
    	    Pageable pageable
    	) {
        Specification<Event> spec = (root, query, cb) -> {
            jakarta.persistence.criteria.Predicate predicate = cb.conjunction();
            if (search != null && !search.isEmpty()) {
                predicate = cb.and(predicate,
                    cb.or(
                        cb.like(cb.lower(root.get("title")), "%" + search.toLowerCase() + "%"),
                        cb.like(cb.lower(root.get("content")), "%" + search.toLowerCase() + "%")
                    )
                );
            }
            if (isCorosal != null && !isCorosal.isEmpty()) {
                boolean corosalValue = Boolean.parseBoolean(isCorosal);
                predicate = cb.and(predicate, cb.equal(root.get("isCorosal"), corosalValue));
            }
            if (eventStatus != null && !eventStatus.isEmpty()) {
                boolean statusValue = Boolean.parseBoolean(eventStatus);
                predicate = cb.and(predicate, cb.equal(root.get("eventStatus"), statusValue));
            }

            if (author != null && !author.isEmpty()) {
                predicate = cb.and(predicate,
                    cb.like(cb.lower(root.get("author")), "%" + author.toLowerCase() + "%")
                );
            }
            if (publishDate != null) {
                predicate = cb.and(predicate,
                    cb.equal(root.get("publishDate"), publishDate)
                );
            }
            if (publishDateStart != null) {
                predicate = cb.and(predicate,
                    cb.greaterThanOrEqualTo(root.get("publishDate"), publishDateStart)
                );
            }
            if (publishDateEnd != null) {
                predicate = cb.and(predicate,
                    cb.lessThanOrEqualTo(root.get("publishDate"), publishDateEnd)
                );
            }
            return predicate;
        };
        return eventRepository.findAll(spec, pageable);
    }

    public List<Event> findByIsCorosalTrueAndEventStatusTrue(){
    	 return eventRepository.findByIsCorosalTrueAndEventStatusTrue();
    }
    
   public List<Event> findByEventStatusTrueAndEventDateAfter(Date today){
    	return eventRepository.findByEventStatusTrueAndEventDateAfter( today);
    }
}
