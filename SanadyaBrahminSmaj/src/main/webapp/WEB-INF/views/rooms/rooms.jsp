<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

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
  border-radius:18px; padding:18px 25px;
  margin-bottom:20px;
  box-shadow:0 2px 16px rgba(160,128,32,0.08);
}
.room-title {
  font-size:1.4rem; font-weight:800;
  color:#5e3400;
  border-bottom:2px solid #e7c089;
  margin-bottom:8px;
}
.room-img {
  height:60px; width:80px;
  object-fit:cover; border-radius:8px;
  border:2px solid #fff;
}
.btnn {
  background: linear-gradient(95deg,#0ca100 60%,#32d653 100%);
  color:#fff; border-radius:8px;
  font-weight:700; border:none;
}
.toggle {
  transform: scale(1.2);
}
</style>
</head>

<body>
<div class="container main-width my-4">

<h2 class="text-center mb-4">🏨 Admin - Room Management</h2>
<!-- ADD / EDIT ROOM FORM -->
<div class="card p-4 shadow mb-4">
<h4 class="mb-3">➕ Add / Update Room</h4>

<form action="/rooms/save" method="post" enctype="multipart/form-data">
<div class="row g-3">

<!-- BASIC INFO -->
<div class="col-12">
<h5 class="text-primary">Basic Information</h5>
<hr>
</div>

<div class="col-md-3">
<label>Room Number</label>
<input name="roomNumber" class="form-control" placeholder="101 / A1">
</div>

<div class="col-md-3">
<label>Room Type</label>
<select name="roomType" class="form-select">
<option>Single</option>
<option>Double</option>
<option>Deluxe</option>
<option>Suite</option>
</select>
</div>

<div class="col-md-3">
<label>Floor</label>
<input name="floor" class="form-control" placeholder="1st / 2nd">
</div>

<div class="col-md-3">
<label>Status</label>
<select name="status" class="form-select">
<option value="AVAILABLE">AVAILABLE</option>
<option value="MAINTENANCE">MAINTENANCE</option>
<option value="BLOCKED">BLOCKED</option>
</select>
</div>

<!-- CAPACITY -->
<div class="col-12 mt-3">
<h5 class="text-primary">Capacity</h5>
<hr>
</div>

<div class="col-md-3">
<label>Max Adults</label>
<input name="maxAdults" class="form-control" type="number">
</div>

<div class="col-md-3">
<label>Max Children</label>
<input name="maxChildren" class="form-control" type="number">
</div>

<!-- PRICING -->
<div class="col-12 mt-3">
<h5 class="text-primary">Pricing</h5>
<hr>
</div>

<div class="col-md-3">
<label>Base Price (₹)</label>
<input name="basePrice" class="form-control">
</div>

<div class="col-md-3">
<label>Min Stay (days)</label>
<input name="minStay" class="form-control">
</div>

<div class="col-md-3">
<label>Max Stay (days)</label>
<input name="maxStay" class="form-control">
</div>

<div class="col-md-3">
<label>Advance Booking Days</label>
<input name="advanceBookingDays" class="form-control">
</div>

<!-- AVAILABILITY -->
<div class="col-12 mt-3">
<h5 class="text-primary">Availability</h5>
<hr>
</div>

<div class="col-md-3">
<label>Available From</label>
<input type="date" name="availableFrom" class="form-control">
</div>

<div class="col-md-3">
<label>Available To</label>
<input type="date" name="availableTo" class="form-control">
</div>

<!-- FEATURES -->
<div class="col-12 mt-3">
<h5 class="text-primary">Features</h5>
<hr>
</div>

<div class="col-md-6">
<label class="me-3">
<input type="checkbox" name="gardenView"> Garden View
</label>

<label class="me-3">
<input type="checkbox" name="hallRoom"> Hall Room
</label>

<label>
<input type="checkbox" name="housekeepingRequired"> Housekeeping Required
</label>
</div>

<!-- IMAGES -->
<div class="col-12 mt-3">
<h5 class="text-primary">Room Images</h5>
<hr>
</div>

<div class="col-md-6">
<label>Upload Images</label>
<input type="file" name="files" multiple class="form-control">
</div>

<!-- SUBMIT -->
<div class="col-12 mt-4 text-end">
<button class="btn btnn px-4">Save Room</button>
</div>

</div>
</form>
</div>

<!-- ROOM LIST -->
<c:forEach items="${rooms}" var="r">
<div class="room-card">

<div class="room-title">
${r.roomType} - Room ${r.roomNumber}
</div>

<div class="row">
<div class="col-md-8">
<b>Floor:</b> ${r.floor} |
<b>Price:</b> ₹${r.basePrice} |
<b>Adults:</b> ${r.maxAdults} |
<b>Children:</b> ${r.maxChildren} <br>

<b>Stay:</b> ${r.minStay}-${r.maxStay} days |
<b>Advance:</b> ${r.advanceBookingDays} days <br>

<b>Garden:</b> ${r.gardenView?'Yes':'No'} |
<b>Hall:</b> ${r.hallRoom?'Yes':'No'} |
<b>Housekeeping:</b> ${r.housekeepingRequired?'Yes':'No'} <br>

<b>Status:</b>
<span class="badge bg-${r.status=='AVAILABLE'?'success':'warning'}">
${r.status}
</span>

<b class="ms-3">Active:</b>
<input type="checkbox" class="toggle" ${r.isActive?'checked':''} disabled>

</div>

<div class="col-md-4 text-end">
<button class="btn btn-info btn-sm" onclick="editRoom(${r.id})">Edit</button>
<a href="/rooms/delete/${r.id}"
   onclick="return confirm('Delete this room?')"
   class="btn btn-danger btn-sm">Delete</a>
</div>
</div>

<div class="mt-2">
<c:forEach items="${r.images}" var="img">
<img src="/images${img.imageUrl}" class="room-img">
</c:forEach>
</div>

</div>
</c:forEach>
</div>

<!-- EDIT MODAL -->
<div class="modal fade" id="editModal">
<div class="modal-dialog modal-lg">
<div class="modal-content">
<div class="modal-header bg-warning">
<h5>Edit Room</h5>
<button class="btn-close" data-bs-dismiss="modal"></button>
</div>
<div class="modal-body">
<form action="/rooms/save" method="post" enctype="multipart/form-data">

<input type="hidden" id="editId" name="id">

<input id="editRoomNumber" name="roomNumber" class="form-control mb-2">
<input id="editFloor" name="floor" class="form-control mb-2">
<input id="editPrice" name="basePrice" class="form-control mb-2">
<input id="editMaxAdults" name="maxAdults" class="form-control mb-2">
<input id="editMaxChildren" name="maxChildren" class="form-control mb-2">

<select id="editType" name="roomType" class="form-select mb-2">
<option>Single</option><option>Double</option>
<option>Deluxe</option><option>Suite</option>
</select>

<select id="editStatus" name="status" class="form-select mb-2">
<option value="AVAILABLE">AVAILABLE</option>
<option value="MAINTENANCE">MAINTENANCE</option>
<option value="BLOCKED">BLOCKED</option>
</select>

<label><input type="checkbox" id="editGarden" name="gardenView"> Garden</label>
<label class="ms-3"><input type="checkbox" id="editHall" name="hallRoom"> Hall</label>
<label class="ms-3"><input type="checkbox" id="editHouse" name="housekeepingRequired"> Housekeeping</label>

<input type="file" name="files" multiple class="form-control mt-2">
<button class="btn btnn mt-3">Update</button>
</form>
</div>
</div>
</div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
function editRoom(id){
  $.get("/rooms/get/"+id,function(r){
    $("#editId").val(r.id);
    $("#editRoomNumber").val(r.roomNumber);
    $("#editFloor").val(r.floor);
    $("#editPrice").val(r.basePrice);
    $("#editMaxAdults").val(r.maxAdults);
    $("#editMaxChildren").val(r.maxChildren);
    $("#editType").val(r.roomType);
    $("#editStatus").val(r.status);
    $("#editGarden").prop("checked", r.gardenView);
    $("#editHall").prop("checked", r.hallRoom);
    $("#editHouse").prop("checked", r.housekeepingRequired);
    $("#editModal").modal("show");
  });
}
</script>

<%@ include file="/WEB-INF/views/includes/footer.jsp" %>
</body>
</html>
