<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>

<!DOCTYPE html>
<html>
<head>
  <title>प्रोफ़ाइल</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background: linear-gradient(to right, #f9f9f9, #e9f4ff);
      min-height: 100vh;
      margin: 0;
    }

    .container {
      padding-top: 80px;
    }

    .profile-card {
      background: #fff;
      border-radius: 10px;
      box-shadow: 0 0 30px rgba(0, 0, 0, 0.1);
      padding: 30px;
    }

    .label-col {
      font-weight: bold;
    }

    .readonly-input {
      background-color: #f9f9f9;
      border: none;
      font-weight: bold;
    }

    .editable-input {
      border: 1px solid #ccc;
      background-color: #fff;
    }

    .editable-input:focus {
      background-color: #fff;
      box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
    }

    #profilePic {
      width: 150px;
      height: 150px;
      object-fit: cover;
      border-radius: 50%;
      border: 3px solid #ccc;
    }

    .image-upload-wrapper {
      text-align: center;
    }
  </style>
</head>
<body>

<div class="container">
  <div class="profile-card">
    <h3 class="mb-4 text-center">🙍‍♂️ आपकी प्रोफ़ाइल जानकारी</h3>
    
    <!-- Grid Row for Left-Right Split -->
    <div class="row">
      
      <!-- 📸 Left Side: Image -->
      <div class="col-md-4 text-center mb-4 image-upload-wrapper">
        <img id="profilePic"
             src="${user.profileImagePath != null ? user.profileImagePath : '/logo/logo.png'}"
             alt="Profile Image">
        <div class="mt-2">
          <input type="file" id="profileImageInput" accept="image/*" class="form-control mt-2" style="max-width:300px;margin:auto;">
          <button id="uploadImageBtn" class="btn btn-sm btn-primary mt-2">📤 छवि अपडेट करें</button>
        </div>
      </div>

      <!-- 📝 Right Side: Form -->
      <div class="col-md-8">
        <form id="profileForm">
          <input type="hidden" name="id" value="${user.id}" />
          <div class="row g-3">
            <!-- Non-editable -->
            <div class="col-md-4"><label class="label-col">पूरा नाम</label>
              <input type="text" class="form-control readonly-input" value="${user.fullName}" readonly>
            </div>
            <div class="col-md-4"><label class="label-col">पिता का नाम</label>
              <input type="text" class="form-control readonly-input" value="${user.fatherName}" readonly>
            </div>
            <div class="col-md-4"><label class="label-col">मोबाइल</label>
              <input type="text" class="form-control readonly-input" value="${user.mobile}" readonly>
            </div>
            <div class="col-md-4"><label class="label-col">ईमेल</label>
              <input type="text" class="form-control readonly-input" value="${user.email}" readonly>
            </div>
            <div class="col-md-4"><label class="label-col">लिंग</label>
              <input type="text" class="form-control readonly-input" value="${user.gender}" readonly>
            </div>
            <div class="col-md-4"><label class="label-col">जन्म तिथि</label>
              <input type="date" class="form-control readonly-input" value="${user.dateOfBirth}" readonly>
            </div>

            <!-- Editable -->
            <div class="col-md-6"><label class="label-col">पता</label>
              <input name="address" type="text" class="form-control editable-input" value="${user.address}">
            </div>
            <div class="col-md-6"><label class="label-col">शैक्षणिक योग्यता</label>
              <input name="education" type="text" class="form-control editable-input" value="${user.education}">
            </div>
            <div class="col-md-6"><label class="label-col">पेशा</label>
              <input name="occupation" type="text" class="form-control editable-input" value="${user.occupation}">
            </div>
            <div class="col-md-6"><label class="label-col">ब्लड ग्रुप</label>
              <input name="bloodGroup" type="text" class="form-control editable-input" value="${user.bloodGroup}">
            </div>
            <div class="col-md-6"><label class="label-col">वैवाहिक स्थिति</label>
              <select name="maritalStatus" class="form-select editable-input">
                <option value="">चुनें</option>
                <option ${user.maritalStatus == 'अविवाहित' ? 'selected' : ''}>अविवाहित</option>
                <option ${user.maritalStatus == 'विवाहित' ? 'selected' : ''}>विवाहित</option>
                <option ${user.maritalStatus == 'अन्य' ? 'selected' : ''}>अन्य</option>
              </select>
            </div>

            <div class="col-12 text-end mt-3">
              <button type="submit" class="btn btn-success">💾 सहेजें</button>
            </div>
          </div>
        </form>
        <div id="updateMsg" class="mt-3 text-center text-success fw-bold"></div>
      </div>

    </div>
  </div>
</div>

<!-- Scripts -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
  // ✅ Profile Save
let latestImagePath = null; // Store the latest uploaded image path globally

// ✅ Submit Profile Data
$('#profileForm').submit(function (e) {
  e.preventDefault();
  const formData = {};
  $('#profileForm').serializeArray().forEach(field => {
    formData[field.name] = field.value;
  });

  if (latestImagePath) {
    formData["profileImagePath"] = latestImagePath; // Include updated path
  }

  $.ajax({
    url: '/api/user/update',
    type: 'POST',
    contentType: 'application/json',
    data: JSON.stringify(formData),
    headers: {
      Authorization: 'Bearer ' + localStorage.getItem("authToken")
    },
    success: function () {
      $('#updateMsg').text("प्रोफ़ाइल सफलतापूर्वक अपडेट हो गई।").removeClass("text-danger").addClass("text-success");
    },
    error: function () {
      $('#updateMsg').text("अपडेट करने में त्रुटि हुई।").removeClass("text-success").addClass("text-danger");
    }
  });
});

// ✅ Image Preview before upload
$('#profileImageInput').change(function () {
  const reader = new FileReader();
  reader.onload = function (e) {
    $('#profilePic').attr('src', e.target.result);
  }
  if (this.files && this.files[0]) {
    reader.readAsDataURL(this.files[0]);
  }
});

// ✅ Image Upload + trigger user update
$('#uploadImageBtn').click(function () {
  const fileInput = $('#profileImageInput')[0];
  if (!fileInput.files.length) return alert("कृपया छवि चुनें।");

  const formData = new FormData();
  formData.append("image", fileInput.files[0]);

  $.ajax({
    url: '/api/user/upload-image',
    method: 'POST',
    data: formData,
    processData: false,
    contentType: false,
    headers: {
      Authorization: 'Bearer ' + localStorage.getItem("authToken")
    },
    success: function (res) {
      latestImagePath = res.imagePath; // Save latest path
      $('#profilePic').attr("src", latestImagePath);
      alert("प्रोफ़ाइल फ़ोटो सफलतापूर्वक अपडेट हो गई।");

      // Auto-save updated path
      $('#profileForm').submit();
    },
    error: function () {
      alert("छवि अपलोड करने में त्रुटि हुई।");
    }
  });
});
</script>
</body>
</html>
