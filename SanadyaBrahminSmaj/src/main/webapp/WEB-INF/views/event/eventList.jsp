<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>

<style>
    .event-card {
        position: relative;
        /* height: 66vh; */
        overflow: hidden;
        border: none;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
    }

    .event-image {
        height: 100%;
        width: 100%;
        object-fit: cover;
    }

    .event-overlay-bottom {
        position: absolute;
        bottom: 0;
        width: 100%;
        background: rgba(0, 0, 0, 0.6);
        color: #fff;
        padding: 1rem;
    }

    .event-title {
        font-size: 1.2rem;
        font-weight: bold;
        margin-bottom: 0.3rem;
    }

    .event-snippet {
        font-size: 0.95rem;
        margin-bottom: 0.5rem;
    }

    .event-meta {
        font-size: 0.8rem;
        margin-bottom: 0.5rem;
    }

    .event-actions {
        display: flex;
        justify-content: space-between;
    }

    .pagination {
        margin-top: 2rem;
    }
</style>

<div class="container mt-4">
    <div class="row" id="eventContainer">
        <c:forEach items="${eventPage.content}" var="event">
            <div class="col-md-8 mb-4 mx-auto">
                <div class="card event-card">
                    <img src="${event.mainImageUrl}" class="event-image" alt="event Image">
                    <div class="event-overlay-bottom">
                        <div class="event-title">${event.title}</div>
                        <div class="event-snippet">${fn:substring(event.content, 0, 100)}...</div>
                        <div class="event-meta">
                            <fmt:formatDate value="${event.publishDate}" pattern="dd MMM yyyy" />
                            | ${event.author}
                        </div>
                        <div class="event-actions">
                            <a href="/events/${event.id}" class="btn btn-sm btn-light">Read More</a>
                            <a href="https://wa.me/?text=${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}/events/${event.id}"
                               target="_blank" class="btn btn-sm btn-success">
                                <i class="bi bi-whatsapp"></i> Share
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <!-- Pagination -->
    <nav>
        <ul class="pagination justify-content-center">
            <c:forEach begin="0" end="${eventPage.totalPages - 1}" var="i">
                <li class="page-item ${i == eventPage.number ? 'active' : ''}">
                    <a class="page-link" href="?page=${i}">${i + 1}</a>
                </li>
            </c:forEach>
        </ul>
    </nav>
</div>
