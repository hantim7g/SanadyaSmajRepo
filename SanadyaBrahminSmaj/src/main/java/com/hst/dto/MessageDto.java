package com.hst.dto;


public class MessageDto {

    private String authorName;             // e.g. "ओम बिड़ला"
    private String authorTitle;            // e.g. "लोकसभा अध्यक्ष एवं सांसद"
    private String authorSubtitle;         // e.g. "कोटा-बूंदी लोकसभा क्षेत्र"
    private String photoUrl;               // URL/path of photo
    private String cityOrArea;             // e.g. "कोटा"

    private String title;                  // e.g. "शुभकामना संदेश"
    private String lead;                   // optional short intro paragraph
    private String content;                // plain text content
    private String contentHtml;            // if you want to allow formatted HTML
    private String quote;                  // any special quote or highlighted line

    private String signatureName;          // e.g. "ओम बिड़ला"
    private String signatureDesignation;   // e.g. "(लोकसभा अध्यक्ष)"
    private String dateText;               // optional footer date
    private String footerNote;             // optional extra footer text
    private String pageNumber;             // for printed page number

    // --- Getters & Setters ---

    public String getAuthorName() {
        return authorName;
    }
    public void setAuthorName(String authorName) {
        this.authorName = authorName;
    }

    public String getAuthorTitle() {
        return authorTitle;
    }
    public void setAuthorTitle(String authorTitle) {
        this.authorTitle = authorTitle;
    }

    public String getAuthorSubtitle() {
        return authorSubtitle;
    }
    public void setAuthorSubtitle(String authorSubtitle) {
        this.authorSubtitle = authorSubtitle;
    }

    public String getPhotoUrl() {
        return photoUrl;
    }
    public void setPhotoUrl(String photoUrl) {
        this.photoUrl = photoUrl;
    }

    public String getCityOrArea() {
        return cityOrArea;
    }
    public void setCityOrArea(String cityOrArea) {
        this.cityOrArea = cityOrArea;
    }

    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }

    public String getLead() {
        return lead;
    }
    public void setLead(String lead) {
        this.lead = lead;
    }

    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }

    public String getContentHtml() {
        return contentHtml;
    }
    public void setContentHtml(String contentHtml) {
        this.contentHtml = contentHtml;
    }

    public String getQuote() {
        return quote;
    }
    public void setQuote(String quote) {
        this.quote = quote;
    }

    public String getSignatureName() {
        return signatureName;
    }
    public void setSignatureName(String signatureName) {
        this.signatureName = signatureName;
    }

    public String getSignatureDesignation() {
        return signatureDesignation;
    }
    public void setSignatureDesignation(String signatureDesignation) {
        this.signatureDesignation = signatureDesignation;
    }

    public String getDateText() {
        return dateText;
    }
    public void setDateText(String dateText) {
        this.dateText = dateText;
    }

    public String getFooterNote() {
        return footerNote;
    }
    public void setFooterNote(String footerNote) {
        this.footerNote = footerNote;
    }

    public String getPageNumber() {
        return pageNumber;
    }
    public void setPageNumber(String pageNumber) {
        this.pageNumber = pageNumber;
    }
}
