<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>

<div class="container mt-5">
    <div class="card shadow-lg">
        <img src="${event.mainImageUrl}" class="card-img-top" alt="${event.title}" style="max-height: 400px; object-fit: cover;">
        <div class="card-body">
            <h2 class="card-title">${event.title}</h2>
            <p class="text-muted">
                <fmt:formatDate value="${event.publishDate}" pattern="dd MMM yyyy"/> | लेखक: ${event.author}
            </p>
            <hr>
            <p class="card-text fs-5" style="white-space: pre-line;">
                ${event.content}
            </p>
            <div class="mt-4">
                <a href="https://wa.me/?text=${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}/events/${event.id}" 
                   target="_blank" class="btn btn-success me-2">
                    <i class="bi bi-whatsapp"></i> Share on WhatsApp
                </a>
                <a href="/events" class="btn btn-secondary">← Back to event</a>
            </div>
        </div>
    </div>
</div>

