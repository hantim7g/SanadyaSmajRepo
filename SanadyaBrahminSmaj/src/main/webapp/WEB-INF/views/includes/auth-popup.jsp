<!-- <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- /WEB-INF/views/includes/auth-popup.jsp -->
<div class="modal fade" id="authModal" tabindex="-1" aria-labelledby="authModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-centered">
    <div class="modal-content p-0 border-0 shadow-lg" style="border-radius: 12px;">
      <div class="row g-0">
        <!-- Left side graphic -->
        <div class="col-md-5 d-none d-md-block" style="background-color:#91402c; color: white; padding: 25px 20px;">
          <div class="d-flex flex-column justify-content-center align-items-center h-100 text-center">
            <img src="/logo/logo.png" alt="Welcome" class="img-fluid mb-4" />
            <h4 class="fw-bold"> सनाढ्य ब्राह्मण सभा, <br/>कोटा</h4><br/>
                        <h5 class="fw-bold">आपका स्वागत करती है| </h5><br>
                           <h4 class="fw-bold">   स्वागतम</h4>

          </div>
        </div>

        <!-- Right side form -->
        <div class="col-md-7 bg-white p-4">
          <div class="d-flex justify-content-between align-items-center mb-3">
            <ul class="nav nav-tabs border-0" id="authTab" role="tablist">
              <li class="nav-item" role="presentation">
                <button class="nav-link active" id="login-tab" data-bs-toggle="tab" data-bs-target="#loginTab" type="button" role="tab">LOGIN</button>
              </li>
              <li class="nav-item" role="presentation">
                <button class="nav-link" id="register-tab" data-bs-toggle="tab" data-bs-target="#registerTab" type="button" role="tab">REGISTER</button>
              </li>
            </ul>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>

          <div class="tab-content mt-3" id="authTabContent">
            <!-- Login Tab -->
            <div class="tab-pane fade show active" id="loginTab" role="tabpanel">
              <form>
                <div class="mb-3">
                  <label class="form-label">User Name<span class="text-danger">*</span></label>
                  <input type="email" class="form-control" placeholder="Enter your Email ID" required>
                </div>
                <div class="mb-3">
                  <label class="form-label">Password<span class="text-danger">*</span></label>
                  <input type="password" class="form-control" placeholder="Enter Password" required>
                  <div class="text-end"><a href="#" class="small">Forgot Password</a></div>
                </div>
                <div class="mb-3">
                  <label class="form-label">CAPTCHA</label><br>
                  <img src="/captcha" alt="Captcha" style="height: 38px;">
                  <button type="button" class="btn btn-link p-0 ms-2"><i class="bi bi-arrow-clockwise"></i></button>
                </div>
                <div class="mb-3">
                  <input type="text" class="form-control" placeholder="Enter above CAPTCHA Code" required>
                </div>
                <button type="submit" class="btn btn-primary w-100">Login</button>
              </form>
            </div>

            <!-- Register Tab -->
            <div class="tab-pane fade" id="registerTab" role="tabpanel">
              <form>
                <div class="mb-3">
                  <label class="form-label">Full Name<span class="text-danger">*</span></label>
                  <input type="text" class="form-control" placeholder="Enter your Name" required>
                </div>
                <div class="mb-3">
                  <label class="form-label">Mobile Number<span class="text-danger">*</span></label>
                  <input type="text" class="form-control" placeholder="10-digit mobile" required>
                </div>
                <div class="mb-3">
                  <label class="form-label">Email Address</label>
                  <input type="email" class="form-control" placeholder="example@gmail.com">
                </div>
                <div class="mb-3">
                  <label class="form-label">Password<span class="text-danger">*</span></label>
                  <input type="password" class="form-control" placeholder="Create a password" required>
                </div>
                <button type="submit" class="btn btn-success w-100">Register</button>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

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

