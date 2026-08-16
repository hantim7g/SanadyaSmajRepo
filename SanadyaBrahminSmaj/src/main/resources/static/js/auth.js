$(function () {

  $('#loginForm').submit(function (e) {
    e.preventDefault();

    const mobile = $('#loginMobile').val().trim();
    const password = $('#loginPassword').val().trim();

    if (!/^\d{10}$/.test(mobile)) {
      $('#loginError').text("मान्य मोबाइल नंबर दर्ज करें");
      return;
    }

    if (password.length < 4) {
      $('#loginError').text("पासवर्ड मान्य नहीं है");
      return;
    }

    $.ajax({
      url: '/api/auth/login',
      type: 'POST',
      contentType: 'application/json',
      data: JSON.stringify({ mobile, password }),
      xhrFields: { withCredentials: true }, // 🔐 HttpOnly cookie
      success: function (res) {

        if (!res.success) {
          showError(res.message || "लॉगिन असफल");
          return;
        }

		$('#authModal').modal('hide');
						const dialog = bootbox.alert({
							title: "<h4 class='text-success text-center'>🔐 लॉगिन सफल!</h4>",
							message: "<p class='text-center fs-5'>✅ आपको होम पेज पर भेजा जा रहा है...</p>",
							centerVertical: true,
							buttons: {
								ok: {
									label: 'ठीक है',
									className: 'btn btn-light'
								}
							}
						});

						setTimeout(() => {
							dialog.modal('hide');
							window.location.href = "/home"; // or your dashboard route
						}, 3000);

					      },
      error: function (xhr) {
       // showError(xhr.responseJSON?.message || "लॉगिन असफल");
		const msg = xhr.responseJSON?.message || "लॉगिन असफल";
					bootbox.alert({
						title: "<h4 class='text-danger text-center'>⚠️ त्रुटि</h4>",
						message: `<div class='text-center fs-5'>${msg}</div>`,
						centerVertical: true,
						buttons: {
							ok: {
								
								label: 'फिर से प्रयास करें',
								className: 'btn btn-danger px-4'
							}
						}
					});
		
		
      }
    });
  });

  function showError(msg) {
    bootbox.alert({
      title: "⚠️ त्रुटि",
      message: msg
    });
  }
});



$(function() {
	$('#registrationForm').submit(function(e) {
		e.preventDefault();
		const errorBox = $('#errorBox');
		errorBox.addClass("d-none");

		const mobile = $('#mobile').val().trim();
		const password = $('#password').val().trim();
		const selectedGotra = $('#gotra').val();
		const customGotra = $('#customGotra').val().trim();

		if (selectedGotra === 'OTHER' && !customGotra) {
			return showError('Please enter your custom Gotra.');
		}

		/*if (!/^\d{10}$/.test(mobile)) {
			return showError("मोबाइल नंबर 10 अंकों का होना चाहिए");
		}

		if (password.length < 6) {
			return showError("पासवर्ड कम से कम 6 अक्षरों का होना चाहिए");
		}*/

const result = validatePassword(password);

if (result.valid) {
  console.log("पासवर्ड मान्य है ✅");
} else {
  console.log("पासवर्ड अमान्य ❌:");
  result.errors.forEach(err => console.log("- " + err));
  return showError("पासवर्ड अमान्य ❌:");
}


		const jsonData = {
			fullName: $('#fullName').val(),
			fatherName: $('#fatherName').val(),
			dateOfBirth: $('#dateOfBirth').val(),
			gotra: selectedGotra === 'OTHER' ? customGotra : selectedGotra,
			gender: $('#gender').val(),
			address: $('#address').val(),
			mobile: mobile,
			email: $('#email').val(),
			password: password,
			education: $('#education').val(),
			occupation: $('#occupation').val(),
			homeDistrict: $('#homeDistrict').val(),
			city: $('#city').val(),
			aadharNumber: $('#aadharNumber').val(),
			bloodGroup: $('#bloodGroup').val(),
			maritalStatus: $('#maritalStatus').val(),
			organizationAffiliation: $('#organizationAffiliation').val(),
			contribution: $('#contribution').val(),
			agreeToTerms: $('#agreeToTerms').is(':checked'),
			role: "USER"
		};

		// 📤 Send registration data + profile image together in a single multipart request
		const formData = new FormData();
		formData.append("data", new Blob([JSON.stringify(jsonData)], { type: "application/json" }));
		const fileInput = $('#profileImage')[0];
		if (fileInput.files.length > 0) {
			formData.append("file", fileInput.files[0]);
		}

		$.ajax({
			url: '/api/auth/register',
			method: 'POST',
			data: formData,
			processData: false,
			contentType: false,
			success: function(response) {
				const dialog = bootbox.alert({
					title: "<h4 class='text-success text-center'>पंजीकरण सफल!</h4>",
					message: "<p class='text-center fs-5'>✅ पंजीकरण सफल! कृपया अनुमोदन की प्रतीक्षा करें।</p>",
					centerVertical: true,
					buttons: {
						ok: {
							label: 'रोकें',
							className: 'btn btn-light'
						}
					}
				});

				setTimeout(() => {
					dialog.modal('hide');
					window.location.href = "/home"; // or your dashboard route
				}, 3000);
			},
			error: function(err) {
				console.error(err);
				
				const resp = err.responseJSON;
				const msg = resp?.message ?? "❌ पंजीकरण विफल रहा। कृपया विवरण जांचें।";
				const fieldErrors = resp?.data;
				
				let errorHtml = `<div class='text-center fs-5'>${msg}</div>`;
				if (fieldErrors && typeof fieldErrors === 'object') {
					errorHtml += "<ul class='text-start mt-3'>";
					for (const [field, errorMsg] of Object.entries(fieldErrors)) {
						errorHtml += `<li>${errorMsg}</li>`;
					}
					errorHtml += "</ul>";
				}
				
				bootbox.alert({
					title: "<h4 class='text-danger text-center'>⚠️ त्रुटि</h4>",
					message: errorHtml,
					centerVertical: true,
					buttons: {
						ok: {
							label: 'फिर से प्रयास करें',
							className: 'btn btn-danger px-4'
						}
					}
				});
			}
		});

		function showError(msg) {
			errorBox.removeClass("d-none").text(msg);
		}
	});
	function toggleCustomGotra() {
		const isOther = $('#gotra').val() === 'OTHER';
		$('#selfGotraDiv').toggle(isOther);
		$('#customGotra').prop('required', isOther);
	}

	$('#gotra').on('change', toggleCustomGotra);
	toggleCustomGotra();

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
	var citySelect = $('#city');
	var districtSelect = $('#homeDistrict');

	$.ajax({
		url: '/api/cities',
		method: 'GET',
		success: function(items) {
			var cities = [];
			var districts = [];
			items.forEach(function(item) {
				if (item.city) {
					cities.push(item.name);
				} else {
					districts.push(item.name);
				}
			});

			cities.sort(function(a, b) { return a.localeCompare(b); });
			districts.sort(function(a, b) { return a.localeCompare(b); });

			cities.forEach(function(name) {
				citySelect.append(new Option(name, name));
			});
			districts.forEach(function(name) {
				districtSelect.append(new Option(name, name));
			});
		},
		error: function(err) {
			console.error('Failed to load cities/districts:', err);
		}
	});
});




