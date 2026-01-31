<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<%@ include file="/WEB-INF/views/includes/header.jsp" %>

<!DOCTYPE html>
<html lang="hi">
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
  padding:22px 28px;
  margin-bottom:20px;
  box-shadow:0 2px 16px rgba(160,128,32,0.08);
}

.section-title {
  font-weight:800;
  color:#7a4200;
  margin-top:22px;
  border-bottom:1px dashed #e7c089;
  padding-bottom:6px;
}

.btnn {
  background: linear-gradient(95deg,#0ca100 60%,#32d653 100%);
  color:#fff;
  border-radius:8px;
  font-weight:700;
  border:none;
}

.error {
  color:#b00020;
  font-size:0.85rem;
  font-weight:600;
}
</style>
</head>

<body>
<div class="container main-width my-4">

<h3 class="mb-3">
  ${room.id == null ? "➕ नया रूम जोड़ें" : "✏️ रूम संशोधित करें"}
</h3>

<form:form action="/rooms/save" method="post"
           enctype="multipart/form-data"
           modelAttribute="room"
           class="room-card">

<form:hidden path="id"/>

<!-- BASIC INFO -->
<div class="section-title">मूल जानकारी</div>
<div class="row mt-2 g-3">

<div class="col-md-3">
  <label>रूम संख्या</label>
  <form:input path="roomNumber" class="form-control"/>
  <form:errors path="roomNumber" cssClass="error"/>
</div>

<div class="col-md-3">
  <label>फ्लोर</label>
  <form:input path="floor" class="form-control"/>
  <form:errors path="floor" cssClass="error"/>
</div>

<div class="col-md-3">
  <label>रूम का प्रकार</label>
  <form:select path="roomType" class="form-select">
      <form:option value="ONLY_ROOM">केवल कमरा</form:option>
      <form:option value="HALL">हॉल</form:option>
      <form:option value="COMPLETE_FLOOR">पूरा फ्लोर</form:option>
  </form:select>
  <form:errors path="roomType" cssClass="error"/>
</div>

<div class="col-md-3">
  <label>स्थिति</label>
  <form:select path="status" class="form-select">
    <form:option value="AVAILABLE">उपलब्ध</form:option>
    <form:option value="MAINTENANCE">मरम्मत में</form:option>
    <form:option value="BLOCKED">अवरुद्ध</form:option>
  </form:select>
  <form:errors path="status" cssClass="error"/>
</div>
</div>

<!-- PRICING -->
<div class="section-title">मूल्य विवरण</div>
<div class="row mt-2 g-3">

<div class="col-md-3">
  <label>आधार मूल्य (₹)</label>
  <form:input path="basePrice" class="form-control"/>
  <form:errors path="basePrice" cssClass="error"/>
</div>

<div class="col-md-3">
  <label>न्यूनतम प्रवास (दिन)</label>
  <form:input path="minStay" class="form-control"/>
  <form:errors path="minStay" cssClass="error"/>
</div>

<div class="col-md-3">
  <label>अधिकतम प्रवास (दिन)</label>
  <form:input path="maxStay" class="form-control"/>
  <form:errors path="maxStay" cssClass="error"/>
</div>

<div class="col-md-3">
  <label>अग्रिम बुकिंग दिवस</label>
  <form:input path="advanceBookingDays" class="form-control"/>
  <form:errors path="advanceBookingDays" cssClass="error"/>
</div>
</div>

<!-- AVAILABILITY -->
<div class="section-title">उपलब्धता</div>
<div class="row mt-2 g-3">

<div class="col-md-3">
  <label>उपलब्धता प्रारंभ तिथि</label>
  <form:input path="availableFrom" type="date" class="form-control"/>
  <form:errors path="availableFrom" cssClass="error"/>
</div>

<div class="col-md-3">
  <label>उपलब्धता समाप्ति तिथि</label>
  <form:input path="availableTo" type="date" class="form-control"/>
  <form:errors path="availableTo" cssClass="error"/>
</div>
</div>

<!-- IMAGES -->
<div class="section-title">रूम की तस्वीरें</div>
<input type="file" name="files" multiple class="form-control">

<small class="text-muted">
  एक से अधिक तस्वीरें चुनने के लिए Ctrl / Shift का उपयोग करें
</small>

<!-- ACTIONS -->
<div class="row mt-4">
<div class="col-md-12 text-end">
  <button class="btn btnn px-4">सहेजें</button>
  <a href="/rooms/admin" class="btn btn-secondary ms-2">वापस जाएँ</a>
</div>
</div>

</form:form>
</div>

<%@ include file="/WEB-INF/views/includes/footer.jsp" %>
</body>
</html>
