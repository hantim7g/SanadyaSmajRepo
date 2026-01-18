<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>

<%@ include file="/WEB-INF/views/includes/header.jsp" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="hi">
<head>
  <meta charset="UTF-8">
  <title>हमारे पदाधिकारी</title>
<!--
   Bootstrap 5 
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

   Devanagari Font 
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+Devanagari:wght@400;600;700&display=swap" rel="stylesheet">
-->
  <style>
    body {
      font-family: 'Noto Sans Devanagari', sans-serif;
      background: linear-gradient(180deg, #fff7ed, #ffffff);
    }

    .page-title {
      font-weight: 800;
      color: #8a2c00;
      position: relative;
      display: inline-block;
      padding-bottom: 6px;
      font-size: 1.4rem;
    }

    .page-title::after {
      content: "";
      position: absolute;
      width: 55%;
      height: 3px;
      background: linear-gradient(90deg, #f87e03, #ffb347);
      bottom: 0;
      left: 22%;
      border-radius: 10px;
    }

    .officer-card {
      background: #ffffff;
      border-radius: 14px;
      padding: 12px 8px;
      box-shadow: 0 6px 16px rgba(0,0,0,0.08);
      transition: all 0.25s ease;
      height: 100%;
    }

    .officer-card:hover {
      transform: translateY(-4px);
      box-shadow: 0 10px 22px rgba(248,126,3,0.35);
    }

    .square-img {
      width:115px;
      height: 130px;
      object-fit: cover;
      border-radius: 14px;
       padding: 2px;
     
    }

    .officer-name {
      font-weight: 700;
      font-size: 0.9rem;
      margin-top: 8px;
      line-height: 1.2;
      color: #2d2d2d;
    }

    .officer-role {
      font-size: 1.2rem;
      font-weight: 600;
      color: #f87e03;
     
      display: inline-block;
      padding: 2px 10px;
      border-radius: 14px;
      margin-top: 4px;
    }
  </style>
</head>

<body>

<div class="container my-4">

  <!-- Title -->
  <div class="text-center mb-4">
    <h2 class="page-title">हमारे पदाधिकारी</h2>
  </div>

  <!-- Officers Grid -->
  <div class="row g-3 justify-content-center">

    <c:forEach items="${officials}" var="o">
      <div class="col-6 col-sm-4 col-md-3 col-lg-2">
        <div class="officer-card text-center">

          <img src="${o.profileImagePath}"
               class="square-img"
               alt="पदाधिकारी फोटो"
               onerror="this.src='/assets/images/user-default.png'">

          <div class="officer-name">
            ${fn:escapeXml(o.fullName)}
          </div>

          <div class="officer-role">
            ${fn:escapeXml(o.smajRole)}
          </div>

        </div>
      </div>
    </c:forEach>

    <!-- Empty state -->
    <c:if test="${empty officials}">
      <div class="col-12 text-center text-muted">
        कोई पदाधिकारी उपलब्ध नहीं है
      </div>
    </c:if>

  </div>

</div>

</body>
</html> 			<%@ include file="/WEB-INF/views/includes/footer.jsp" %>
