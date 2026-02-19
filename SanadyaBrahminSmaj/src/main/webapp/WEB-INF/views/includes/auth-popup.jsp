<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
  <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>

    <!-- ✅ Modal -->
    <div class="modal fade" id="authModal" tabindex="-1" aria-labelledby="authModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-xl modal-dialog-centered">
        <div class="modal-content p-0 border-0 shadow-lg" style="border-radius: 12px;">
          <div class="row g-0">
            <div id="fullScreenErrorBox" class="alert alert-danger text-center fw-bold m-3 d-none" role="alert"></div>
            <div id="registrationSuccess" class="alert alert-success text-center fw-bold m-3 d-none" role="alert"></div>

            <!-- 🔸 Left Panel -->
            <div class="col-md-5 d-none d-md-block" style="background-color:#91402c; color: white; padding: 25px 20px;">
              <div class="d-flex flex-column justify-content-center align-items-center h-100 text-center">
                <img src="https://res.cloudinary.com/ddyoi5pl3/image/upload/v1771295856/logo_upybpp.png" alt="Welcome" class="img-fluid mb-4" />
                <h4 class="fw-bold">सनाढ्य ब्राह्मण महासभा महावीर नगर प्रथम, कोटा</h4><br />
                <h5 class="fw-bold">आपका स्वागत करती है</h5><br />
                <h4 class="fw-bold">स्वागतम</h4>
              </div>
            </div>

            <!-- 🔸 Right Panel -->
            <div class="col-md-7 bg-white p-4">
              <div class="d-flex justify-content-between align-items-center mb-3">
                <ul class="nav nav-tabs border-0" id="authTab" role="tablist">
                  <li class="nav-item"><button class="nav-link active" id="login-tab" data-bs-toggle="tab"
                      data-bs-target="#loginTab" type="button">लॉगिन</button></li>
                  <li class="nav-item"><button class="nav-link" id="register-tab" data-bs-toggle="tab"
                      data-bs-target="#registerTab" type="button">पंजीकरण</button></li>
                </ul>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
              </div>

              <div class="tab-content mt-3" id="authTabContent">

                <!-- 🔐 Login -->
                <div class="tab-pane fade show active" id="loginTab" role="tabpanel">
                  <form id="loginForm">
                    <div class="mb-3">
                      <label>मोबाइल नंबर *</label>
                      <input id="loginMobile" type="text" class="form-control" placeholder="मोबाइल नंबर" required>
                    </div>
                    <div class="mb-3">
                      <label>पासवर्ड *</label>
                      <input id="loginPassword" type="password" class="form-control" placeholder="पासवर्ड" required>
                    </div>
                    <button type="submit" class="btn btn-primary w-100">लॉगिन</button>
                  </form>
                  <a href="#" data-bs-toggle="modal" data-bs-target="#forgotPasswordModal">🔑 पासवर्ड भूल गए?</a>
                  <div id="forgotPwdSuccess" class="alert alert-success d-none"></div>
                  <div id="forgotPwdError" class="alert alert-danger d-none"></div>

                  <div id="loginError" class="text-danger mt-2"></div>
                </div>

                <!-- 📝 Registration -->
                <div class="tab-pane fade" id="registerTab" role="tabpanel">
                  <form id="registrationForm" enctype="multipart/form-data">
                    <div id="errorBox" class="alert alert-danger d-none" role="alert"></div>
                    <div class="row">

                      <!-- Required Fields -->
                      <div class="col-md-6 mb-3"><label>पूरा नाम *</label><input id="fullName" type="text"
                          class="form-control" required></div>
                      <div class="col-md-6 mb-3"><label>पिता का नाम *</label><input id="fatherName" type="text"
                          class="form-control" required></div>
                      <div class="col-md-6 mb-3"><label>गोत्र *</label><input id="gotra" type="text"
                          class="form-control" required></div>
                      <div class="col-md-6 mb-3"><label>जन्म तिथि *</label><input id="dateOfBirth" type="date"
                          class="form-control" required></div>
                      <div class="col-md-6 mb-3"><label>लिंग *</label>
                        <select id="gender" class="form-select" required>
                          <option value="">लिंग चुनें</option>
                          <option>पुरुष</option>
                          <option>महिला</option>
                          <option>अन्य</option>
                        </select>
                      </div>
                      <div class="col-md-6 mb-3"><label>पता *</label><input id="address" type="text"
                          class="form-control" required></div>
                      <div class="col-md-6 mb-3"><label>मोबाइल नंबर *</label><input id="mobile" type="text"
                          class="form-control" required></div>
                      <div class="col-md-6 mb-3"><label>ईमेल</label><input id="email" type="email" class="form-control">
                      </div>
                      <div class="col-md-6 mb-3"><label>पासवर्ड *</label><input id="password" onkeyup="passwordCheck()" type="password"
                          class="form-control" required></div>
