<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>


<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<!-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>मुख्य पृष्ठ - सनाढ्य ब्राह्मण सभा, कोटा</title>


    <style>
       

        .main-wrapper {
            padding: 20px;
        }

        @media (max-width: 768px) {
            .main-wrapper {
                padding: 10px;
            }
        }

       .carousel-item img {
    height: 550px;
    object-fit: cover;
    width: 100%;
}

@media (max-width: 768px) {
    .carousel-item img {
        height: 300px;
    }
}

        .carousel-caption-custom {
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            background-color: rgba(0, 0, 0, 0.4);
            padding: 15px 25px;
            font-family: 'Noto Sans Devanagari', sans-serif;
            color: #fff;
            text-align: left;
        }

        .carousel-title {
            font-size: 1.8rem;
            font-weight: 700;
            margin-bottom: 5px;
        }

        .carousel-subtitle {
            font-size: 1rem;
            font-weight: 400;
            color: #e0e0e0;
        }

        @media (max-width: 768px) {
            .carousel-title {
                font-size: 1.2rem;
            }

            .carousel-subtitle {
                font-size: 0.9rem;
            }
        }

        .marquee-container {
            height: 200px;
            overflow: hidden;
            position: relative;
            background-color: #fff3e0;
            border: 1px solid #e0a800;
            padding: 10px;
            font-size: clamp(12px, 1.6vw, 14px);
            line-height: 1.4;
        }

        .marquee-content {
            position: absolute;
            width: 100%;
            animation: scroll-up 12s linear infinite;
        }

        .marquee-container:hover .marquee-content {
            animation-play-state: paused;
        }

        @keyframes scroll-up {
            0% { top: 100%; }
            100% { top: -100%; }
        }

        .event-item {
            padding: 6px 12px;
            border-bottom: 1px dashed #ff9800;
            font-weight: 600;
            color: #212121;
            transition: background 0.3s;
        }

        .event-item:hover {
            background-color: #fff8e1;
            cursor: pointer;
        }

        h4.section-title {
            text-align: center;
            color: #e65100;
            font-weight: 600;
            margin-bottom: 12px;
        }
/* 🔔 Top Ticker - Stylish Red, Hover Pause */
.ticker-top-alert {
    overflow: hidden;
    white-space: nowrap;
    position: relative;
    background: transparent;
    height: 40px;
    display: flex;
    align-items: center;
    padding-left: 10px;
}

.ticker-slide {
    display: inline-block;
    padding-left: 100%;
    font-size: 1.2rem;
    font-weight: bold;
    color: #f80000; /* Beautiful strong red */
    animation: ticker-left 30s linear infinite;
    white-space: nowrap;
}

.ticker-top-alert:hover .ticker-slide {
    animation-play-state: paused;
}

@keyframes ticker-left {
    0% { transform: translateX(0%); }
    100% { transform: translateX(-100%); }
}

    </style>
</head>
<body>
<!-- 🔔 Top Ticker Alert -->
<div class="ticker-top-alert">
  <div class="ticker-slide">
    🔔 विशेष सूचना: समाज की वार्षिक आम सभा 15 जुलाई को आयोजित की जाएगी | सभी सदस्यों से अनुरोध है समय पर पधारें।
  </div>
</div>


<div class="container-fluid main-wrapper">
    <div class="row g-4">
        <!-- Left: Carousel -->
        <div class="col-lg-7 col-md-12">
            <div id="eventCarousel" class="carousel slide shadow" data-bs-ride="carousel">
                <div class="carousel-inner">
                    <div class="carousel-item active">
                        <a href="/events/1" style="text-decoration: none;">
                            <img src="/images/corosal1.jpg" class="d-block w-100" alt="Event 1">
                            <div class="carousel-caption-custom">
                                <div class="carousel-title">वार्षिक सम्मेलन 2025</div>
                                <div class="carousel-subtitle">समाज के सभी सदस्यों के लिए वार्षिक मिलन</div>
                            </div>
                        </a>
                    </div>
                    <div class="carousel-item">
                        <a href="/events/2" style="text-decoration: none;">
                            <img src="/images/corosal1.jpg" class="d-block w-100" alt="Event 2">
                            <div class="carousel-caption-custom">
                                <div class="carousel-title">स्वास्थ्य जांच शिविर</div>
                                <div class="carousel-subtitle">नि:शुल्क स्वास्थ्य जांच - अनुभवी डॉक्टर्स द्वारा</div>
                            </div>
                        </a>
                    </div>
                    <div class="carousel-item">
                        <a href="/events/3" style="text-decoration: none;">
                            <img src="/images/corosal1.jpg" class="d-block w-100" alt="Event 3">
                            <div class="carousel-caption-custom">
                                <div class="carousel-title">युवा सम्मेलन</div>
                                <div class="carousel-subtitle">युवाओं के लिए प्रेरक सत्र और नेटवर्किंग</div>
                            </div>
                        </a>
                    </div>
                </div>
                <button class="carousel-control-prev" type="button" data-bs-target="#eventCarousel" data-bs-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#eventCarousel" data-bs-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                </button>
            </div>
        </div>

        <!-- Right: Upcoming Events -->
        <div class="col-lg-5 ">
        <div class="col-md-12 ">
            <jsp:include page="/WEB-INF/views/upcoming-events.jsp" />
        </div>
            <div   class="col-md-12 ">
            <jsp:include page="/WEB-INF/views/adds.jsp" />
        </div>
        
    </div>
</div>

</body>
</html>
