<%@ include file="/WEB-INF/views/includes/header.jsp" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="hi">
<head>
  <meta charset="UTF-8">
  <title>यूज़र कार्ड सूची</title>

  <!-- Bootstrap & jQuery
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script> -->

  <!-- Custom Styles -->
  <style>
    .profile-card {
            background: linear-gradient(to left, #ffa347, #fca854);

      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
      border-radius: 12px;
      margin-bottom: 20px;
      padding: 15px;
      transition: transform 0.2s ease-in-out;
    }

    .profile-card:hover {
      transform: translateY(-2px);
      box-shadow: 0 8px 16px rgba(0, 0, 0, 0.08);
    }

    .btnn{
      
      background-color: #0b9e00;
      color: white;
      font-size: 1rem;
      border-radius: 8px;
      /* padding: 10px 15px; */
      font-weight: boldder;
      transition: background-color 0.3s ease;
    }
    .profile-img {

      width: 250px;
      height: 250px;
      max-height: 250px;    
      align-items: center;
      object-fit: cover;
      border-radius: 8px;
    }

.filedt{
       color: rgb(8, 6, 6);
      font-weight: 500;
      font-size: 1.2rem;  
      /* margin-bottom: 10px;   */
      text-align: left;
      /* padding: 5px 0; */
      /* border-bottom: 1px solid rgb(255, 255, 255);  */
}

    .name-banner {
      /* padding: 12px;
      border-radius: 8px; */
      font-size: 2.0rem;
      font-weight: 700;
      color: rgb(0, 0, 0);
      text-align: left;
      margin-bottom: 15px;
       margin-left: 15px;
            border-bottom: 1px solid black; 

      /* box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1); */
    }
  </style>
</head>

<body>
  <div class="container my-4">
    <h2 class="mb-4 text-center">यूज़र प्रोफाइल कार्ड</h2>

    <!-- 🔍 Filter Form -->
<!-- Replace Filter Form in memberListAdmin.jsp -->
<form id="filterForm" class="mb-4">
  <div class="row g-2">
    <div class="col-md-3">
      <input type="text" class="form-control" name="name" placeholder="नाम से खोजें">
    </div>
    <div class="col-md-3">
      <input type="text" class="form-control" name="city" placeholder="शहर">
    </div>
    <div class="col-md-2">
      <select name="approved" class="form-select">
        <option value="">स्थिति</option>
        <option value="true">स्वीकृत</option>
        <option value="false">लंबित</option>
      </select>
    </div>
    <div class="col-md-2">
      <select name="due" class="form-select">
        <option value="">शुल्क स्थिति</option>
        <option value="true">बकाया</option>
        <option value="false">कोई बकाया नहीं</option>
      </select>
    </div>
   
    <div class="col-md-1 d-grid">
      <button type="submit" class="btn btn-primary">🔍 खोजें</button>
    </div>
  </div>
 <div class="col-md-1">प्रति पृष्ठ:
      <select name="size" class="form-select">
         <option value="1">1</option>
          <option value="2">2</option>
        <option value="5">5</option>
        <option value="10" selected>10</option>
        <option value="20">20</option>
      </select>
    </div>
</form>

    <!-- 🧾 User Card List -->
    <div id="userCardListContainer">
      <c:forEach var="user" items="${userList}">
        <div class="card profile-card border-0 shadow-sm hover-shadow mb-4">
                        <div class="name-banner">${user.fullName}</div>

          <div class="row g-3">
            <!-- Profile Image -->
            <div class="col-md-3  d-flex align-items-center justify-content-center">
              <div class="w-100 text-center">
                <img src="${user.profileImagePath != null ? user.profileImagePath : '/images/default.png'}"
                     class="img-fluid profile-img border border-2 border-light rounded-3 shadow-sm"
                     alt="Photo" >
              </div>
            </div>

            <!-- Profile Info -->
            <div class="col-md-9">

              <div class="card-body py-2">

                <div class="row mb-2">
                  <div class="col-md-6 filedt">
                    <strong>पंजीयन क्रमांक:</strong> 
                    <span class="badge  text-dark">${user.registrationNo}</span>
                  </div>
                  <div class="col-md-6 filedt">
                    <strong>पिता का नाम:</strong> ${user.fatherName}
                  </div>
                </div>

                <div class="row mb-2">
                  <div class="col-md-6 filedt"><strong>गोत्र:</strong> ${user.gotra}</div>
                  <div class="col-md-6 filedt"><strong>पेशा:</strong> ${user.occupation}</div>
                </div>

                <div class="row mb-2">
                  <div class="col-md-6 filedt">
                    <strong>पता:</strong> ${user.address}, ${user.homeDistrict}
                  </div>
                  <div class="col-md-6 filedt">
                    <strong>मोबाइल:</strong> <a href="tel:${user.mobile}" class="text-decoration-none">${user.mobile}</a>
                  </div>
                </div>

                <div class="row mb-2">
                  <div class="col-md-6 filedt">
                    <strong>ईमेल:</strong> <a href="mailto:${user.email}" class="text-decoration-none">${user.email}</a>
                  </div>
                  <div class="col-md-6 filedt">
                    <strong>शर्तें स्वीकार:</strong> 
                    <span class="badge bg-${user.agreeToTerms ? 'success' : 'danger'}">
                      ${user.agreeToTerms ? "हाँ" : "नहीं"}
                    </span>
                  </div>
                </div>

                <div class="row mb-2">
                  <div class="col-md-6 filedt">
                    <strong>अंतिम वार्षिक भुगतान:</strong>
                    <c:choose>
                      <c:when test="${user.lastAnnualFeePaid != null}">
                        ₹${user.lastAnnualFeeAmount} — <span class="text-muted">${user.lastAnnualFeePaid}</span>
                      </c:when>
                      <c:otherwise><span class="text-muted">--</span></c:otherwise>
                    </c:choose>
                  </div>
                  <div class="col-md-6 filedt">
                    <strong>देय शुल्क:</strong> 
                    <span class="text-danger fw-bold">₹ ${user.annualFeeDue}</span>
                  </div>
                </div>

                <div class="row mb-2 align-items-center">
                  <div class="col-md-6 filedt">
                    <strong>स्थिति:</strong>
                    <span class="badge ${user.approved ? 'bg-success' : 'bg-warning text-dark'}">
                      ${user.approved ? "स्वीकृत" : "स्वीकृति लंबित"}
                    </span>
                  </div>

                  <c:if test="${!user.approved || !user.annualFeeValidated || !user.otherFeeValidated}">
  <div class="row mt-2">
    <div class="col-md-12 d-flex justify-content-start gap-2 flex-wrap">
      <c:if test="${!user.annualFeeValidated}">
        <button class="btn btnn btn-outline-success validate-annual-btn" data-user-id="${user.id}">
          ✔️ वार्षिक शुल्क सत्यापित करें
        </button>
      </c:if>
      <c:if test="${!user.otherFeeValidated}">
        <button class="btn btnn btn-outline-info btn-sm validate-other-btn" data-user-id="${user.id}">
          💼 अन्य शुल्क सत्यापित करें
        </button>
      </c:if>
      <c:if test="${!user.approved}">
        <button class="btn btnn btn-outline-primary btn-sm validate-profile-btn" data-user-id="${user.id}">
          🧾 प्रोफाइल सत्यापित करें
        </button>
      </c:if>
    </div>
  </div>
</c:if>

                </div>
              </div>
            </div>
          </div>
        </div>
      </c:forEach>
      <!-- 📄 Pagination Bar -->
<c:if test="${totalPages > 0}">
  <nav class="mt-4">
    <ul class="pagination justify-content-center">
      <li class="page-item ${currentPage == 0 ? 'disabled' : ''}">
        <a class="page-link page-link-btn" href="#" data-page="${currentPage - 1}">⏮ पिछला</a>
      </li>
      <c:forEach begin="0" end="${totalPages - 1}" var="i">
        <li class="page-item ${i == currentPage ? 'active' : ''}">
          <a class="page-link page-link-btn" href="#" data-page="${i}">${i + 1}</a>
        </li>
      </c:forEach>
      <li class="page-item ${currentPage == totalPages - 1 ? 'disabled' : ''}">
        <a class="page-link page-link-btn" href="#" data-page="${currentPage + 1}">अगला ⏭</a>
      </li>
    </ul>
  </nav>
</c:if>


    </div>
  </div>
<!-- 💰 Annual Payment Modal -->
<div class="modal fade" id="annualPaymentModal" tabindex="-1" aria-labelledby="annualPaymentModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-xl modal-dialog-scrollable">
    <div class="modal-content">
      <div class="modal-header bg-warning text-dark">
        <h5 class="modal-title" id="annualPaymentModalLabel">🧾 वार्षिक भुगतान विवरण</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body" id="annualPaymentModalBody">
        <div class="text-center text-muted">लोड हो रहा है...</div>
      </div>
    </div>
  </div>
</div>

  <!-- Script -->
<script>
  $(document).ready(function () {
    $('#filterForm').on('submit', function (e) {
      e.preventDefault();
      fetchFilteredUsers(0); // reset to first page on filter
    });

    // Validate Buttons
    $(document).on('click', '.validate-annual-btn', function () {
  const userId = $(this).data('user-id');

  // Show modal and loading message
  $('#annualPaymentModal').modal('show');
  $('#annualPaymentModalBody').html('<div class="text-center text-muted">लोड हो रहा है...</div>');

  // Load payment details via AJAX
  $.get('/admin/user/' + userId + '/annualPayments', function (html) {
    $('#annualPaymentModalBody').html(html);
  }).fail(function () {
    $('#annualPaymentModalBody').html('<div class="text-danger text-center">डेटा लोड करने में त्रुटि हुई।</div>');
  });
});

// Validate individual payment from modal
$(document).on('click', '.validate-payment-btn', function () {
  const paymentId = $(this).data('payment-id');
  const $btn = $(this);
  $btn.prop("disabled", true).text("⏳ सत्यापन...");

  $.post('/admin/validatePayment/' + paymentId, function () {
    alert('भुगतान सत्यापित हुआ');
    $btn.closest('tr').find('td:eq(5) span')
        .removeClass().addClass('badge bg-success').text('सत्यापित');
    $btn.remove(); // hide button after validation
  }).fail(function () {
    alert('सत्यापन में त्रुटि!');
    $btn.prop("disabled", false).text("✔️ सत्यापित करें");
  });
});

    $(document).on('click', '.validate-other-btn', function () {
      const userId = $(this).data('user-id');
      $.post('/admin/validateOtherFee/' + userId, function () {
        alert('अन्य शुल्क सत्यापित हुआ');
        fetchFilteredUsers();
      });
    });

    $(document).on('click', '.validate-profile-btn', function () {
      const userId = $(this).data('user-id');
      $.post('/admin/approveUser/' + userId, function () {
        alert('प्रोफाइल सत्यापित (स्वीकृत) हुआ');
        fetchFilteredUsers();
      });
    });

    // Pagination click (memberListAdmin.jsp)
    $(document).on('click', '.page-link-btn', function (e) {
      e.preventDefault();
      const page = $(this).data("page");
      fetchFilteredUsers(page);
    });
  });

  function fetchFilteredUsers(page = 0) {
    const formData = $("#filterForm").serialize();
    const size = $("select[name='size']").val() || 10;
    $.ajax({
      url: '/admin/users/filter?' + formData + '&page=' + page + '&size=' + size,
      type: 'GET',
      success: function (html) {
        $('#userCardListContainer').html(html);
      },
      error: function () {
        alert("डेटा लाने में त्रुटि!");
      }
    });
  }
</script>
</body>
</html>
