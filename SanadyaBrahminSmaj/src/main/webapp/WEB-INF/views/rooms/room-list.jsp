<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
<title>रूम प्रबंधन</title>
<style>
body {
  background: #fffaf4;
  font-family: 'Segoe UI','Noto Sans Devanagari',sans-serif;
}
.main-width { max-width:1200px; margin:auto; }
.room-card {
  background: linear-gradient(93deg,#ffedc2 65%,#fca854 100%);
  border-radius:18px;
  padding:18px 25px;
  margin-bottom:20px;
}
.room-title {
  font-size:1.3rem;
  font-weight:800;
  color:#5e3400;
}
</style>
</head>

<body>
<div class="container main-width my-4">

<!-- ================= ADMIN FILTER ================= -->
<form method="get" action="/rooms/admin" class="room-card mb-4">

  <h5 class="mb-3">🔍 रूम खोज (Admin)</h5>

  <div class="row g-3 align-items-end">

    <!-- Room Type -->
    <div class="col-md-2">
      <label class="fw-bold">रूम प्रकार</label>
      <select name="roomType" class="form-select">
        <option value="">सभी</option>
        <option value="ONLY_ROOM" ${param.roomType=='ONLY_ROOM'?'selected':''}>केवल कमरा</option>
        <option value="HALL" ${param.roomType=='HALL'?'selected':''}>हॉल</option>
        <option value="COMPLETE_FLOOR" ${param.roomType=='COMPLETE_FLOOR'?'selected':''}>पूरा फ्लोर</option>
      </select>
    </div>

    <!-- Floor -->
    <div class="col-md-2">
      <label class="fw-bold">फ्लोर</label>
      <input type="text"
             name="floor"
             class="form-control"
             value="${fn:escapeXml(param.floor)}"
             placeholder="Ground / 1st / 2nd">
    </div>

    <!-- Price Range -->
    <div class="col-md-2">
      <label class="fw-bold">न्यूनतम मूल्य</label>
      <input type="number" name="minPrice" class="form-control"
             value="${param.minPrice}">
    </div>

    <div class="col-md-2">
      <label class="fw-bold">अधिकतम मूल्य</label>
      <input type="number" name="maxPrice" class="form-control"
             value="${param.maxPrice}">
    </div>

    <!-- Status -->
    <div class="col-md-2">
      <label class="fw-bold">स्थिति</label>
      <select name="status" class="form-select">
        <option value="">सभी</option>
        <option value="AVAILABLE" ${param.status=='AVAILABLE'?'selected':''}>उपलब्ध</option>
        <option value="BOOKED" ${param.status=='BOOKED'?'selected':''}>बुक</option>
        <option value="CLEANING" ${param.status=='CLEANING'?'selected':''}>सफाई</option>
        <option value="MAINTENANCE" ${param.status=='MAINTENANCE'?'selected':''}>मरम्मत</option>
      </select>
    </div>

    <!-- Active -->
    <div class="col-md-2">
      <label class="fw-bold">सक्रिय</label>
      <select name="isActive" class="form-select">
        <option value="">सभी</option>
        <option value="true" ${param.isActive=='true'?'selected':''}>हाँ</option>
        <option value="false" ${param.isActive=='false'?'selected':''}>नहीं</option>
      </select>
    </div>

    <!-- Buttons -->
    <div class="col-md-12 text-end">
      <button class="btn btn-success btn-sm">फ़िल्टर</button>
      <a href="/rooms/admin" class="btn btn-secondary btn-sm">रीसेट</a>
      <a href="/rooms/admin/add" class="btn btn-primary btn-sm">➕ नया रूम</a>
    </div>

  </div>
</form>

<!-- ================= ROOM LIST ================= -->
<h4 class="mb-3">🏨 रूम सूची</h4>

<c:forEach items="${rooms}" var="r">
  <div class="room-card">

    <div class="room-title">
      ${r.roomTypeLabel} - रूम ${r.roomNumber}
    </div>

    <p>
      फ्लोर: ${r.floorLabel} |
      मूल्य: ₹${r.basePrice}
    </p>

    <p>
      स्थिति: ${r.statusLabel} |
      सक्रिय: ${r.activeLabel}
    </p>

    <div class="mb-2">
      <c:forEach items="${r.images}" var="img">
        <img src="/images/${img.imageUrl}" height="60">
      </c:forEach>
    </div>

    <div class="text-end">
      <a href="/rooms/admin/edit/${r.id}" class="btn btn-info btn-sm">Edit</a>
      <a href="/rooms/delete/${r.id}"
         onclick="return confirm('Delete this room?')"
         class="btn btn-danger btn-sm">Delete</a>
    </div>

  </div>
</c:forEach>

</div>
</body>
</html>

<%@ include file="/WEB-INF/views/includes/footer.jsp" %>