//$(document).on("click", "#logoutBtn", function () {
// localStorage.removeItem("authToken");
//location.reload(); // Refresh to reflect logout state
//});
$(document).ready(function() {
	const token = localStorage.getItem("authToken");
	const userNameStore = localStorage.getItem("userName");

	if (token) {
		let userName = "प्रयोगकर्ता";

		try {
			const payloadBase64 = token.split('.')[1];
			const decodedPayload = atob(payloadBase64);
			const payload = JSON.parse(decodedPayload);

			// Try fields in order of preference
			userName = userNameStore || payload.name || payload.sub || payload.mobile || "प्रयोगकर्ता";
		} catch (e) {
			console.warn("⚠️ Invalid JWT or payload:", e);
		}

		$('#loginArea').html(`
      <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">${userName}</a>
      <ul class="dropdown-menu dropdown-menu-end">
  <a class="dropdown-item" href="/member/profile">प्रोफ़ाइल देखें</a>
     <li><a class="dropdown-item" href="/member/payment">भुगतान</a></li>
            <li><a class="dropdown-item" href="/member/doc/admin">सदस्य निर्देशिका</a></li>

<li><a class="dropdown-item text-danger" href="#" onclick="handleLogout(event)">लॉगआउट</a></li>
      </ul>
    `);
	}
});
function validatePassword(password) {
	  const pwd = String(password || ""); // avoid null/undefined issues

  const minLength = 8;
  const commonPasswords = ["123456", "password", "12345678", "qwerty", "abc123", "111111"];

  const errors = [];

  if (password.length < minLength) {
    errors.push("कम से कम 8 अक्षरों का पासवर्ड होना चाहिए।");
  }

  if (!/[A-Z]/.test(password)) {
    errors.push("कम से कम एक बड़ा अक्षर होना चाहिए।");
  }

  if (!/[a-z]/.test(password)) {
    errors.push("कम से कम एक छोटा अक्षर होना चाहिए।");
  }

  if (!/[0-9]/.test(password)) {
    errors.push("कम से कम एक अंक होना चाहिए।");
  }

  if (!/[!@#$%^&*(),.?":{}|<>]/.test(password)) {
    errors.push("कम से कम एक विशेष अक्षर होना चाहिए (जैसे !@#$%^&*)।");
  }

  if (commonPasswords.includes(password.toLowerCase())) {
    errors.push("यह पासवर्ड बहुत आम है, कृपया एक मजबूत पासवर्ड चुनें।");
  }

  return {
    valid: errors.length === 0,
    errors: errors
  };
}

function passwordCheck() {
		const psd= $("#password").val()
    const result = validatePassword(psd);
    const $errorBox = $('#password-errors');
    $errorBox.empty();
    if (!result.valid) {
      result.errors.forEach(error => $errorBox.append(`<div>• ${error}</div>`));
    }
  };
  function modalPasswordCheck() {
	const psd= $("#fpNewPassword").val()
    const result = validatePassword(psd);
    const $errorBox = $('#password-errors-modal');
    $errorBox.empty();
    if (!result.valid) {
      result.errors.forEach(error => $errorBox.append(`<div>• ${error}</div>`));
    }
  };
  
