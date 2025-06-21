<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>विज्ञापन स्लाइड</title>
    <style>
        .ad-carousel .carousel-item img {
            height: 250px;
            object-fit: cover;
            width: 100%;
            border-radius: 8px;
        }
        .carousel-caption {
            background-color: rgba(0, 0, 0, 0.5);
            padding: 10px 15px;
            border-radius: 8px;
        }
        .carousel-caption h5 {
            color: #fff;
            font-weight: bold;
        }
    </style>
</head>
<body>

<div class="container py-4">
   

    <div id="adCarousel" class="carousel slide ad-carousel shadow" data-bs-ride="carousel">
        <div class="carousel-inner">

            <!-- Slide 1 -->
            <div class="carousel-item active">
                <a href="https://your-ad-link-1.com" target="_blank">
                    <img src="/images/ads/ad1.jpg" class="d-block w-100" alt="Ad 1">
                </a>
               
            </div>

            <!-- Slide 2 -->
            <div class="carousel-item">
                <a href="https://your-ad-link-2.com" target="_blank">
                    <img src="/images/ads/ad1.jpg" class="d-block w-100" alt="Ad 2">
                </a>
                
            </div>

            <!-- Slide 3 -->
            <div class="carousel-item">
                <a href="https://your-ad-link-3.com" target="_blank">
                    <img src="/images/ads/ad1.jpg" class="d-block w-100" alt="Ad 3">
                </a>
               
            </div>

        </div>

        <!-- Controls -->
        <button class="carousel-control-prev" type="button" data-bs-target="#adCarousel" data-bs-slide="prev">
            <span class="carousel-control-prev-icon"></span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#adCarousel" data-bs-slide="next">
            <span class="carousel-control-next-icon"></span>
        </button>
    </div>
</div>

</body>
</html>