<!-- /WEB-INF/views/includes/auth-popup.jsp -->
<div class="modal fade" id="authModal" tabindex="-1" aria-labelledby="authModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-xl modal-dialog-centered">
    <div class="modal-content p-0 border-0 shadow-lg" style="border-radius: 12px;">
      <div class="row g-0">
        <!-- चित्र -->
        <div class="col-md-5 d-none d-md-flex flex-column justify-content-center align-items-center text-white p-4" style="background-color:#4d2c91;">
          <img src="/images/login-illustration.png" class="img-fluid mb-4" alt="स्वागत है">
          <h4 class="fw-bold">आपका स्वागत है</h4>
        </div>

        <!-- रजिस्ट्रेशन फॉर्म -->
        <div class="col-md-7 bg-white p-4">
          <div class="d-flex justify-content-between align-items-center mb-3">
            <ul class="nav nav-tabs border-0" id="authTab" role="tablist">
              <li class="nav-item" role="presentation">
                <button class="nav-link active" id="register-tab" data-bs-toggle="tab" data-bs-target="#registerTab" type="button" role="tab">पंजीकरण</button>
              </li>
              <li class="nav-item" role="presentation">
                <button class="nav-link" id="login-tab" data-bs-toggle="tab" data-bs-target="#loginTab" type="button" role="tab">लॉगिन</button>
              </li>
            </ul>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>

          <div class="tab-content mt-3" id="authTabContent">

            <!-- 🔐 पंजीकरण -->
            <div class="tab-pane fade show active" id="registerTab" role="tabpanel">
              <form id="registrationForm">
                <div class="row">
                  <div class="col-md-6 mb-3"><input id="fullName" type="text" class="form-control" placeholder="पूरा नाम*" required></div>
                  <div class="col-md-6 mb-3"><input id="fatherName" type="text" class="form-control" placeholder="पिता का नाम*" required></div>
                  <div class="col-md-6 mb-3"><input id="gotra" type="text" class="form-control" placeholder="गोत्र*" required></div>
                  <div class="col-md-6 mb-3"><input id="dateOfBirth" type="date" class="form-control" required></div>
                  <div class="col-md-6 mb-3">
                    <select id="gender" class="form-select" required>
                      <option value="">लिंग*</option>
                      <option>पुरुष</option>
                      <option>महिला</option>
                      <option>अन्य</option>
                    </select>
                  </div>
                  <div class="col-md-6 mb-3"><input id="address" type="text" class="form-control" placeholder="पता*" required></div>
                  <div class="col-md-6 mb-3"><input id="mobile" type="text" class="form-control" placeholder="मोबाइल नंबर*" required></div>
                  <div class="col-md-6 mb-3"><input id="email" type="email" class="form-control" placeholder="ईमेल (वैकल्पिक)"></div>
                  <div class="col-md-6 mb-3"><input id="password" type="password" class="form-control" placeholder="पासवर्ड*" required></div>
                  <div class="col-md-6 mb-3"><input id="education" type="text" class="form-control" placeholder="शैक्षणिक योग्यता"></div>
                  <div class="col-md-6 mb-3"><input id="occupation" type="text" class="form-control" placeholder="पेशा / कार्य"></div>
                  <div class="col-md-6 mb-3"><input id="homeDistrict" type="text" class="form-control" placeholder="जन्म स्थान / जिला"></div>
                  <div class="col-md-6 mb-3"><input id="aadharNumber" type="text" class="form-control" placeholder="आधार नंबर"></div>
                  <div class="col-md-6 mb-3"><input id="bloodGroup" type="text" class="form-control" placeholder="ब्लड ग्रुप"></div>
                  <div class="col-md-6 mb-3">
                    <select id="maritalStatus" class="form-select">
                      <option value="">वैवाहिक स्थिति</option>
                      <option>अविवाहित</option>
                      <option>विवाहित</option>
                      <option>अन्य</option>
                    </select>
                  </div>
                  <div class="col-12 mb-3"><input id="organizationAffiliation" type="text" class="form-control" placeholder="संस्था / संगठन (यदि कोई हो)"></div>
                  <div class="col-12 mb-3"><textarea id="contribution" class="form-control" rows="2" placeholder="आपका योगदान या सन्देश"></textarea></div>
                  <div class="col-12 mb-3 form-check">
                    <input type="checkbox" class="form-check-input" id="agreeToTerms" required>
                    <label class="form-check-label" for="agreeToTerms">मैं शर्तों और नियमों से सहमत हूं</label>
                  </div>
                  <div class="col-12">
                    <button type="submit" class="btn btn-success w-100">पंजीकरण करें</button>
                  </div>
                </div>
              </form>
            </div>

            <!-- 🔑 लॉगिन -->
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

<!-- ✅ स्टाइल -->
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

<!-- ✅ जावास्क्रिप्ट -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
  $(function () {
    $('#registrationForm').submit(function (e) {
      e.preventDefault();

      const data = {
        fullName: $('#fullName').val(),
        fatherName: $('#fatherName').val(),
        gotra: $('#gotra').val(),
        dateOfBirth: $('#dateOfBirth').val(),
        gender: $('#gender').val(),
        address: $('#address').val(),
        mobile: $('#mobile').val(),
        email: $('#email').val(),
        password: $('#password').val(),
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
        },
        error: function (err) {
          console.error(err);
          alert("❌ पंजीकरण विफल रहा। कृपया विवरण जांचें।");
        }
      });
    });
  });
</script>
