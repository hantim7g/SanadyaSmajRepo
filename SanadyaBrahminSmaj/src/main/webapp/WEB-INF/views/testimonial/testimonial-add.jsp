<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="hi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>नया प्रशंसापत्र</title>

  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+Devanagari:wght@300;400;600;700&display=swap" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" rel="stylesheet">
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

  <style>
    body { background:#fffaf0; font-family:'Noto Sans Devanagari', system-ui, Segoe UI, Arial, sans-serif; }
    .page-title { font-weight:700; color:#8a4b08; }
  </style>
</head>
<body>

<div class="container py-4">
  <div class="d-flex justify-content-between align-items-center mb-3">
    <h1 class="page-title h4 mb-0"><i class="fas fa-pen me-2"></i> नया प्रशंसापत्र</h1>
    <a class="btn btn-outline-secondary btn-sm" href="/testimonial/my-testimonials">मेरी सूची</a>
  </div>

  <div class="card">
    <div class="card-body">
      <form method="post" action="/testimonial/save" accept-charset="UTF-8">
        <input type="hidden" name="id" value=""/>
        <input type="hidden" name="userId" value="${currentUser.id}"/>
        <c:if test="${not empty _csrf}">
          <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        </c:if>

        <div class="mb-3">
          <label class="form-label" for="message">संदेश</label>
          <textarea id="message" name="message" class="form-control" rows="6" maxlength="1000" required
                    placeholder="अपना अनुभव / संदेश लिखें..."></textarea>
          <div class="form-text">अधिकतम 1000 अक्षर</div>
        </div>

        <div class="mb-3">
          <label class="form-label" for="designation">पद/परिचय</label>
          <input type="text" id="designation" name="designation" class="form-control" maxlength="100"
                 placeholder="उदा: छात्र, सॉफ़्टवेयर इंजीनियर, उद्यमी">
        </div>

        <div class="d-flex gap-2">
          <button type="submit" class="btn btn-success">
            <i class="fas fa-save me-1"></i> सेव
          </button>
          <a href="/testimonials" class="btn btn-outline-primary">सार्वजनिक सूची</a>
        </div>
      </form>
    </div>
  </div>
</div>

<script>
  // सरल क्लाइंट वैलिडेशन
  $(function(){
    $('form').on('submit', function(e){
      const msg = $('#message').val().trim();
      if(!msg){
        e.preventDefault();
        alert('कृपया संदेश लिखें।');
        return false;
      }
      if(msg.length > 1000){
        e.preventDefault();
        alert('संदेश 1000 अक्षरों से अधिक नहीं हो सकता।');
        return false;
      }
    });
  });
</script>

</body>
</html> 			<%@ include file="/WEB-INF/views/includes/footer.jsp" %>
