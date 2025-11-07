<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="hi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>मेरे प्रशंसापत्र</title>

  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+Devanagari:wght@300;400;600;700&display=swap" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" rel="stylesheet">

  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

  <style>
    body { background:#fffaf0; font-family: 'Noto Sans Devanagari', system-ui, Segoe UI, Arial, sans-serif; }
    .page-title { font-weight:700; color:#8a4b08; }
    .card { border:none; box-shadow:0 2px 10px rgba(0,0,0,0.07); }
    .status-badge { font-size: 0.8rem; }
    .status-processing { background:#fff3cd; color:#7a5b00; }
    .status-approved { background:#d1e7dd; color:#0f5132; }
    .status-rejected { background:#f8d7da; color:#842029; }
    .message { white-space:normal; word-break:break-word; }
  </style>
</head>
<body>

<div class="container py-4">

  <div class="d-flex justify-content-between align-items-center mb-3">
    <h1 class="page-title h3 mb-0"><i class="fas fa-list-ul me-2"></i> मेरे प्रशंसापत्र</h1>
    <div class="d-flex gap-2">
      <a class="btn btn-primary btn-sm" href="/member/add-testimonial">
        <i class="fas fa-plus me-1"></i> नया जोड़ें
      </a>
      <a class="btn btn-outline-secondary btn-sm" href="/testimonials">
        <i class="fas fa-book-open me-1"></i> सार्वजनिक सूची देखें
      </a>
    </div>
  </div>

  <c:choose>
    <c:when test="${empty testimonials}">
      <div class="alert alert-info">अभी तक कोई प्रशंसापत्र नहीं जोड़ा गया है। “नया जोड़ें” पर क्लिक करें।</div>
    </c:when>
    <c:otherwise>
      <div class="row g-3">
        <c:forEach var="t" items="${testimonials}">
          <div class="col-12">
            <div class="card">
              <div class="card-body">
                <div class="d-flex justify-content-between align-items-start">
                  <div>
                    <div class="message">${fn:escapeXml(t.message)}</div>
                    <div class="text-muted small mt-2">
                      <span>बनाया: ${t.formattedCreatedDate}</span>
                      <c:if test="${not empty t.formattedUpdatedDate}"> | <span>अद्यतन: ${t.formattedUpdatedDate}</span></c:if>
                    </div>
                  </div>
                  <div class="text-end">
                    <c:set var="status" value="${t.status}"/>
                    <div class="mb-2">
                      <span class="badge status-badge
                        ${status=='प्रक्रिया में' ? 'status-processing' : (status=='स्वीकृत' ? 'status-approved' : 'status-rejected')}">
                        ${status}
                      </span>
                      <span class="badge ${t.active ? 'bg-success' : 'bg-secondary'} ms-1">${t.active ? 'सक्रिय' : 'निष्क्रिय'}</span>
                    </div>
                    <div class="btn-group">
                      <c:if test="${t.canBeEditedBy(currentUser)}">
                        <a class="btn btn-sm btn-primary" href="/testimonial/manage?editId=${t.id}">
                          <i class="fas fa-pen me-1"></i> संपादित करें
                        </a>
                      </c:if>
                      <c:if test="${!t.canBeEditedBy(currentUser)}">
                        <button class="btn btn-sm btn-outline-secondary" disabled title="इस स्थिति में संपादन संभव नहीं">लॉक</button>
                      </c:if>
                    </div>
                  </div>
                </div>
                <c:if test="${status=='अस्वीकृत' && not empty t.formattedApprovedDate}">
                  <div class="small text-danger mt-2">अस्वीकृति तिथि: ${t.formattedApprovedDate}</div>
                </c:if>
              </div>
            </div>
          </div>
        </c:forEach>
      </div>
    </c:otherwise>
  </c:choose>

</div>

</body>
</html>
