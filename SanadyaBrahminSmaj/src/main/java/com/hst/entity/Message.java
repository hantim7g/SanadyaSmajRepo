package com.hst.entity;

import jakarta.persistence.*;
import java.time.Instant;
import java.util.Objects;

@Entity
@Table(name = "messages")
public class Message {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // Author details
    @Column(name = "author_name", length = 200)
    private String authorName;

    @Column(name = "author_title", length = 200)
    private String authorTitle;

    @Column(name = "author_subtitle", length = 250)
    private String authorSubtitle;

    @Column(name = "photo_url", length = 500)
    private String photoUrl;

    @Column(name = "city_or_area", length = 120)
    private String cityOrArea;

    // Message content
    @Column(name = "title", length = 200, nullable = false)
    private String title;

    @Column(name = "leads", length = 1000)
    private String lead;

    // Use TEXT/CLOB for larger content
    @Lob
    @Column(name = "content")
    private String content;

    @Lob
    @Column(name = "content_html")
    private String contentHtml;

    @Column(name = "quote", length = 1000)
    private String quote;

    // Signature/footer
    @Column(name = "signature_name", length = 200)
    private String signatureName;

    @Column(name = "signature_designation", length = 200)
    private String signatureDesignation;

    @Column(name = "date_text", length = 120)
    private String dateText;

    @Column(name = "footer_note", length = 1000)
    private String footerNote;

    @Column(name = "page_number", length = 20)
    private String pageNumber;

    // Optional: to indicate which content field to render
    @Enumerated(EnumType.STRING)
    @Column(name = "content_format", length = 20, nullable = false)
    private ContentFormat contentFormat = ContentFormat.PLAIN; // PLAIN uses content; HTML uses contentHtml

    // Auditing
    @Column(name = "created_at", nullable = false, updatable = false)
    private Instant createdAt;

    @Column(name = "updated_at", nullable = false)
    private Instant updatedAt;

    // Soft delete
    @Column(name = "deleted", nullable = false)
    private boolean deleted = false;

    public enum ContentFormat {
        PLAIN, HTML
    }

    // Constructors
    public Message() {}

    // Getters and setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getAuthorName() { return authorName; }
    public void setAuthorName(String authorName) { this.authorName = authorName; }

    public String getAuthorTitle() { return authorTitle; }
    public void setAuthorTitle(String authorTitle) { this.authorTitle = authorTitle; }

    public String getAuthorSubtitle() { return authorSubtitle; }
    public void setAuthorSubtitle(String authorSubtitle) { this.authorSubtitle = authorSubtitle; }

    public String getPhotoUrl() { return photoUrl; }
    public void setPhotoUrl(String photoUrl) { this.photoUrl = photoUrl; }

    public String getCityOrArea() { return cityOrArea; }
    public void setCityOrArea(String cityOrArea) { this.cityOrArea = cityOrArea; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getLead() { return lead; }
    public void setLead(String lead) { this.lead = lead; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public String getContentHtml() { return contentHtml; }
    public void setContentHtml(String contentHtml) { this.contentHtml = contentHtml; }

    public String getQuote() { return quote; }
    public void setQuote(String quote) { this.quote = quote; }

    public String getSignatureName() { return signatureName; }
    public void setSignatureName(String signatureName) { this.signatureName = signatureName; }

    public String getSignatureDesignation() { return signatureDesignation; }
    public void setSignatureDesignation(String signatureDesignation) { this.signatureDesignation = signatureDesignation; }

    public String getDateText() { return dateText; }
    public void setDateText(String dateText) { this.dateText = dateText; }

    public String getFooterNote() { return footerNote; }
    public void setFooterNote(String footerNote) { this.footerNote = footerNote; }

    public String getPageNumber() { return pageNumber; }
    public void setPageNumber(String pageNumber) { this.pageNumber = pageNumber; }

    public ContentFormat getContentFormat() { return contentFormat; }
    public void setContentFormat(ContentFormat contentFormat) { this.contentFormat = contentFormat; }

    public Instant getCreatedAt() { return createdAt; }
    public Instant getUpdatedAt() { return updatedAt; }

    // Lifecycle callbacks
    @PrePersist
    protected void onCreate() {
        Instant now = Instant.now();
        this.createdAt = now;
        this.updatedAt = now;
    }

    @PreUpdate
    protected void onUpdate() {
        this.updatedAt = Instant.now();
    }

    // equals/hashCode
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Message)) return false;
        Message message = (Message) o;
        return Objects.equals(id, message.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }
}
