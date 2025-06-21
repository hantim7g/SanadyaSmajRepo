<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>

<div class="modal fade" id="authModal" tabindex="-1" aria-labelledby="authModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-xl modal-dialog-centered">
    <div class="modal-content p-0 border-0 shadow-lg" style="border-radius: 12px;">
      <div class="row g-0">
        <!-- Image Left -->
        <div class="col-md-5 d-none d-md-block" style="background-color:#91402c; color: white; padding: 25px 20px;">
          <div class="d-flex flex-column justify-content-center align-items-center h-100 text-center">
            <img src="/logo/logo.png" alt="Welcome" class="img-fluid mb-4" />
            <h4 class="fw-bold">सनाढ्य ब्राह्मण सभा, कोटा</h4><br/>
            <h5 class="fw-bold">आपका स्वागत करती है</h5><br/>
            <h4 class="fw-bold">स्वागतम</h4>
          </div>
        </div>

        <!-- Registration/Login Form -->
        <div class="col-md-7 bg-white p-4">
          <div class="d-flex justify-content-between align-items-center mb-3">
            <ul class="nav nav-tabs border-0" id="authTab" role="tablist">
              <li class="nav-item"><button class="nav-link active" id="register-tab" data-bs-toggle="tab" data-bs-target="#registerTab" type="button">पंजीकरण</button></li>
              <li class="nav-item"><button class="nav-link" id="login-tab" data-bs-toggle="tab" data-bs-target="#loginTab" type="button">लॉगिन</button></li>
            </ul>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>

          <div class="tab-content mt-3" id="authTabContent">

            <!-- Registration -->
            <div class="tab-pane fade show active" id="registerTab" role="tabpanel">
              <form id="registrationForm">
                <div id="errorBox" class="alert alert-danger d-none" role="alert"></div>
                <div class="row">
                  <div class="col-md-6 mb-3"><label class="form-label">पूरा नाम <span class="text-danger">*</span></label><input id="fullName" type="text" class="form-control" required></div>
                  <div class="col-md-6 mb-3"><label class="form-label">पिता का नाम <span class="text-danger">*</span></label><input id="fatherName" type="text" class="form-control" required></div>
                  <div class="col-md-6 mb-3"><label class="form-label">गोत्र <span class="text-danger">*</span></label><input id="gotra" type="text" class="form-control" required></div>
                  <div class="col-md-6 mb-3"><label class="form-label">जन्म तिथि <span class="text-danger">*</span></label><input id="dateOfBirth" type="date" class="form-control" required></div>
                  <div class="col-md-6 mb-3"><label class="form-label">लिंग <span class="text-danger">*</span></label>
                    <select id="gender" class="form-select" required>
                      <option value="">लिंग चुनें</option><option>पुरुष</option><option>महिला</option><option>अन्य</option>
                    </select>
                  </div>
                  <div class="col-md-6 mb-3"><label class="form-label">पता <span class="text-danger">*</span></label><input id="address" type="text" class="form-control" required></div>
                  <div class="col-md-6 mb-3"><label class="form-label">मोबाइल नंबर <span class="text-danger">*</span></label><input id="mobile" type="text" class="form-control" required></div>
                  <div class="col-md-6 mb-3"><label class="form-label">ईमेल</label><input id="email" type="email" class="form-control"></div>
                  <div class="col-md-6 mb-3"><label class="form-label">पासवर्ड <span class="text-danger">*</span></label><input id="password" type="password" class="form-control" required></div>
                  <div class="col-md-6 mb-3"><label class="form-label">शैक्षणिक योग्यता</label><input id="education" type="text" class="form-control"></div>
                  <div class="col-md-6 mb-3"><label class="form-label">पेशा / कार्य</label><input id="occupation" type="text" class="form-control"></div>
                  <div class="col-md-6 mb-3"><label class="form-label">जिला</label><input id="homeDistrict" type="text" class="form-control"></div>
                  <div class="col-md-6 mb-3"><label class="form-label">आधार नंबर</label><input id="aadharNumber" type="text" class="form-control"></div>
                  <div class="col-md-6 mb-3"><label class="form-label">ब्लड ग्रुप</label><input id="bloodGroup" type="text" class="form-control"></div>
                  <div class="col-md-6 mb-3"><label class="form-label">वैवाहिक स्थिति</label>
                    <select id="maritalStatus" class="form-select">
                      <option value="">चुनें</option><option>अविवाहित</option><option>विवाहित</option><option>अन्य</option>
                    </select>
                  </div>
                  <div class="col-12 mb-3"><label class="form-label">संस्था / संगठन</label><input id="organizationAffiliation" type="text" class="form-control"></div>
                  <div class="col-12 mb-3"><label class="form-label">योगदान / सन्देश</label><textarea id="contribution" class="form-control" rows="2"></textarea></div>
                  <div class="col-12 mb-3 form-check">
                    <input type="checkbox" class="form-check-input" id="agreeToTerms" required>
                    <label class="form-check-label" for="agreeToTerms">मैं शर्तों और नियमों से सहमत हूं <span class="text-danger">*</span></label>
                  </div>
                  <div class="col-12"><button type="submit" class="btn btn-success w-100">पंजीकरण करें</button></div>
                </div>
              </form>
            </div>

            <!-- Login -->
            <div class="tab-pane fade" id="loginTab" role="tabpanel">
              <form>
                <div class="mb-3"><input type="text" class="form-control" placeholder="मोबाइल नंबर" required></div>
                <div class="mb-3"><input type="password" class="form-control" placeholder="पासवर्ड" required></div>
                <button type="submit" class="btn btn-primary w-100">लॉगिन</button>
              </form>
            </div>

          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Style -->
