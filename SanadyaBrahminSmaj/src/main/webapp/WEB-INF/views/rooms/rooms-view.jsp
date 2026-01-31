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

<h3 class="text-center mb-4 page-title">🔍 रूम खोजें</h3>

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
      <input type="date" name="fromDate" class="form-control">
    </div>

	<div class="col-md-2 col-sm-6">
      <label class="fw-bold">प्रस्थान तिथि</label>
      <input type="date" name="toDate" class="form-control">
    </div>

    <div class="col-md-2">
      <label class="fw-bold">फ्लोर</label>
      <select name="floor" class="form-select">
        <option value="">सभी फ्लोर</option>
        <option value="Ground">ग्राउंड फ्लोर</option>
        <option value="1st">पहला फ्लोर</option>
        <option value="2nd">दूसरा फ्लोर</option>
        <option value="3rd">तीसरा फ्लोर</option>
      </select>
    </div>

    <!-- Hidden defaults -->
    <input type="hidden" name="status" value="AVAILABLE">
    <input type="hidden" name="isActive" value="true">

  </div>
</form>

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

  const form = document.getElementById("roomFilterForm");

  form.querySelectorAll("select, input").forEach(el => {
    el.addEventListener("change", loadRooms);
    el.addEventListener("keyup", loadRooms);
  });

  loadRooms();
});

function loadRooms() {
  const form = document.getElementById("roomFilterForm");
  const params = new URLSearchParams(new FormData(form)).toString();

  document.getElementById("roomContainer").innerHTML = "";
  document.getElementById("noRoomsMsg").style.display = "none";
  document.getElementById("skeletonLoader").style.display = "flex";

  fetch("/rooms/filter?" + params)
    .then(res => res.text())
    .then(html => {
      document.getElementById("skeletonLoader").style.display = "none";
      document.getElementById("roomContainer").innerHTML = html;

      if (!html.trim()) {
        document.getElementById("noRoomsMsg").style.display = "block";
      }
    })
    .catch(err => {
      document.getElementById("skeletonLoader").style.display = "none";
      console.error(err);
    });
}
</script>

</body>
</html>

<%@ include file="/WEB-INF/views/includes/footer.jsp" %>
