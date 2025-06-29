$(function() {
	// Login form submit handler
	$('#loginForm').submit(function(e) {
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
			success: function(res) {
				if (res.success) {
					debugger;
					// ✅ Store JWT
					localStorage.setItem("authToken", res.data.token);
					localStorage.setItem("userName", res.message);
					if (isAdminUser(res.data.token)) {
						document.getElementById("adminArea").classList.remove("d-none");
					}

					// ✅ Store user name (assuming backend sends name in token or decode it if needed)
					const userName = res.message || "प्रयोगकर्ता"; // Or extract from token

					// ✅ Replace login button with user dropdown
					$('#loginArea').html(`
      <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">${userName}</a>
      <ul class="dropdown-menu dropdown-menu-end">
  <a class="dropdown-item" href="/member/profile">👤 प्रोफ़ाइल देखें</a>
            <li><a class="dropdown-item" href="/member/doc">📜 सदस्य निर्देशिका</a></li>

<li><a class="dropdown-item text-danger" href="#" onclick="handleLogout(event)">🚪 लॉगआउट</a></li>
      </ul>
    `);


					$('#authModal').modal('hide');
					const dialog = bootbox.alert({
						title: "<h4 class='text-success text-center'>🔐 लॉगिन सफल!</h4>",
						message: "<p class='text-center fs-5'>✅ आपको होम पेज पर भेजा जा रहा है...</p>",
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

				} else {

					const msg = res.message|| "लॉगिन असफल। कृपया विवरण जांचें।";
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

			},

			error: function(xhr) {
				const msg = xhr.responseJSON.message || "लॉगिन असफल। कृपया विवरण जांचें।";
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
});



$(function() {
	$('#registrationForm').submit(function(e) {
		e.preventDefault();
		const errorBox = $('#errorBox');
		errorBox.addClass("d-none");

		const mobile = $('#mobile').val().trim();
		const password = $('#password').val().trim();

		if (!/^\d{10}$/.test(mobile)) {
			return showError("मोबाइल नंबर 10 अंकों का होना चाहिए");
		}

		if (password.length < 6) {
			return showError("पासवर्ड कम से कम 6 अक्षरों का होना चाहिए");
		}

		const jsonData = {
			fullName: $('#fullName').val(),
			fatherName: $('#fatherName').val(),
			dateOfBirth: $('#dateOfBirth').val(),
			gotra:$('#gotra').val(),
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

		// 1. First send JSON data (excluding image)
		$.ajax({
			url: '/api/auth/register',
			method: 'POST',
			contentType: 'application/json',
			data: JSON.stringify(jsonData),
			success: function(response) {
				const userId = response.data.userId || response.data.id || null;
debugger;
				// 2. If image selected, send it separately using FormData
				const fileInput = $('#profileImage')[0];
				if (fileInput.files.length > 0 && userId) {
					const formData = new FormData();
					formData.append("file", fileInput.files[0]);
					formData.append("userId", userId); // Optional

					$.ajax({
						url: `/api/auth/upload-profile-image`,
						method: 'POST',
						data: formData,
						processData: false,
						contentType: false,
						success: function() {
						
							const dialog = bootbox.alert({
						title: "<h4 class='text-success text-center'>पंजीकरण सफल!</h4>",
						message: "<p class='text-center fs-5'>✅ पंजीकरण और छवि अपलोड सफल!</p>",
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
						error: function() {
							alert("⚠️ पंजीकरण सफल, लेकिन छवि अपलोड विफल।");
							resetForm();
						}
					});
				} else {
					
					
					
							const dialog = bootbox.alert({
						title: "<h4 class='text-success text-center'>पंजीकरण सफल!</h4>",
						message: "<p class='text-center fs-5'>✅ पंजीकरण सफल!</p>",
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
						
					
					
					
				}
			},
			error: function(err) {
				console.error(err);
				
				const msg = err.responseJSON.message || "❌ पंजीकरण विफल रहा। कृपया विवरण जांचें।";
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

		function resetForm() {
			$('#authModal').modal('hide');
			$('#registrationForm')[0].reset();
			errorBox.addClass("d-none");
		}

		function showError(msg) {
			errorBox.removeClass("d-none").text(msg);
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
  <a class="dropdown-item" href="/member/profile">👤 प्रोफ़ाइल देखें</a>
            <li><a class="dropdown-item" href="/member/doc">📜 सदस्य निर्देशिका</a></li>

<li><a class="dropdown-item text-danger" href="#" onclick="handleLogout(event)">🚪 लॉगआउट</a></li>
      </ul>
    `);
	}
});
