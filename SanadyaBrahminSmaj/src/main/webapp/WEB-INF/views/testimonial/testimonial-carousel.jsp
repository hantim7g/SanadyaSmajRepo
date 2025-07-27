<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="container py-4">
    <h3 class="text-center mb-4">सदस्यों के विचार</h3>
    
    <c:choose>
        <c:when test="${not empty testimonials}">
            <div id="testimonialCarousel" class="carousel slide testimonial-carousel shadow-lg" data-bs-ride="carousel" data-bs-interval="5000">
                <div class="carousel-inner">
                    <c:forEach var="testimonial" items="${testimonials}" varStatus="status">
                        <div class="carousel-item ${status.index == 0 ? 'active' : ''}">
                            <div class="testimonial-card p-4 bg-white rounded">
                                <div class="d-flex align-items-start">
                                    <!-- Profile Image -->
                                    <div class="testimonial-image me-3">
                                        <c:choose>
                                            <c:when test="${not empty testimonial.user.profileImagePath}">
                                                <img src="${testimonial.user.profileImagePath}" 
                                                     alt="${testimonial.user.fullName}" 
                                                     class="rounded-circle border">
                                            </c:when>
                                            <c:otherwise>
                                                <div class="default-avatar rounded-circle border d-flex align-items-center justify-content-center">
                                                    <i class="fas fa-user fa-2x text-muted"></i>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    
                                    <!-- Content -->
                                    <div class="testimonial-content flex-grow-1">
                                        <div class="testimonial-header mb-2">
                                            <h5 class="testimonial-name mb-1">${testimonial.user.fullName}</h5>
                                            <p class="testimonial-designation text-muted mb-0">
                                                <c:choose>
                                                    <c:when test="${not empty testimonial.designation}">
                                                        ${testimonial.designation}
                                                    </c:when>
                                                    <c:otherwise>
                                                        ${testimonial.user.occupation}
                                                    </c:otherwise>
                                                </c:choose>
                                                <c:if test="${not empty testimonial.user.homeDistrict}">
                                                    | ${testimonial.user.homeDistrict}
                                                </c:if>
                                            </p>
                                        </div>
                                        
                                        <div class="testimonial-message">
                                            <blockquote class="blockquote">
                                                <p class="mb-0">"${testimonial.message}"</p>
                                            </blockquote>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <!-- Controls -->
                <c:if test="${fn:length(testimonials) > 1}">
                    <button class="carousel-control-prev" type="button" data-bs-target="#testimonialCarousel" data-bs-slide="prev">
                        <span class="carousel-control-prev-icon"></span>
                        <span class="visually-hidden">Previous</span>
                    </button>
                    <button class="carousel-control-next" type="button" data-bs-target="#testimonialCarousel" data-bs-slide="next">
                        <span class="carousel-control-next-icon"></span>
                        <span class="visually-hidden">Next</span>
                    </button>
                </c:if>

                <!-- Indicators -->
                <c:if test="${fn:length(testimonials) > 1}">
                    <div class="carousel-indicators">
                        <c:forEach var="testimonial" items="${testimonials}" varStatus="status">
                            <button type="button" data-bs-target="#testimonialCarousel" 
                                    data-bs-slide-to="${status.index}" 
                                    class="${status.index == 0 ? 'active' : ''}"
                                    aria-label="Slide ${status.index + 1}"></button>
                        </c:forEach>
                    </div>
                </c:if>
            </div>
        </c:when>
        <c:otherwise>
            <div class="text-center py-5">
                <p class="text-muted">अभी तक कोई प्रशंसापत्र उपलब्ध नहीं है।</p>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<style>
.testimonial-carousel .carousel-item {
    min-height: 200px;
}

.testimonial-card {
    max-width: 800px;
    margin: 0 auto;
    min-height: 180px;
}

.testimonial-image img,
.default-avatar {
    width: 80px;
    height: 80px;
    object-fit: cover;
}

.default-avatar {
    background-color: #f8f9fa;
    border: 2px solid #dee2e6;
}

.testimonial-name {
    color: #2c3e50;
    font-weight: 600;
}

.testimonial-designation {
    font-size: 0.9rem;
    font-style: italic;
}

.testimonial-message .blockquote {
    font-size: 1.1rem;
    color: #495057;
    border-left: 4px solid #007bff;
    padding-left: 1rem;
}

.carousel-control-prev,
.carousel-control-next {
    width: 5%;
}

.carousel-control-prev-icon,
.carousel-control-next-icon {
    background-color: rgba(0, 0, 0, 0.5);
    border-radius: 50%;
    padding: 20px;
}

.carousel-indicators {
    bottom: -50px;
}

.carousel-indicators button {
    background-color: #007bff;
    width: 12px;
    height: 12px;
    border-radius: 50%;
}
</style>
