<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %> <%-- Modern JSTL URI for Jakarta EE --%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Team Showcase</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <style>
        body {
            background-color: #f8f9fa;
        }
        .testimonial-carousel {
            background-color: #ffffff;
            border-radius: 15px;
            padding: 40px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }
        .testimonial-carousel .carousel-item {
            /* Ensures smooth transitions, prevents item content from briefly disappearing */
            transition: transform 0.6s ease-in-out;
        }
        .profile-img {
            width: 120px;
            height: 120px;
            object-fit: cover;
            border-radius: 50%;
            border: 5px solid #e9ecef;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        .carousel-content {
            text-align: center;
        }
        .carousel-content h5 {
            font-weight: bold;
            color: #343a40;
            margin-top: 15px;
            font-size: 1.25rem;
        }
        .carousel-content .designation {
            color: #6c757d;
            font-style: italic;
            margin-bottom: 20px;
        }
        .editorial-quote {
            font-size: 1.1rem;
            color: #495057;
            border-left: 4px solid #0d6efd;
            padding-left: 20px;
            margin: 0 auto;
            max-width: 80%;
        }
        /* Style for Carousel Controls */
        .carousel-control-prev-icon,
        .carousel-control-next-icon {
            background-color: #0d6efd;
            border-radius: 50%;
            padding: 20px;
            background-size: 50%;
        }
    </style>
</head>
<body>

<div class="container py-5">
    <div id="testimonialCarousel" class="carousel slide testimonial-carousel" data-bs-ride="carousel">
        <div class="carousel-inner">
            
            <%-- 
              Loop through a list of people (e.g., 'people') passed from your Spring Controller.
              Each 'person' object should have fields like: imageUrl, name, designation, and editorial.
            --%>
            <c:forEach items="${people}" var="person" varStatus="loop">
                <div class="carousel-item ${loop.index == 0 ? 'active' : ''}">
                    <div class="carousel-content">
                        <img src="<c:url value='${person.imageUrl}'/>" class="profile-img" alt="${person.name}">
                        
                        <h5>${fn:escapeXml(person.name)}</h5>
                        <p class="designation">${fn:escapeXml(person.designation)}</p>
                        
                        <blockquote class="editorial-quote">
                            <p>"${fn:escapeXml(person.editorial)}"</p>
                        </blockquote>
                    </div>
                </div>
            </c:forEach>

            <%-- Fallback content if the 'people' list is empty --%>
            <c:if test="${empty people}">
                <div class="carousel-item active">
                    <div class="carousel-content">
                         <img src="/path/to/default-image.png" class="profile-img" alt="Default">
                         <h5>No Profiles Available</h5>
                         <p class="designation">Please check back later.</p>
                         <blockquote class="editorial-quote">
                             <p>"Content is currently being updated."</p>
                         </blockquote>
                    </div>
                </div>
            </c:if>

        </div>

        <!-- Carousel Controls -->
        <button class="carousel-control-prev" type="button" data-bs-target="#testimonialCarousel" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#testimonialCarousel" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
        </button>
    </div>
</div>

<!-- Bootstrap 5 JS and jQuery -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