<div id="password-errors" style="color: red;"></div>

                      <!-- Optional Fields -->
                      <div class="col-md-6 mb-3"><label>शैक्षणिक योग्यता</label><input id="education" type="text"
                          class="form-control"></div>
                      <div class="col-md-6 mb-3"><label>पेशा / कार्य</label><input id="occupation" type="text"
                          class="form-control"></div>
                      <div class="col-md-6 mb-3"><label>जिला</label><input id="homeDistrict" type="text"
                          class="form-control"></div>
                      <div class="col-md-6 mb-3"><label>आधार नंबर</label><input id="aadharNumber" type="text"
                          class="form-control"></div>
                      <div class="col-md-6 mb-3"><label>ब्लड ग्रुप</label><input id="bloodGroup" type="text"
                          class="form-control"></div>
                      <div class="col-md-6 mb-3"><label>वैवाहिक स्थिति</label>
                        <select id="maritalStatus" class="form-select">
                          <option value="">चुनें</option>
                          <option>अविवाहित</option>
                          <option>विवाहित</option>
                          <option>अन्य</option>
                        </select>
                      </div>
                      <div class="col-12 mb-3"><label>संस्था / संगठन</label><input id="organizationAffiliation"
                          type="text" class="form-control"></div>
                      <div class="col-12 mb-3"><label>योगदान / सन्देश</label><textarea id="contribution"
                          class="form-control" rows="2"></textarea></div>

                      <!-- 🔁 Profile Image Upload -->
                      <div class="col-12 mb-3"><label>प्रोफ़ाइल फ़ोटो</label><input id="profileImage"
                          name="profileImage" type="file" class="form-control" accept="image/*"></div>

                      <!-- ✔️ Terms -->
                      <div class="col-12 mb-3 form-check">
                        <input type="checkbox" class="form-check-input" id="agreeToTerms" required>
                        <label class="form-check-label" for="agreeToTerms">मैं शर्तों और नियमों से सहमत हूं *</label>
                      </div>

                      <!-- 📤 Submit -->
                      <div class="col-12"><button type="submit" class="btn btn-success w-100">पंजीकरण करें</button>
                      </div>

                    </div>
                  </form>
                </div>

              </div>
            </div>

          </div>
        </div>
      </div>
    </div>
    <!-- 🔑 Forgot Password Modal -->
    <div class="modal fade" id="forgotPasswordModal" tabindex="-1" aria-labelledby="forgotPasswordModalLabel"
      aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content p-3">
          <div class="modal-header">
            <h5 class="modal-title" id="forgotPasswordModalLabel">🔑 पासवर्ड रीसेट अनुरोध</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="बंद करें"></button>
          </div>
          <div class="modal-body">
            <form id="forgotPasswordForm">
              <div class="mb-3">
                <label>मोबाइल नंबर *</label>
                <input type="text" id="fpMobile" class="form-control" required>
              </div>
              <div class="mb-3">
                <label>नया पासवर्ड *</label>
                <input type="password" id="fpNewPassword" onkeyup="modalPasswordCheck()" class="form-control" required>
              <div id="password-errors-modal" style="color: red;"></div>

              </div>
              <div class="mb-3">
                <label>कारण (वैकल्पिक)</label>
                <textarea id="fpReason" class="form-control"></textarea>
              </div>
              <button type="submit" class="btn btn-primary w-100">🔁 अनुरोध भेजें</button>
            </form>
          </div>
        </div>
      </div>
    </div>

    <script>
      $('#forgotPasswordForm').submit(function (e) {
        e.preventDefault();
        const mobile = $('#fpMobile').val().trim();
        const newPassword = $('#fpNewPassword').val().trim();
        const reason = $('#fpReason').val().trim();

        if (!/^\d{10}$/.test(mobile)) {
          bootbox.alert("मान्य 10 अंकों का मोबाइल नंबर दर्ज करें");
          return;
        }

const result = validatePassword(newPassword);

if (result.valid) {
  console.log("पासवर्ड मान्य है ✅");
} else {
  bootbox.alert("पासवर्ड अमान्य ❌:");
  result.errors.forEach(err => console.log("- " + err));
  return;
}
        $.post("/api/auth/forgot-password", {
          mobile,
          newPassword,
          reason
        }).done(function (res) {
          $('#forgotPasswordModal').modal('hide');
          bootbox.alert("✅ " + res.message);
        }).fail(function (xhr) {
          const msg = xhr.responseJSON?.message || "❌ त्रुटि हुई";
          bootbox.alert("⚠️ " + msg);
        });
      });
    </script>

    <!-- ✅ Styles -->
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

    <!-- ✅ Scripts -->
    <script src="${pageContext.request.contextPath}/js/auth.js"></script>