<style>
  #authModal .nav-link.active {
    color: #4d2c91;
    border-bottom: 2px solid #4d2c91;
    font-weight: bold;
  }
  #authModal .nav-link {
    color: #666;
  }
</style>

<!-- jQuery & Validation Script -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
  $(function () {
    $('#registrationForm').submit(function (e) {
      e.preventDefault();
      const mobile = $('#mobile').val().trim();
      const password = $('#password').val().trim();
      const errorBox = $('#errorBox');

      if (!/^\d{10}$/.test(mobile)) {
        return showError("मोबाइल नंबर 10 अंकों का होना चाहिए");
      }

      if (password.length < 6) {
        return showError("पासवर्ड कम से कम 6 अक्षरों का होना चाहिए");
      }

      const data = {
        fullName: $('#fullName').val(),
        fatherName: $('#fatherName').val(),
        gotra: $('#gotra').val(),
        dateOfBirth: $('#dateOfBirth').val(),
        gender: $('#gender').val(),
        address: $('#address').val(),
        mobile: mobile,
        email: $('#email').val(),
        password: password,
        education: $('#education').val(),
        occupation: $('#occupation').val(),
        homeDistrict: $('#homeDistrict').val(),
        aadharNumber: $('#aadharNumber').val(),
        bloodGroup: $('#bloodGroup').val(),
        maritalStatus: $('#maritalStatus').val(),
        organizationAffiliation: $('#organizationAffiliation').val(),
        contribution: $('#contribution').val(),
        agreeToTerms: $('#agreeToTerms').is(':checked'),
        role: "USER"
      };

      $.ajax({
        url: '/api/register',
        method: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(data),
        success: function () {
          alert("✅ पंजीकरण सफल हुआ!");
          $('#authModal').modal('hide');
          $('#registrationForm')[0].reset();
          errorBox.addClass("d-none");
        },
        error: function (err) {
          console.error(err);
          showError("❌ पंजीकरण विफल रहा। कृपया विवरण जांचें।");
        }
      });

      function showError(message) {
        errorBox.removeClass("d-none").text(message);
      }
    });
  });
</script>
