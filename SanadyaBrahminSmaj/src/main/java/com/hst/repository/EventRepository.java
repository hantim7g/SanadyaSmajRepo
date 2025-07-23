package com.hst.repository;

import java.sql.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import com.hst.entity.Event;

public interface EventRepository extends JpaRepository<Event, Long> ,JpaSpecificationExecutor<Event> {
    // You can add custom queries if needed, like findByAuthor, findByTitleContaining, etc.
	List<Event> findByIsCorosalTrueAndEventStatusTrue();
	List<Event> findByEventStatusTrueAndEventDateAfter(Date today);

}
