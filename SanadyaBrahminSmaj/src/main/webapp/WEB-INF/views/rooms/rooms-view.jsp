<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ include file="/WEB-INF/views/includes/header.jsp" %>

<!DOCTYPE html>
<html lang="hi">
<head>
    <title>मुख्य पृष्ठ - सनाढ्य ब्राह्मण सभा, कोटा</title>

    <style>
        body {
            background: #fffaf4;
            font-family: 'Segoe UI', 'Noto Sans Devanagari', sans-serif;
        }

        .main-width {
            max-width: 1200px;
            margin: auto;
        }

        .room-card {
            background: linear-gradient(93deg, #ffedc2 65%, #fca854 100%);
            box-shadow: 0 2px 16px rgba(160, 128, 32, 0.08);
            border-radius: 18px;
            margin-bottom: 25px;
            padding: 18px 25px;
            transition: 0.2s;
        }

        .room-card:hover {
            transform: translateY(-5px);
            background: linear-gradient(87deg, #fff8e3 70%, #ffaa56 97%);
        }

        .room-title {
            font-size: 1.4rem;
            font-weight: 800;
            color: #5e3400;
            border-bottom: 2px solid #e7c089;
            margin-bottom: 10px;
        }

        .room-img {
            height: 220px;
            object-fit: cover;
            border-radius: 12px;
        }

        .btnn {
            background: linear-gradient(95deg, #0ca100 60%, #32d653 100%);
            color: #fff;
            border-radius: 8px;
            font-weight: 700;
            border: none;
        }
    </style>
</head>

<body>

<div class="container main-width my-4">
    <h2 class="text-center mb-4">🏨 उपलब्ध कमरे</h2>

    <div class="row">
        <c:forEach items="${rooms}" var="r">
            <div class="col-md-4">
                <div class="room-card">

                    <!-- Carousel -->
                    <div id="carousel${r.id}" class="carousel slide" data-bs-ride="carousel">
                        <div class="carousel-inner">
                            <c:forEach items="${r.images}" var="img" varStatus="st">
                                <div class="carousel-item ${st.index==0?'active':''}">
                                    <!-- IMPORTANT: Correct path -->
                                    <img src="/images/${img.imageUrl}"
                                         class="d-block w-100 room-img">
                                </div>
                            </c:forEach>
                        </div>

                        <!-- Controls (optional but professional) -->
                        <button class="carousel-control-prev" type="button"
                                data-bs-target="#carousel${r.id}" data-bs-slide="prev">
                            <span class="carousel-control-prev-icon"></span>
                        </button>
                        <button class="carousel-control-next" type="button"
                                data-bs-target="#carousel${r.id}" data-bs-slide="next">
                            <span class="carousel-control-next-icon"></span>
                        </button>
                    </div>

                    <div class="room-title mt-2">
                        ${r.roomType} - Room ${r.roomNumber}
                    </div>

                    <p><b>Floor:</b> ${r.floor}</p>
                    <h5 class="text-success">₹${r.basePrice} / night</h5>

                    <button class="btn btnn w-100 mt-2">Book Now</button>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<%@ include file="/WEB-INF/views/includes/footer.jsp" %>

</body>
</html>
