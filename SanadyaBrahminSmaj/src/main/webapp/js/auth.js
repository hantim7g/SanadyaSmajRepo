// Login + register submit handlers for the auth popup.
// Kept as a single, self-contained file — wired in auth-popup.jsp via:
//   <script src="${pageContext.request.contextPath}/resources/js/auth.js"></script>

(function () {
  'use strict';

  const CTX = (window.pageContext && window.pageContext.contextPath) || '';

  // --- Password strength (referenced by the popup's onkeyup handlers) ---
  window.validatePassword = function (pwd) {
    const errors = [];
    if (!pwd || pwd.length < 6) errors.push('कम से कम 6 वर्ण आवश्यक हैं।');
    if (!/[A-Za-z]/.test(pwd)) errors.push('कम से कम एक अक्षर आवश्यक है।');
    if (!/\d/.test(pwd)) errors.push('कम से कम एक अंक आवश्यक है।');
    return { valid: errors.length === 0, errors: errors };
  };

  function paintPasswordErrors(inputId, errBoxId) {
    const el = document.getElementById(inputId);
    const box = document.getElementById(errBoxId);
    if (!el || !box) return;
    const r = window.validatePassword(el.value);
    box.textContent = r.valid ? '' : r.errors.join(' ');
  }

  window.passwordCheck = function () { paintPasswordErrors('password', 'password-errors'); };
  window.modalPasswordCheck = function () { paintPasswordErrors('fpNewPassword', 'password-errors-modal'); };

  // --- Forgot password form (lives inside the same popup) ---
  const fpForm = document.getElementById('forgotPasswordForm');
  if (fpForm) {
    fpForm.addEventListener('submit', function (e) {
      e.preventDefault();
      const mobile = (document.getElementById('fpMobile') || {}).value || '';
      const newPassword = (document.getElementById('fpNewPassword') || {}).value || '';
      const reason = (document.getElementById('fpReason') || {}).value || '';

      if (!/^\d{10}$/.test(mobile.trim())) {
        if (window.bootbox) bootbox.alert('मान्य 10 अंकों का मोबाइल नंबर दर्ज करें');
        return;
      }
      const r = window.validatePassword(newPassword);
      if (!r.valid) {
        if (window.bootbox) bootbox.alert('पासवर्ड अमान्य: ' + r.errors.join(' '));
        return;
      }

      fetch(CTX + '/api/auth/forgot-password?mobile=' + encodeURIComponent(mobile.trim())
          + '&newPassword=' + encodeURIComponent(newPassword)
          + '&reason=' + encodeURIComponent(reason), {
        method: 'POST',
        credentials: 'same-origin'
      }).then(function (res) { return res.json().then(function (b) { return { ok: res.ok, body: b }; }); })
        .then(function (r) {
          const modal = document.getElementById('forgotPasswordModal');
          if (modal && window.bootstrap) bootstrap.Modal.getInstance(modal).hide();
          if (window.bootbox) bootbox.alert((r.ok ? '✅ ' : '⚠️ ') + ((r.body && r.body.message) || 'पूर्ण'));
        }).catch(function () {
          if (window.bootbox) bootbox.alert('⚠️ सर्वर से संपर्क नहीं हो सका');
        });
    });
  }


  function showAlert(boxId, msg, kind) {
    const el = document.getElementById(boxId);
    if (!el) return;
    el.className = 'alert alert-' + kind + ' text-center fw-bold m-3';
    el.textContent = msg;
    el.classList.remove('d-none');
  }

  function hideAlert(boxId) {
    const el = document.getElementById(boxId);
    if (el) el.classList.add('d-none');
  }

  // --- LOGIN -------------------------------------------------------------
  const loginForm = document.getElementById('loginForm');
  if (loginForm) {
    loginForm.addEventListener('submit', function (e) {
      e.preventDefault();
      const mobile = (document.getElementById('loginMobile') || {}).value || '';
      const password = (document.getElementById('loginPassword') || {}).value || '';
      const errEl = document.getElementById('loginError');
      if (errEl) { errEl.textContent = ''; }

      fetch(CTX + '/api/auth/login', {
        method: 'POST',
        credentials: 'same-origin',
        headers: { 'Content-Type': 'application/json', 'Accept': 'application/json' },
        body: JSON.stringify({ mobile: mobile.trim(), password: password })
      }).then(function (res) {
        return res.json().then(function (body) { return { ok: res.ok, body: body }; });
      }).then(function (r) {
        if (r.ok && r.body && r.body.success) {
          // Full reload so the server-side session / navbar reflects the login.
          window.location.href = CTX + '/';
          return;
        }
        const msg = (r.body && (r.body.message || r.body.data)) || 'लॉगिन विफल।';
        if (errEl) errEl.textContent = msg;
      }).catch(function () {
        if (errEl) errEl.textContent = 'सर्वर से संपर्क नहीं हो सका।';
      });
    });
  }

  // --- REGISTER ----------------------------------------------------------
  const regForm = document.getElementById('registrationForm');
  if (regForm) {
    // Mirror the change handler the popup used inline.
    const gotraSel = document.getElementById('gotra');
    const selfGotra = document.getElementById('selfGotraDiv');
    const customGotra = document.getElementById('customGotra');
    if (gotraSel && selfGotra) {
      gotraSel.addEventListener('change', function () {
        const show = gotraSel.value === 'OTHER';
        selfGotra.style.display = show ? '' : 'none';
        if (customGotra) customGotra.required = show;
      });
    }

    // --- Date of birth: display dd/mm/yyyy, keep ISO value for backend ---
    if (window.flatpickr) {
      flatpickr('#dateOfBirth', {
        dateFormat: 'Y-m-d',
        altInput: true,
        altFormat: 'd/m/Y',
        maxDate: 'today',
        allowInput: true,
        onCreate: function (selectedDates, dateStr, instance) {
          if (instance.altInput) instance.altInput.setAttribute('required', 'required');
        }
      });
    }

    // --- Populate city & homeDistrict dropdowns from master data ---
    var citySelect = document.getElementById('city');
    var districtSelect = document.getElementById('homeDistrict');

    fetch(CTX + '/api/cities')
      .then(function (res) { return res.json(); })
      .then(function (items) {
        var cities = [];
        var districts = [];
        items.forEach(function (item) {
          if (item.city) {
            cities.push(item.name);
          } else {
            districts.push(item.name);
          }
        });

        cities.sort(function (a, b) { return a.localeCompare(b); });
        districts.sort(function (a, b) { return a.localeCompare(b); });

        cities.forEach(function (name) {
          var opt = document.createElement('option');
          opt.value = name;
          opt.textContent = name;
          citySelect.appendChild(opt);
        });

        districts.forEach(function (name) {
          var opt = document.createElement('option');
          opt.value = name;
          opt.textContent = name;
          districtSelect.appendChild(opt);
        });
      })
      .catch(function (err) {
        console.error('Failed to load cities/districts:', err);
      });

    regForm.addEventListener('submit', function (e) {
      e.preventDefault();
      hideAlert('errorBox');
      hideAlert('registrationSuccess');
      hideAlert('fullScreenErrorBox');

      const v = function (id) { const el = document.getElementById(id); return el ? el.value : ''; };
      const payload = {
        mobile: v('mobile').trim(),
        password: v('password'),
        fullName: v('fullName').trim(),
        fatherName: v('fatherName').trim(),
        gotra: v('gotra') === 'OTHER' ? v('customGotra').trim() : v('gotra'),
        dateOfBirth: v('dateOfBirth'),
        gender: v('gender'),
        address: v('address').trim(),
        email: v('email').trim(),
        city: v('city').trim(),
        homeDistrict: v('homeDistrict').trim(),
        education: v('education').trim(),
        occupation: v('occupation').trim(),
        aadharNumber: v('aadharNumber').trim(),
        bloodGroup: v('bloodGroup').trim(),
        maritalStatus: v('maritalStatus'),
        organizationAffiliation: v('organizationAffiliation').trim(),
        contribution: v('contribution').trim(),
        agreeToTerms: !!document.getElementById('agreeToTerms') && document.getElementById('agreeToTerms').checked
      };

      if (!/^\d{10}$/.test(payload.mobile)) {
        showAlert('errorBox', 'मान्य 10 अंकों का मोबाइल नंबर दर्ज करें।', 'danger');
        return;
      }
      if (!payload.agreeToTerms) {
        showAlert('errorBox', 'कृपया नियम और शर्तें स्वीकार करें।', 'danger');
        return;
      }

      const formData = new FormData();
      formData.append('data', new Blob([JSON.stringify(payload)], { type: 'application/json' }));
      const fileInput = document.getElementById('profileImage');
      if (fileInput && fileInput.files.length > 0) {
        formData.append('file', fileInput.files[0]);
      }

      fetch(CTX + '/api/auth/register', {
        method: 'POST',
        credentials: 'same-origin',
        headers: { 'Accept': 'application/json' },
        body: formData
      }).then(function (res) {
        return res.json().then(function (body) { return { ok: res.ok, body: body }; });
      }).then(function (r) {
        if (r.ok && r.body && r.body.success) {
          showAlert('registrationSuccess', r.body.message || 'पंजीकरण सफल।', 'success');
          regForm.reset();
          if (selfGotra) selfGotra.style.display = 'none';
          return;
        }
        const msg = (r.body && r.body.message) ?? 'पंजीकरण विफल।';
        const fieldErrors = r.body && r.body.data;
        let displayMsg = msg;
        if (fieldErrors && typeof fieldErrors === 'object') {
          displayMsg += '<ul class="mt-2 mb-0">';
          for (const key in fieldErrors) {
            if (fieldErrors.hasOwnProperty(key)) {
              displayMsg += '<li>' + fieldErrors[key] + '</li>';
            }
          }
          displayMsg += '</ul>';
        }
        showAlert('errorBox', displayMsg, 'danger');
      }).catch(function () {
        showAlert('errorBox', 'सर्वर से संपर्क नहीं हो सका।', 'danger');
      });
    });
  }
})();
