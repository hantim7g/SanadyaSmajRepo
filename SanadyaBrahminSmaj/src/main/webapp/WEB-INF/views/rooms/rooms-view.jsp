<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="hi">
<head>
<title>रूम खोजें - सनाढ्य ब्राह्मण सभा</title>

<style>
body {
  background: #fffaf4;
  font-family: 'Segoe UI','Noto Sans Devanagari',sans-serif;
}

/* Layout */
.main-width {
  max-width: 1200px;
  margin: auto;
}

/* Page title */
.page-title {
  font-weight: 800;
  color: #5e3400;
}

/* Filter card */
.filter-card {
  background: linear-gradient(93deg,#ffedc2 65%,#fca854 100%);
  border-radius: 18px;
  padding: 18px 22px;
  box-shadow: 0 2px 16px rgba(160,128,32,0.12);
  border: none;
}

/* Room card */
.room-card {
  background: linear-gradient(93deg,#ffedc2 65%,#fca854 100%);
  border-radius: 18px;
  box-shadow: 0 2px 16px rgba(160,128,32,0.12);
  transition: transform 0.3s ease, box-shadow 0.3s ease;
  overflow: hidden;
}

.room-card:hover {
  transform: translateY(-6px) scale(1.02);
  box-shadow: 0 12px 28px rgba(160,128,32,0.35);
}

.room-card img {
  height: 200px;
  width: 100%;
  object-fit: cover;
}

/* Price badge */
.price-badge {
  position: absolute;
  top: 12px;
  right: 12px;
  background: linear-gradient(95deg,#0ca100 60%,#32d653 100%);
  color: #fff;
  font-weight: 700;
  padding: 6px 12px;
  border-radius: 12px;
  font-size: 14px;
  z-index: 2;
}

/* Button */
.btn-book {
  background: linear-gradient(95deg,#0ca100 60%,#32d653 100%);
  color: #fff;
  font-weight: 700;
  border-radius: 10px;
  border: none;
}

.btn-book:hover {
  opacity: 0.9;
}

/* Empty message */
#noRoomsMsg {
  display: none;
  color: #8a3f01;
  font-weight: 700;
}

/* Skeleton loader */
.skeleton-card {
  height: 300px;
  border-radius: 18px;
  background: linear-gradient(
    90deg,
    #f5d9a6 25%,
    #ffe8c4 37%,
    #f5d9a6 63%
  );
  background-size: 400% 100%;
  animation: shimmer 1.4s ease infinite;
}

@keyframes shimmer {
  0% { background-position: 100% 0; }
  100% { background-position: -100% 0; }
}


</style>
</head>

<body>
<div class="container main-width my-4">

<h3 class="text-center mb-4 page-title">🔍 रूम/हॉल/फ्लोर खोजें</h3>

<!-- ================= FILTER FORM ================= -->
<form id="roomFilterForm" class="filter-card mb-4">
  <div class="row g-3">

	<div class="col-md-2 col-sm-6">
      <label class="fw-bold">रूम का प्रकार</label>
      <select name="roomType" class="form-select">
        <option value="">सभी प्रकार</option>
        <option value="ONLY_ROOM">केवल कमरा</option>
        <option value="HALL">हॉल</option>
        <option value="COMPLETE_FLOOR">पूरा फ्लोर</option>
		<option value="COMPLETE_BUILDING">सामुदायिक भवन</option>  
      </select>
    </div>

	<div class="col-md-4 ">
      <label class="fw-bold">मूल्य सीमा (₹)</label>
      <div class="d-flex gap-2">
        <input type="number" name="minPrice" class="form-control" placeholder="न्यूनतम">
        <input type="number" name="maxPrice" class="form-control" placeholder="अधिकतम">
      </div>
    </div>

	<div class="col-md-2 col-sm-6">
      <label class="fw-bold">आगमन तिथि</label>

	  <input type="date" id="fromDate" name="fromDate" class="form-control" required>
    </div>

	<div class="col-md-2 col-sm-6">
      <label class="fw-bold">प्रस्थान तिथि</label>
      <input type="date" id="toDate" name="toDate" class="form-control" required>
    </div>

    <div class="col-md-2">
      <label class="fw-bold">फ्लोर</label>
      <select name="floor" class="form-select">
        <option value="">सभी फ्लोर</option>
        
		     <option value="ग्राउंड फ्लोर">ग्राउंड फ्लोर</option>
		     <option value="पहला फ्लोर">पहला फ्लोर</option>
		     <option value="दूसरा फ्लोर">दूसरा फ्लोर</option>
			 <option value="सामुदायिक भवन">सामुदायिक भवन</option>

		
      </select>
    </div>

    <!-- Hidden defaults -->
    <input type="hidden" name="status" value="AVAILABLE">
    <input type="hidden" name="isActive" value="true">

  </div>
</form>
<div id="dateErrorMsg"
     class="text-center mt-2"
     style="display:none; color:#b00020; font-weight:700;">
  ⚠️ कृपया आगमन एवं प्रस्थान तिथि चुनें
</div>

<!-- ================= RESULT ================= -->
<div id="skeletonLoader" class="row g-4" style="display:none;">
  <c:forEach begin="1" end="6">
    <div class="col-md-4">
      <div class="skeleton-card"></div>
    </div>
  </c:forEach>
</div>

<div id="roomResult">
  <div class="row g-4" id="roomContainer"></div>
</div>

<div id="noRoomsMsg" class="text-center mt-4">
  😔 कोई रूम उपलब्ध नहीं है
</div>

</div>
<script>
document.addEventListener("DOMContentLoaded", () => {
  const fromDateInput = document.getElementById("fromDate");
  const toDateInput = document.getElementById("toDate");
  const form = document.getElementById("roomFilterForm");

  // 1. Setup Initial Dates (Today + 1 and Today + 2)
  const today = new Date();
  
  // Arrival: Tomorrow
  const tomorrow = new Date(today);
  tomorrow.setDate(today.getDate() );
  const tomorrowStr = tomorrow.toISOString().split("T")[0];

  // Departure: Day after Tomorrow
  const dayAfter = new Date(tomorrow);
  dayAfter.setDate(tomorrow.getDate() + 1);
  const dayAfterStr = dayAfter.toISOString().split("T")[0];

  // Apply to inputs
  fromDateInput.value = tomorrowStr;
  fromDateInput.min = tomorrowStr;
  
  toDateInput.value = dayAfterStr;
  toDateInput.min = dayAfterStr;

  // 2. Logic: When Arrival Date changes
  fromDateInput.addEventListener("change", () => {
    const selectedArrival = new Date(fromDateInput.value);
    
    // Departure must be at least one day after Arrival
    const minDeparture = new Date(selectedArrival);
    minDeparture.setDate(selectedArrival.getDate() + 1);
    const minDepartureStr = minDeparture.toISOString().split("T")[0];

    toDateInput.min = minDepartureStr;

    // If current Departure is before or equal to new Arrival, reset it
    if (toDateInput.value <= fromDateInput.value) {
      toDateInput.value = minDepartureStr;
    }
    
    loadRooms(); // Trigger refresh
  });

  // 3. Setup Filter Listeners
  form.querySelectorAll("select, input:not([type='date'])").forEach(el => {
    el.addEventListener("change", loadRooms);
    el.addEventListener("keyup", loadRooms);
  });
  
  // Departure change also triggers refresh
  toDateInput.addEventListener("change", loadRooms);

  // Initial Load
  loadRooms();
});

function loadRooms() {
  const fromDate = document.getElementById("fromDate");
  const toDate   = document.getElementById("toDate");
  const errorMsg = document.getElementById("dateErrorMsg");
  const container = document.getElementById("roomContainer");
  const skeleton = document.getElementById("skeletonLoader");
  const noRooms = document.getElementById("noRoomsMsg");

  if (!fromDate.value || !toDate.value) {
    errorMsg.style.display = "block";
    container.innerHTML = "";
    return;
  }

  errorMsg.style.display = "none";
  noRooms.style.display = "none";
  skeleton.style.display = "flex";
  container.innerHTML = "";

  const form = document.getElementById("roomFilterForm");
  const params = new URLSearchParams(new FormData(form)).toString();

  fetch("/rooms/filter?" + params)
    .then(res => res.text())
    .then(html => {
      skeleton.style.display = "none";
      container.innerHTML = html;
      if (!html.trim()) {
        noRooms.style.display = "block";
      }
    })
    .catch(err => {
      skeleton.style.display = "none";
      console.error("Fetch error:", err);
    });
}</script>

</body>
</html>

<%@ include file="/WEB-INF/views/includes/footer.jsp" %>
