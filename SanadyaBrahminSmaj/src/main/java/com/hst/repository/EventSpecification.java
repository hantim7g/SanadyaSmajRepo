package com.hst.repository;
import org.springframework.data.jpa.domain.Specification;
import com.hst.entity.Event;

import java.time.LocalDate;

public class EventSpecification {

    public static Specification<Event> filter(
        String search,
        String author,
        LocalDate publishDateStart,
        LocalDate publishDateEnd
    ) {
        return (root, query, cb) -> {
            jakarta.persistence.criteria.Predicate predicate = cb.conjunction();

            if (search != null && !search.isEmpty()) {
                predicate = cb.and(predicate,
                    cb.or(
                        cb.like(cb.lower(root.get("title")), "%" + search.toLowerCase() + "%"),
                        cb.like(cb.lower(root.get("content")), "%" + search.toLowerCase() + "%")
                    )
                );
            }
            if (author != null && !author.isEmpty()) {
                predicate = cb.and(predicate,
                    cb.like(cb.lower(root.get("author")), "%" + author.toLowerCase() + "%")
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
    }
}
