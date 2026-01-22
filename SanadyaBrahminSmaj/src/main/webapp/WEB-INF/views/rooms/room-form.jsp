<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<%@ include file="/WEB-INF/views/includes/header.jsp" %>

<!DOCTYPE html>
<html>
<head>
<title>Room Management</title>

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
  ${room.id == null ? "➕ Add Room" : "✏️ Edit Room"}
</h3>

<form:form action="/rooms/save" method="post"
           enctype="multipart/form-data"
           modelAttribute="room"
           class="room-card">

<form:hidden path="id"/>

<!-- BASIC INFO -->
<div class="section-title">Basic Information</div>
<div class="row mt-2 g-3">

<div class="col-md-3">
  <label>Room Number</label>
  <form:input path="roomNumber" class="form-control"/>
  <form:errors path="roomNumber" cssClass="error"/>
</div>

<div class="col-md-3">
  <label>Floor</label>
  <form:input path="floor" class="form-control"/>
  <form:errors path="floor" cssClass="error"/>
</div>

<div class="col-md-3">
  <label>Room Type</label>
  <form:select path="roomType" class="form-select">
    <form:option value="Single">Single</form:option>
    <form:option value="Double">Double</form:option>
    <form:option value="Deluxe">Deluxe</form:option>
    <form:option value="Suite">Suite</form:option>
  </form:select>
  <form:errors path="roomType" cssClass="error"/>
</div>

<div class="col-md-3">
  <label>Status</label>
  <form:select path="status" class="form-select">
    <form:option value="AVAILABLE">AVAILABLE</form:option>
    <form:option value="MAINTENANCE">MAINTENANCE</form:option>
    <form:option value="BLOCKED">BLOCKED</form:option>
  </form:select>
  <form:errors path="status" cssClass="error"/>
</div>
</div>

<!-- CAPACITY -->
<div class="section-title">Capacity</div>
<div class="row mt-2 g-3">

<div class="col-md-3">
  <label>Max Adults</label>
  <form:input path="maxAdults" class="form-control"/>
  <form:errors path="maxAdults" cssClass="error"/>
</div>

<div class="col-md-3">
  <label>Max Children</label>
  <form:input path="maxChildren" class="form-control"/>
  <form:errors path="maxChildren" cssClass="error"/>
</div>
</div>

<!-- PRICING -->
<div class="section-title">Pricing</div>
<div class="row mt-2 g-3">

<div class="col-md-3">
  <label>Base Price</label>
  <form:input path="basePrice" class="form-control"/>
  <form:errors path="basePrice" cssClass="error"/>
</div>

<div class="col-md-3">
  <label>Min Stay</label>
  <form:input path="minStay" class="form-control"/>
  <form:errors path="minStay" cssClass="error"/>
</div>

<div class="col-md-3">
  <label>Max Stay</label>
  <form:input path="maxStay" class="form-control"/>
  <form:errors path="maxStay" cssClass="error"/>
</div>

<div class="col-md-3">
  <label>Advance Booking Days</label>
  <form:input path="advanceBookingDays" class="form-control"/>
  <form:errors path="advanceBookingDays" cssClass="error"/>
</div>
</div>

<!-- AVAILABILITY -->
<div class="section-title">Availability</div>
<div class="row mt-2 g-3">

<div class="col-md-3">
  <label>Available From</label>
  <form:input path="availableFrom" type="date" class="form-control"/>
  <form:errors path="availableFrom" cssClass="error"/>
</div>

<div class="col-md-3">
  <label>Available To</label>
  <form:input path="availableTo" type="date" class="form-control"/>
  <form:errors path="availableTo" cssClass="error"/>
</div>
</div>

<!-- FEATURES -->
<div class="section-title">Features</div>
<div class="row mt-2">
<div class="col-md-8">
  <label><form:checkbox path="gardenView"/> Garden View</label>
  <label class="ms-3"><form:checkbox path="hallRoom"/> Hall Room</label>
  <label class="ms-3"><form:checkbox path="housekeepingRequired"/> Housekeeping</label>
</div>
</div>

<!-- IMAGES -->
<div class="section-title">Images</div>
<input type="file" name="files" multiple class="form-control">

<!-- ACTIONS -->
<div class="row mt-4">
<div class="col-md-12 text-end">
  <button class="btn btnn px-4">Save</button>
  <a href="/rooms/admin" class="btn btn-secondary ms-2">Back</a>
</div>
</div>

</form:form>
</div>

<%@ include file="/WEB-INF/views/includes/footer.jsp" %>
</body>
</html>
