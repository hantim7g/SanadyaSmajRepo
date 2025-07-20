package com.hst.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import com.hst.entity.Event;

public interface EventRepository extends JpaRepository<Event, Long> ,JpaSpecificationExecutor<Event> {
    // You can add custom queries if needed, like findByAuthor, findByTitleContaining, etc.
}
