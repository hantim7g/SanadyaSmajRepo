<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="hi">
<head>
    <title>📅 आगामी कार्यक्रम</title>
    <style>
        body {
            background-color: #fffaf0;
            font-family: 'Segoe UI', 'Noto Sans Devanagari', sans-serif;
        }
        .scroll-wrapper {
            height: 200px;
            overflow: hidden;
            position: relative;
        }
        .scroll-content {
            animation: scrollUp 15s linear infinite;
        }
        .scroll-wrapper:hover .scroll-content {
            animation-play-state: paused;
        }
        @keyframes scrollUp {
            0% { transform: translateY(0); }
            100% { transform: translateY(-50%); }
        }
        .card-custom {
            border-radius: 12px;
            background-color: #fff;
            box-shadow: 0 0 12px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin-bottom: 24px;
            width: 100%;
        }
        .card-title-custom {
            color: #e65100;
            font-size: 1.2rem;
            font-weight: 600;
            margin-bottom: 8px;
        }
        .card-text-custom {
            font-size: 1rem;
            font-weight: 500;
            color: #333;
            line-height: 1.5;
        }
        .view-button {
            background: linear-gradient(to right, #f95c08, #e65100);
            color: white;
            padding: 6px 18px;
            border-radius: 6px;
            font-weight: 500;
            border: none;
            transition: background 0.3s ease;
        }
        .view-button:hover {
            background: linear-gradient(to right, #8e4103, #b46a03);
        }
    </style>
</head>
<body>
<h4 class="text-center mb-4 text-danger fw-bold" style="margin-bottom: -20px;">
    📅 आगामी कार्यक्रम
</h4>

<div class="container py-4">
    <div class="scroll-wrapper" style="margin-top: -20px;margin-bottom: -20px;">
        <div class="scroll-content">

            <c:if test="${empty upcomingEvents}">
                <div class="card-custom">
                    <div class="card-title-custom">कोई आगामी कार्यक्रम नहीं</div>
                    <div class="card-text-custom">इस समय कोई आगामी कार्यक्रम निर्धारित नहीं है।</div>
                </div>
            </c:if>

            <c:forEach var="event" items="${upcomingEvents}">
                <div class="card-custom">
                    <div class="card-title-custom">
                        <fmt:formatDate value="${event.eventDate}" pattern="dd MMM yyyy" /> : ${event.title}
                        <c:if test="${event.eventDate.time - now.time < 86400000 && event.eventDate.time >= now.time}">
                            <span class="text-danger">NEW!</span>
                        </c:if>
                    </div>
                    <div class="card-text-custom">
                        <c:choose>
                            <c:when test="${fn:length(event.content) > 110}">
                                <c:out value="${fn:substring(event.content, 0, 110)}" />...
                            </c:when>
                            <c:otherwise>
                                <c:out value="${event.content}" />
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="text-end mt-3">
                        <a href="/events/${event.id}">
                            <button class="view-button">View Details</button>
                        </a>
                    </div>
                </div>
            </c:forEach>

        </div>
    </div>
</div>
</body>
</html> 		
