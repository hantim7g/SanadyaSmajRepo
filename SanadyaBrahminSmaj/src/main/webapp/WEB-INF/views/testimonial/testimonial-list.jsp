<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="hi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>सदस्यों के प्रशंसापत्र</title>

  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+Devanagari:wght@300;400;600;700&display=swap" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.datatables.net/1.13.8/css/dataTables.bootstrap5.min.css">

  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://cdn.datatables.net/1.13.8/js/jquery.dataTables.min.js"></script>
  <script src="https://cdn.datatables.net/1.13.8/js/dataTables.bootstrap5.min.js"></script>

  <style>
    body { background:#fffaf0; font-family: 'Noto Sans Devanagari', system-ui, Segoe UI, Arial, sans-serif; }
    .page-title { font-weight:700; color:#8a4b08; }
    .card-testimonial { border:none; box-shadow:0 2px 10px rgba(0,0,0,0.08); height:100%; }
    .card-testimonial .message { white-space:normal; word-break:break-word; }
    .avatar {
      width:44px; height:44px; border-radius:50%; background:#f1e1cd;
      display:flex; align-items:center; justify-content:center; font-weight:700; color:#8a4b08;
    }
  </style>
</head>
<body>

<div class="container py-4">
  <div class="d-flex justify-content-between align-items-center mb-3">
    <h1 class="page-title h3 mb-0"><i class="fas fa-book-open me-2"></i> सदस्यों के प्रशंसापत्र</h1>
    <div>
      <a class="btn btn-primary btn-sm" href="/member/add-testimonial">
        <i class="fas fa-pen me-1"></i> अपना प्रशंसापत्र जोड़ें
      </a>
    </div>
  </div>

  <div class="card mb-3">
    <div class="card-body">
      <div class="table-responsive">
        <table id="publicTestimonials" class="table table-striped table-bordered align-middle">
          <thead class="table-light">
            <tr>
              <th style="width:60px;">क्रम</th>
              <th>सदस्य</th>
              <th>संदेश</th>
              <th style="width:160px;">तिथि</th>
            </tr>
          </thead>
          <tbody>
          <c:forEach var="t" items="${testimonials}">
            <!-- मान लेते हैं कि कंट्रोलर पहले से केवल active=true और status=स्वीकृत डेटा भेजता है -->
            <tr>
              <td>${t.displayOrder}</td>
              <td>
                <div class="d-flex align-items-center gap-2">
                  <div class="avatar">${fn:substring(fn:escapeXml(t.user.fullName),0,1)}</div>
                  <div>
                    <div class="fw-semibold">${fn:escapeXml(t.user.fullName)}</div>
                    <div class="text-muted small">${fn:escapeXml(t.designation)}</div>
                  </div>
                </div>
              </td>
              <td class="message">${fn:escapeXml(t.message)}</td>
              <td class="text-muted small">
                <div>बनाया: ${t.formattedCreatedDate}</div>
                <c:if test="${not empty t.formattedApprovedDate}">
                  <div>स्वीकृत: ${t.formattedApprovedDate}</div>
                </c:if>
              </td>
            </tr>
          </c:forEach>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>

<!-- Font Awesome (optional; if already globally loaded, remove) -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" rel="stylesheet">

<script>
  $(function(){
    $('#publicTestimonials').DataTable({
      pageLength: 10,
      order: [[0, 'asc']], // displayOrder
      language: {
        search: 'खोज:',
        lengthMenu: 'प्रति पृष्ठ _MENU_',
        info: 'कुल _TOTAL_ में से _START_ - _END_',
        paginate: { previous: 'पिछला', next: 'अगला' },
        zeroRecords: 'कोई रिकॉर्ड नहीं मिला'
      },
      columnDefs: [
        { targets: [2], orderable: false } // संदेश कॉलम पर sort न करें
      ]
    });
  });
</script>

</body>
</html> 			<%@ include file="/WEB-INF/views/includes/footer.jsp" %>
