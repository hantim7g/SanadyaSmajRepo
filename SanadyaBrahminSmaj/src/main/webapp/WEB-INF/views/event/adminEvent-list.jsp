<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Events List</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
</head>
<body>
<div class="container mt-4">
  <h2>All Events</h2>
  <a class="btn btn-success mb-3" href="/admin/event-form">Create New Event</a>

  <c:forEach var="ev" items="${events}">
    <div class="card mb-3">
      <div class="row g-0">
        <div class="col-md-3">
          <c:if test="${not empty ev.mainImageUrl}">
            <img src="${ev.mainImageUrl}" class="img-fluid rounded-start" alt="Main Image"/>
          </c:if>
        </div>
        <div class="col-md-9">
          <div class="card-body">
            <h5 class="card-title">${ev.title}</h5>
            <p class="card-text">${ev.content}</p>
            <small class="text-muted">Author: ${ev.author} | EventDate: ${ev.eventDate}</small>
            <br/>
            <a href="/admin/event-form?id=${ev.id}" class="btn btn-sm btn-primary mt-2">Edit</a>
          </div>
        </div>
      </div>
    </div>
  </c:forEach>
</div>
</body>
</html> 			<%@ include file="/WEB-INF/views/includes/footer.jsp" %>
