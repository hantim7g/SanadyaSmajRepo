<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>

<!DOCTYPE html>
<html lang="hi">
<head>
  <meta charset="UTF-8">
  <title>विवाह पंजीकरण फॉर्म</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background: #fefefe;
    }
    .card {
      box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
      padding: 10px;
    }
    .section-title {
      background-color: #ffc107;
      padding: 8px 12px;
      font-weight: bold;
    }
    .profile-image-preview {
      /* width: 150px;
      height: 150px; */
      object-fit: cover;
      /* border-radius: 50%; */
      border: 2px solid #000000;
    }
    
  </style>
</head>
<body>

<div class="container mt-4 mb-5">
  <div class="card p-4">
    <h3 class="text-center text-primary">विवाह योग्य युवक / युवती पंजीकरण फॉर्म</h3>

    <c:if test="${not empty success}">
      <div class="alert alert-success text-center">आपकी जानकारी सफलतापूर्वक सहेज ली गई है।</div>
    </c:if>

    <form action="/vivhauser/save" method="post" enctype="multipart/form-data">
      <input type="hidden" name="id" value="${vivhauser.id}" />

      <div class="row mt-3">
        <!-- Left: Profile Image -->
        <div class="col-md-4 text-center">
          <img id="previewImage"
               src="${vivhauser.profileImagePath != null ? vivhauser.profileImagePath : '/images/default.png'}"
               class="profile-image-preview img-fluid mb-2"
               alt="User Photo" />
          <input type="file" name="image" id="imageInput" class="form-control mt-2" accept="image/*">
        </div>

        <!-- Right: Form Fields -->
        <div class="col-md-8">
          <div class="section-title">व्यक्तिगत जानकारी</div>
          <div class="row g-3">
            <div class="col-md-6">
              <label>पूरा नाम</label>
              <input type="text" name="name" value="${vivhauser.name}" class="form-control" required />
            </div>
            <div class="col-md-6">
              <label>लिंग</label>
              <select name="gender" class="form-select">
                <option value="पुरुष" ${vivhauser.gender == 'पुरुष' ? 'selected' : ''}>पुरुष</option>
                <option value="महिला" ${vivhauser.gender == 'महिला' ? 'selected' : ''}>महिला</option>
              </select>
            </div>
            <div class="col-md-6">
              <label>जन्म तिथि</label>
              <input type="date" name="dob" value="${vivhauser.dob}" class="form-control" />
            </div>
            <div class="col-md-6">
              <label>जन्म समय</label>
              <input type="text" name="birthTime" value="${vivhauser.birthTime}" class="form-control" />
            </div>
            <div class="col-md-6">
              <label>मोबाइल</label>
              <input type="text" name="mobile" value="${vivhauser.mobile}" class="form-control" required />
            </div>
            <div class="col-md-6">
              <label>ईमेल</label>
              <input type="email" name="email" value="${vivhauser.email}" class="form-control" />
            </div>
          </div>

          <div class="section-title mt-4">शैक्षणिक व व्यवसाय</div>
          <div class="row g-3">
            <div class="col-md-6">
              <label>शैक्षणिक योग्यता</label>
              <input type="text" name="qualification" value="${vivhauser.qualification}" class="form-control" />
            </div>
            <div class="col-md-6">
              <label>पेशा</label>
              <input type="text" name="occupation" value="${vivhauser.occupation}" class="form-control" />
            </div>
            <div class="col-md-6">
              <label>आय (वार्षिक)</label>
              <input type="text" name="income" value="${vivhauser.income}" class="form-control" />
            </div>
          </div>

          <div class="section-title mt-4">पारिवारिक जानकारी</div>
          <div class="row g-3">
            <div class="col-md-6">
              <label>पिता का नाम</label>
              <input type="text" name="fatherName" value="${vivhauser.fatherName}" class="form-control" />
            </div>
            <div class="col-md-6">
              <label>पिता का व्यवसाय</label>
              <input type="text" name="fatherOccupation" value="${vivhauser.fatherOccupation}" class="form-control" />
            </div>
            <div class="col-md-6">
              <label>पिता की आय</label>
              <input type="text" name="fatherIncome" value="${vivhauser.fatherIncome}" class="form-control" />
            </div>
            <div class="col-md-6">
              <label>स्थायी पता</label>
              <textarea name="permanentAddress" class="form-control">${vivhauser.permanentAddress}</textarea>
            </div>
            <div class="col-md-6">
              <label>गोत्र</label>
              <input type="text" name="gotra" value="${vivhauser.gotra}" class="form-control" />
            </div>
          </div>

          <div class="text-end mt-4">
           <button type="submit" class="btn btn-success">
    ${vivhauser.id == null ? 'फॉर्म सबमिट करें' : 'अपडेट करें'}
  </button>

  <!-- ✅ PDF डाउनलोड बटन (सिर्फ जब ID मौजूद हो) -->
  <c:if test="${not empty vivhauser.id}">
    <button type="button" class="btn btn-outline-danger ms-2" onclick="downloadPdf(${vivhauser.id})">
      📥 PDF डाउनलोड करें
    </button>
  </c:if>
          </div>
        </div>
      </div>
    </form>
  </div>
</div>

<script>
  // ✅ Image preview
  document.getElementById("imageInput").addEventListener("change", function(e) {
    const reader = new FileReader();
    reader.onload = function(event) {
      document.getElementById("previewImage").src = event.target.result;
    }
    if (e.target.files.length > 0) {
      reader.readAsDataURL(e.target.files[0]);
    }
  });

  // ✅ PDF डाउनलोड function
  function downloadPdf(id) {
    window.open('/vivhauser/pdf/' + id, '_blank');
  }
</script>

</body>
</html>
