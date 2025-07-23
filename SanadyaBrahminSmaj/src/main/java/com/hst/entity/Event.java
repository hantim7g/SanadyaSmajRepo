package com.hst.entity;

import jakarta.persistence.*;
import java.sql.Date;
import java.util.List;

@Entity
public class Event {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String title;
    @Column(columnDefinition = "TEXT")
    private String content;
    private String author;
    
    private String mainImageUrl;
    @OneToMany(mappedBy = "event", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<EventImage> images;

    private Date publishDate;
    private String eventUrl;
    private boolean isCorosal;
    private Date eventDate;
    private boolean eventStatus = true; // true = show, false = hide (default show)

    // ... existing fields and methods

    public boolean isEventStatus() {
        return eventStatus;
    }
    public void setEventStatus(boolean eventStatus) {
        this.eventStatus = eventStatus;
    }
    // Getters and Setters...

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public List<EventImage> getImages() {
        return images;
    }

    public void setImages(List<EventImage> images) {
        this.images = images;
        if (images != null) {
            for (EventImage img : images) {
                img.setEvent(this);
            }
        }
    }

    public Date getPublishDate() {
        return publishDate;
    }

    public void setPublishDate(Date publishDate) {
        this.publishDate = publishDate;
    }

   

    public String getEventUrl() {
        return eventUrl;
    }

    public void setEventUrl(String eventUrl) {
        this.eventUrl = eventUrl;
    }

    public boolean isCorosal() {
        return isCorosal;
    }

    public void setCorosal(boolean isCorosal) {
        this.isCorosal = isCorosal;
    }

    public Date getEventDate() {
        return eventDate;
    }

    public void setEventDate(Date eventDate) {
        this.eventDate = eventDate;
    }

	public String getMainImageUrl() {
		return mainImageUrl;
	}

	public void setMainImageUrl(String mainImageUrl) {
		this.mainImageUrl = mainImageUrl;
	}
}
