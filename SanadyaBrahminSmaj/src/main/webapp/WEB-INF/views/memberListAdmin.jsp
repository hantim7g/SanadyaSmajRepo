<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="hi">
<head>
  <meta charset="UTF-8">
  <title>यूज़र कार्ड सूची</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    .profile-card {
      box-shadow: 0 0 10px rgba(0,0,0,0.1);
      border-radius: 12px;
      margin-bottom: 20px;
      padding: 15px;
    }
    .profile-img {
      width: 100%;
      height: 200px;
      object-fit: cover;
      border-radius: 8px;
    }
    .name-banner {
      background: linear-gradient(to right, #f9d423, #ff4e50);
      padding: 12px;
      border-radius: 8px;
      font-size: 1.5rem;
      font-weight: 700;
      color: white;
      text-align: center;
      margin-bottom: 15px;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    }
    .approved-label {
      font-weight: bold;
      color: green;
    }
    .not-approved-label {
      font-weight: bold;
      color: red;
    }
  </style>
</head>
<body>
<div class="container my-4">
  <h2 class="mb-4 text-center">यूज़र प्रोफाइल कार्ड</h2>

  <!-- Filter Form -->
  <form id="filterForm" class="mb-3">
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
    <div class="col-md-2 d-grid">
      <button type="submit" class="btn btn-primary">🔍 खोजें</button>
    </div>
  </div>
</form>

  <!-- Card List Container -->
  <div id="userCardListContainer">
    <c:forEach var="user" items="${userList}">
      <div class="card profile-card">
              <div class="name-banner">${user.fullName}</div>
        <div class="row g-0">

            <div class="col-md-3">
            <img src="${user.profileImagePath != null ? user.profileImagePath : '/images/default.png'}" class="img-fluid profile-img" alt="Photo">
          </div>
          <div class="col-md-9">
            <div class="card-body">

              <div class="row mb-2">
                <div class="col-md-6"><strong>पंजीयन क्रमांक:</strong> ${user.registrationNo}</div>
                <div class="col-md-6"><strong>पिता का नाम:</strong> ${user.fatherName}</div>
              </div>
              <div class="row mb-2">
                <div class="col-md-6"><strong>गोत्र:</strong> ${user.gotra}</div>
                <div class="col-md-6"><strong>पेशा:</strong> ${user.occupation}</div>
              </div>
              <div class="row mb-2">
                <div class="col-md-6"><strong>पता:</strong> ${user.address}, ${user.homeDistrict}</div>
                <div class="col-md-6"><strong>मोबाइल:</strong> ${user.mobile}</div>
              </div>
              <div class="row mb-2">
                <div class="col-md-6"><strong>ईमेल:</strong> ${user.email}</div>
                <div class="col-md-6"><strong>शर्तें स्वीकार:</strong> ${user.agreeToTerms ? "हाँ" : "नहीं"}</div>
              </div>
              <div class="row mb-2">
                <div class="col-md-6">
                  <strong>अंतिम वार्षिक भुगतान:</strong>
                  <c:choose>
                    <c:when test="${user.lastAnnualFeePaid != null}">
                      ₹${user.lastAnnualFeeAmount} — ${user.lastAnnualFeePaid}
                    </c:when>
                    <c:otherwise>--</c:otherwise>
                  </c:choose>
                </div>
                <div class="col-md-6">
                  <strong>देय वार्षिक शुल्क:</strong>
                  <span class="text-danger">₹ ${user.annualFeeDue}</span>
                </div>
              </div>
              <div class="row mb-2">
                <div class="col-md-6">
                  <strong>स्थिति:</strong>
                  <span class="${user.approved ? 'approved-label' : 'not-approved-label'}">
                    ${user.approved ? "स्वीकृत" : "स्वीकृति लंबित"}
                  </span>
                </div>
                <c:if test="${!user.approved}">
                  <div class="col-md-6">
                    <button class="btn btn-sm btn-success approve-btn" data-user-id="${user.id}">स्वीकृत करें</button>
                  </div>
                </c:if>
              </div>
            </div>
          </div>
        </div>
      </div>
    </c:forEach>
  </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
  $(document).ready(function () {
    $('#filterForm').on('submit', function (e) {
      e.preventDefault(); // form reload को रोकें
      fetchFilteredUsers();
    });

    $(document).on('click', '.approve-btn', function () {
      const userId = $(this).data("user-id");
      $.post('/admin/approveUser/' + userId, function () {
        alert('स्वीकृत किया गया');
        fetchFilteredUsers(); // update view
      }).fail(function () {
        alert('त्रुटि!');
      });
    });
  });

  function fetchFilteredUsers() {
    const formData = $("#filterForm").serialize();

    $.ajax({
      url: '/admin/users/filter',
      type: 'GET',
      data: formData,
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
