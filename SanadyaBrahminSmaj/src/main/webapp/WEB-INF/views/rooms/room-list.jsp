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
  border-radius:18px;
  padding:18px 25px;
  margin-bottom:20px;
  box-shadow:0 2px 16px rgba(160,128,32,0.08);
}
.room-title {
  font-size:1.4rem;
  font-weight:800;
  color:#5e3400;
  border-bottom:2px solid #e7c089;
  margin-bottom:8px;
}
.btnn {
  background: linear-gradient(95deg,#0ca100 60%,#32d653 100%);
  color:#fff;
  border-radius:8px;
  font-weight:700;
  border:none;
}
.section-title {
  font-weight:700;
  color:#7a4200;
  margin-top:20px;
  border-bottom:1px dashed #e7c089;
  padding-bottom:5px;
}
</style>
</head>

<body>
<div class="container main-width my-4">
<div class="d-flex justify-content-between mb-3">
<h3>🏨 Room List</h3>
<a href="/rooms/admin/add" class="btn btnn">➕ Add Room</a>
</div>

<c:forEach items="${rooms}" var="r">
<div class="room-card">

<div class="room-title">${r.roomType} - ${r.roomNumber}</div>

<p>
Floor: ${r.floor} |
Price: ₹${r.basePrice} |
Adults: ${r.maxAdults} |
Children: ${r.maxChildren}
</p>

<p>
Status:
<span class="badge bg-${r.status=='AVAILABLE'?'success':'warning'}">
${r.status}
</span>
|
Active:
<input type="checkbox" ${r.isActive?'checked':''} disabled>
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
</body></html>

<%@ include file="/WEB-INF/views/includes/footer.jsp" %>
