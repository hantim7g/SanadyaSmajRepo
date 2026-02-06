<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="hi">
<head>
<title>रूम प्रबंधन - एडमिन पैनल</title>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">

<style>
  body { background: #fffaf4; font-family: 'Segoe UI','Noto Sans Devanagari',sans-serif; }
  .main-width { max-width:1200px; margin:auto; }
  .room-card {
    background: linear-gradient(93deg,#ffedc2 65%,#fca854 100%);
    border-radius:18px; padding:18px 25px; margin-bottom:20px;
    border: 1px solid rgba(0,0,0,0.05); transition: 0.3s;
  }
  .room-card:hover { box-shadow: 0 5px 15px rgba(0,0,0,0.1); }
  .room-title { font-size:1.3rem; font-weight:800; color:#5e3400; }
  
  /* Management Table Styling */
  .block-table { background: #fff; border-radius: 15px; overflow: hidden; box-shadow: 0 4px 12px rgba(0,0,0,0.05); }
  .block-table thead { background: #5e3400; color: #fff; }

  /* Modal Styling */
  #blockRoomModal .form-control, #blockRoomModal .form-select {
    border-radius: 10px; padding: 10px; border: 1px solid #ddd;
  }
  #blockRoomModal .form-control:focus {
    border-color: #fca854; box-shadow: 0 0 0 0.25rem rgba(252, 168, 84, 0.25);
  }
</style>
</head>

<body>
<div class="container main-width my-4">

    <form method="get" action="/rooms/admin" class="room-card mb-4 shadow-sm border-0">
        <div class="row g-3">
            <div class="col-12 border-bottom pb-2">
                <h6 class="text-secondary fw-bold mb-0"><i class="bi bi-funnel-fill me-2"></i>उन्नत खोज फ़िल्टर</h6>
            </div>
            <div class="col-md-3">
                <label class="small fw-bold">चेक-इन तिथि</label>
                <input type="date" name="fromDate" class="form-control form-control-sm" value="${param.fromDate}">
            </div>
            <div class="col-md-3">
                <label class="small fw-bold">चेक-आउट तिथि</label>
                <input type="date" name="toDate" class="form-control form-control-sm" value="${param.toDate}">
            </div>
            <div class="col-md-2">
                <label class="small fw-bold">प्रकार</label>
                <select name="roomType" class="form-select form-select-sm">
                    <option value="">सभी</option>
                    <option value="ONLY_ROOM" ${param.roomType == 'ONLY_ROOM' ? 'selected' : ''}>केवल कमरा</option>
                    <option value="HALL" ${param.roomType == 'HALL' ? 'selected' : ''}>हॉल</option>
                    <option value="COMPLETE_FLOOR" ${param.roomType == 'COMPLETE_FLOOR' ? 'selected' : ''}>पूरा फ्लोर</option>
                    <option value="COMPLETE_BUILDING" ${param.roomType == 'COMPLETE_BUILDING' ? 'selected' : ''}>सामुदायिक भवन</option>
                </select>
            </div>
            <div class="col-md-2">
                <label class="small fw-bold">फ्लोर</label>
                <select name="floor" class="form-select form-select-sm">
                    <option value="">सभी</option>
                    <option value="ग्राउंड फ्लोर" ${param.floor == 'ग्राउंड फ्लोर' ? 'selected' : ''}>ग्राउंड फ्लोर</option>
                    <option value="पहला फ्लोर" ${param.floor == 'पहला फ्लोर' ? 'selected' : ''}>पहला फ्लोर</option>
                    <option value="दूसरा फ्लोर" ${param.floor == 'दूसरा फ्लोर' ? 'selected' : ''}>दूसरा फ्लोर</option>
                </select>
            </div>
            <div class="col-md-2">
                <label class="small fw-bold">सक्रिय</label>
                <select name="isActive" class="form-select form-select-sm">
                    <option value="">सभी</option>
                    <option value="true" ${param.isActive == 'true' ? 'selected' : ''}>हाँ</option>
                    <option value="false" ${param.isActive == 'false' ? 'selected' : ''}>नहीं</option>
                </select>
            </div>
            <div class="col-md-12 text-end">
                <button type="submit" class="btn btn-primary btn-sm px-4">फ़िल्टर लागू करें</button>
                <a href="/rooms/admin" class="btn btn-outline-secondary btn-sm px-4">रीसेट</a>
                <a href="/rooms/admin/add" class="btn btn-dark btn-sm px-4">➕ नया रूम</a>
            </div>
        </div>
    </form>

    <div class="row">
        <div class="col-lg-8">
            <h4 class="mb-3">🏨 रूम सूची</h4>
            <c:forEach items="${rooms}" var="entry">
                <c:set var="r" value="${entry.key}" />
                <c:set var="avail" value="${entry.value}" />

                <div class="room-card mb-3" style="border-left: 10px solid 
                    ${avail == 'BOOKED' ? '#dc3545' : (avail == 'BLOCKED' ? '#ffc107' : '#28a745')};">
                    
                    <div class="d-flex justify-content-between">
                        <div>
                            <h5 class="room-title mb-1">${r.roomNumber} - ${r.roomTypeLabel}</h5>
                            <span class="text-muted small">फ्लोर: ${r.floorLabel} | ₹${r.basePrice}</span>
                        </div>
                        <div class="text-end">
                            <c:choose>
                                <c:when test="${avail == 'BOOKED'}">
                                    <span class="badge bg-danger"><i class="bi bi-person-fill"></i> बुक है</span>
                                </c:when>
                                <c:when test="${avail == 'BLOCKED'}">
                                    <span class="badge bg-warning text-dark"><i class="bi bi-cone-striped"></i> ब्लॉक</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-success"><i class="bi bi-check-circle"></i> उपलब्ध</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <div class="mt-3 text-end">
                        <a href="/rooms/admin/edit/${r.id}" class="btn btn-sm btn-outline-dark">संपादित करें</a>
                        <c:if test="${avail == 'AVAILABLE'}">
                            <button class="btn btn-sm btn-warning" onclick="openBlockModal('${r.id}', '${r.roomNumber}')">🚫 ब्लॉक</button>
                        </c:if>
                    </div>
                </div>
            </c:forEach>
        </div>

        <div class="col-lg-4">
            <h4 class="mb-3">🔒 सक्रिय ब्लॉक्स</h4>
            <div class="block-table p-3">
                <c:if test="${empty activeBlocks}">
                    <p class="text-center text-muted py-4">कोई सक्रिय ब्लॉक नहीं है</p>
                </c:if>
                <c:forEach items="${activeBlocks}" var="block">
                    <div class="border-bottom pb-2 mb-2">
                        <div class="d-flex justify-content-between align-items-center">
                            <strong>${block.room.roomNumber}</strong>
                            <button class="btn btn-link text-danger p-0" onclick="unblockRoom(${block.id})">
                                <i class="bi bi-unlock-fill"></i> अनब्लॉक
                            </button>
                        </div>
                        <div class="small text-muted">
                            ${block.fromDate} से ${block.toDate}<br>
                            <span class="badge bg-light text-dark border">${block.reason}</span>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="blockRoomModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content border-0 shadow-lg" style="border-radius: 20px;">
      <div class="modal-header" style="background: #e67e22; color: white; border-radius: 20px 20px 0 0;">
        <h5 class="modal-title"><i class="bi bi-lock-fill me-2"></i>ब्लॉक रूम: <span id="displayRoomNumber"></span></h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
      </div>
      <form id="blockRoomForm">
        <div class="modal-body p-4">
          <input type="hidden" id="blockRoomId" name="roomId">
          <div class="row g-3">
            <div class="col-6">
              <label class="small fw-bold">चेक-इन</label>
              <input type="date" id="blockFromDate" name="fromDate" class="form-control" required>
            </div>
            <div class="col-6">
              <label class="small fw-bold">चेक-आउट</label>
              <input type="date" id="blockToDate" name="toDate" class="form-control" required>
            </div>
            <div class="col-12">
              <label class="small fw-bold">कारण</label>
              <select name="reason" class="form-select" required>
                <option value="MAINTENANCE">🛠️ मरम्मत (Maintenance)</option>
                <option value="VIP">🌟 VIP गेस्ट</option>
                <option value="CLEANING">🧹 गहरी सफाई</option>
                <option value="OTHER">❓ अन्य</option>
              </select>
            </div>
          </div>
        </div>
        <div class="modal-footer border-0 pb-4">
          <button type="button" class="btn btn-light rounded-pill" data-bs-dismiss="modal">रद्द करें</button>
          <button type="submit" id="submitBlockBtn" class="btn btn-danger rounded-pill px-4">ब्लॉक की पुष्टि करें</button>
        </div>
      </form>
    </div>
  </div>
</div>

<script>
let blockModal = null;

function openBlockModal(id, roomNumber) {
    document.getElementById('blockRoomForm').reset();
    document.getElementById('blockRoomId').value = id;
    document.getElementById('displayRoomNumber').innerText = roomNumber;
    const today = new Date().toISOString().split('T')[0];
    document.getElementById('blockFromDate').min = today;
    document.getElementById('blockToDate').min = today;
    if (!blockModal) { blockModal = new bootstrap.Modal(document.getElementById('blockRoomModal')); }
    blockModal.show();
}

// UNBLOCK logic
function unblockRoom(blockId) {
    Swal.fire({
        title: 'क्या आप सुनिश्चित हैं?',
        text: "यह रूम फिर से बुकिंग के लिए उपलब्ध हो जाएगा।",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#28a745',
        cancelButtonColor: '#d33',
        confirmButtonText: 'हाँ, अनब्लॉक करें!',
        cancelButtonText: 'रद्द करें'
    }).then((result) => {
        if (result.isConfirmed) {
            fetch('/rooms/admin/unblock/' + blockId, { method: 'DELETE' })
            .then(res => res.json())
            .then(data => {
                if(data.success) {
                    Swal.fire('अनब्लॉक!', 'रूम अब उपलब्ध है।', 'success').then(() => location.reload());
                } else {
                    Swal.fire('त्रुटि!', data.message, 'error');
                }
            });
        }
    });
}

document.getElementById('blockRoomForm').addEventListener('submit', function(e) {
    e.preventDefault();
    const btn = document.getElementById('submitBlockBtn');
    btn.disabled = true;
    const data = Object.fromEntries(new FormData(this).entries());
    fetch('/rooms/admin/block', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data)
    })
    .then(res => res.json())
    .then(res => {
        if(res.success) {
            Swal.fire('सफलता!', 'रूम ब्लॉक हो गया', 'success').then(() => location.reload());
        } else {
            Swal.fire('त्रुटि!', res.message, 'error');
            btn.disabled = false;
        }
    });
});
</script>
</body>
</html>
<%@ include file="/WEB-INF/views/includes/footer.jsp" %>