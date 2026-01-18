<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="hi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>सनाढ्य ब्राह्मण सभा</title>

  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+Devanagari:wght@300;400;600;700&display=swap" rel="stylesheet">

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

  <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
  <link rel="stylesheet" href="https://cdn.datatables.net/buttons/2.4.2/css/buttons.dataTables.min.css">

  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

  <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
  <script src="https://cdn.datatables.net/buttons/2.4.2/js/dataTables.buttons.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.7/pdfmake.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.7/vfs_fonts.js"></script>
  <script src="https://cdn.datatables.net/buttons/2.4.2/js/buttons.html5.min.js"></script>
  <script src="https://cdn.datatables.net/buttons/2.4.2/js/buttons.print.min.js"></script>

  <script src="https://cdn.jsdelivr.net/npm/bootbox@6.0.0/dist/bootbox.min.js"></script>
  <script src="https://cdn.datatables.net/responsive/2.5.0/js/dataTables.responsive.min.js"></script>

  <style>
    body {
      background-color: #fffaf0;
      font-family: 'Segoe UI', 'Noto Sans Devanagari', sans-serif;
	
     
      
    }
	/* ======================
	   FOOTER STYLES
	====================== */

	.site-footer {
	  font-family: 'Segoe UI', 'Noto Sans Devanagari', sans-serif;
	}

	.footer-top {
	  background: linear-gradient(135deg, #b65c02 0%, #8a3f01 100%);
	  color: #fff;
	}

	.footer-title {
	  font-weight: 700;
	  margin-bottom: 15px;
	  color: #ffe0b3;
	}

	.footer-text {
	  font-size: 14px;
	  line-height: 1.8;
	  color: #fff3e0;
	}

	.footer-links {
	  list-style: none;
	  padding: 0;
	  margin: 0;
	}

	.footer-links li {
	  margin-bottom: 8px;
	}

	.footer-links a {
	  color: #fff;
	  text-decoration: none;
	  font-size: 14px;
	  transition: all 0.2s ease;
	}

	.footer-links a:hover {
	  color: #ffd180;
	  padding-left: 5px;
	}

	.footer-social a {
	  display: inline-block;
	  width: 36px;
	  height: 36px;
	  line-height: 36px;
	  text-align: center;
	  background-color: #f87e03;
	  color: #fff;
	  border-radius: 50%;
	  margin-right: 8px;
	  transition: all 0.3s ease;
	}

	.footer-social a:hover {
	  background-color: #ffa600;
	  transform: translateY(-3px);
	}

	.footer-bottom {
	  background-color: #5c2a00;
	  color: #ffe0b3;
	  font-size: 13px;
	}

    .navbar-custom {
      background: linear-gradient(135deg, #f87e03 0%, #b65c02 100%);
      font-family: 'Segoe UI', sans-serif;
      font-weight: bold;
      box-shadow: 0 2px 4px rgba(0,0,0,0.15);
	  width: 100%;
    }

    .navbar-custom .nav-link,
    .navbar-custom .navbar-brand {
      color: #fff;
      padding-left: 8px;
      padding-right: 8px;
      transition: all 0.3s ease;
    }

    .navbar-custom .nav-link:hover,
    .navbar-custom .dropdown-item:hover {
      color: #000;
      background-color: #ffa600;
      transform: translateY(-1px);
    } 

    .dropdown-menu {
      background-color: #b65c02;
      border-radius: 8px;
      border: none;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.15);
      animation: slideDown 0.3s ease;
    }

    @keyframes slideDown {
      from { opacity: 0; transform: translateY(-10px); }
      to { opacity: 1; transform: translateY(0); }
    }

    .dropdown-item {
      color: #fff;
      font-family: 'Segoe UI', sans-serif;
      font-weight: bold;
      padding: 8px 16px;
      transition: all 0.2s ease;
    }

    .dropdown-item:hover {
      background-color: #a92709;
      color: #fff;
      padding-left: 20px;
    }

    .dropdown-item i {
      width: 20px;
      text-align: center;
      margin-right: 8px;
    }

    .navbar-nav .nav-item {
      margin-right: -2px;
    }

    /* Nested dropdown support */
    .dropdown-submenu {
      position: relative;
    }

    .dropdown-submenu .dropdown-menu {
      top: 0;
      left: 100%;
      margin-top: -1px;
      margin-left: -1px;
    }

    .notification-badge {
      position: absolute;
      top: 5px;
      right: 5px;
      background-color: #dc3545;
      color: white;
      border-radius: 50%;
      padding: 2px 6px;
      font-size: 0.7rem;
      min-width: 18px;
      height: 18px;
      display: flex;
      align-items: center;
      justify-content: center;
    }

    @media (max-width: 992px) {
      .navbar-custom .nav-link,
      .navbar-custom .dropdown-item,
      .navbar-custom .navbar-brand { font-size: 14px; }
      .dropdown-menu { min-width: auto; width: 100%; border-radius: 0; }
      .navbar-nav { text-align: center; }
      .navbar-nav .nav-item { margin-right: 0; }
      .navbar-brand img { width: 24px; height: 24px; }
      .dropdown-submenu .dropdown-menu {
        position: static;
        left: 0;
        margin-top: 0;
        margin-left: 0;
        box-shadow: none;
        background-color: #a92709;
      }
    }

    .loading-overlay {
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background-color: rgba(0, 0, 0, 0.6);
      display: none;
      justify-content: center;
      align-items: center;
      z-index: 9998;
      backdrop-filter: blur(2px);
    }

    .navbar-toggler-icon {
      background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 30 30'%3e%3cpath stroke='rgba%28255, 255, 255, 1%29' stroke-linecap='round' stroke-miterlimit='10' stroke-width='2' d='M4 7h22M4 15h22M4 23h22'/%3e%3c/svg%3e");
    }

    .user-status {
      display: inline-block;
      width: 8px;
      height: 8px;
      background-color: #28a745;
      border-radius: 50%;
      margin-left: 5px;
    }

	#loginArea .login-username {
	  color: #fff !important;
	  font-weight: 600;
	  max-width: 140px;
	  overflow: hidden;
	  text-overflow: ellipsis;
	}
  </style>
</head>
<body>

<div class="loading-overlay" id="loadingOverlay">
  <div class="loading-spinner text-white text-center">
    <div class="spinner-border" role="status"></div>
    <div class="mt-3">लोड हो रहा है...</div>
  </div>
</div>

<div class="toast-container position-fixed top-0 end-0 p-3" id="toastContainer" style="z-index: 9999;"></div>

<nav class="navbar navbar-expand-lg navbar-custom sticky-top" style="font-weight: bold;">
  <div class="container-fluid">
    <a class="navbar-brand fw-bold d-flex align-items-center" href="/">
      <img src="/images/logo/logo.png" alt="Logo" width="30" height="30" class="d-inline-block align-text-top me-2">
      <span class="d-none d-sm-inline">सनाढ्य ब्राह्मण सभा, कोटा</span>
      <span class="d-inline d-sm-none">सनाढ्य सभा</span>
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarNavDropdown">
      <ul class="navbar-nav ms-auto">

        <li class="nav-item">
          <a class="nav-link" href="/"><i class="fas fa-home d-lg-none me-1"></i>मुख्यपृष्ठ</a>
        </li>

        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">हमारे बारे में</a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="/guidance"><i class="fas fa-hands-helping"></i> मार्गदर्शन</a></li>
            <li><a class="dropdown-item" href="/officials"><i class="fas fa-users-cog"></i> पदाधिकारी</a></li>
            <!--<li><a class="dropdown-item" href="/members"><i class="fas fa-users"></i> समिति सदस्य</a></li>-->
            <li><a class="dropdown-item" href="/smajHistory"><i class="fas fa-history"></i> समाज का इतिहास</a></li>
            <li><a class="dropdown-item" href="/smajUddeshLakshya"><i class="fas fa-eye"></i> उद्देश्य और लक्ष्य</a></li>
<!--            <li><a class="dropdown-item" href="/constitution"><i class="fas fa-scroll"></i> समाज का संविधान</a></li>
-->          </ul>
        </li>

        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">कार्यक्रम</a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="/events"><i class="fas fa-calendar-alt"></i> कार्यक्रम</a></li>
<!--            <li><a class="dropdown-item" href="/events/past"><i class="fas fa-camera"></i> पूर्व कार्यक्रम और फोटो गैलरी</a></li>
-->            <li><a class="dropdown-item" href="/calendar"><i class="fas fa-calendar"></i> वार्षिक कैलेंडर</a></li>
            <li><a class="dropdown-item" href="/festivals"><i class="fas fa-star"></i> पर्व और त्योहार</a></li>
            <li><a class="dropdown-item" href="/youth/programs"><i class="fas fa-graduation-cap"></i> युवाओं के लिए कार्यक्रम</a></li>
            <li><a class="dropdown-item" href="/women/activities"><i class="fas fa-female"></i> महिला समूह की गतिविधियाँ</a></li>
          </ul>
        </li>

        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">वैवाहिक सुविधा</a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="/matrimony/list"><i class="fas fa-search"></i> वर / वधु प्रोफ़ाइल ब्राउज़ करें</a></li>
            <li><a class="dropdown-item" href="/matrimony/add"><i class="fas fa-plus"></i> प्रोफ़ाइल जोड़ें</a></li>
            <li><a class="dropdown-item" href="/matrimony/my-profiles"><i class="fas fa-user-circle"></i> मेरी प्रोफ़ाइलें</a></li>
            <li><a class="dropdown-item" href="/matrimony/privacy"><i class="fas fa-shield-alt"></i> गोपनीयता नीति</a></li>
          </ul>
        </li>

        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">समाज सेवाएँ</a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="/donate"><i class="fas fa-donate"></i> ऑनलाइन दान</a></li>
            <li><a class="dropdown-item" href="/volunteer"><i class="fas fa-hand-holding-heart"></i> स्वयंसेवा</a></li>
            <li><a class="dropdown-item" href="/sponsor"><i class="fas fa-handshake"></i> प्रायोजक</a></li>
            <li><a class="dropdown-item" href="/services/marriage"><i class="fas fa-heart"></i> वैवाहिक सहायता</a></li>
            <li><a class="dropdown-item" href="/services/education"><i class="fas fa-book"></i> शिक्षा एवं छात्रवृत्ति</a></li>
            <li><a class="dropdown-item" href="/services/jobs"><i class="fas fa-briefcase"></i> रोजगार सहायता</a></li>
            <li><a class="dropdown-item" href="/services/health"><i class="fas fa-medkit"></i> स्वास्थ्य शिविर</a></li>
            <li><a class="dropdown-item" href="/services/social"><i class="fas fa-people-carry"></i> सामाजिक सेवा योजनाएँ</a></li>
          </ul>
        </li>

        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">प्रशंसापत्र
            <span class="notification-badge d-none" id="testimonialNotification">0</span>
          </a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="/testimonials"><i class="fas fa-book-open"></i> सदस्यों के विचार देखें</a></li>
            <li id="memberTestimonialOptions " >
              <a class="dropdown-item d-none" href="/member/add-testimonial"><i class="fas fa-pen-alt"></i> नया प्रशंसापत्र जोड़ें</a>
            </li>
            <li id="memberTestimonialViewOptions " >
              <a class="dropdown-item" href="/testimonial/my-testimonials"><i class="fas fa-list-ul"></i> मेरे प्रशंसापत्र</a>
            </li>
            <li><hr class="dropdown-divider d-none" id="testimonialDivider"></li>
          </ul>
        </li>

        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
            <i class="fas fa-building d-lg-none me-1"></i>हॉल / रूम बुकिंग
          </a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="/hall/availability"><i class="fas fa-calendar-check"></i> उपलब्धता जांचें</a></li>
            <li><a class="dropdown-item" href="/hall/booking-form"><i class="fas fa-edit"></i> बुकिंग फॉर्म</a></li>
            <li><a class="dropdown-item" href="/hall/rules"><i class="fas fa-list-alt"></i> शुल्क एवं नियम</a></li>
            <li><a class="dropdown-item" href="/hall/gallery"><i class="fas fa-images"></i> फोटो गैलरी</a></li>
          </ul>
        </li>

        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">हमसे संपर्क करें</a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="/contact/details"><i class="fas fa-address-book"></i> संपर्क विवरण</a></li>
            <li><a class="dropdown-item" href="/contact/enquiry"><i class="fas fa-question-circle"></i> पूछताछ फॉर्म</a></li>
            <li><a class="dropdown-item" href="/contact/map"><i class="fas fa-map-marker-alt"></i> लोकेशन / नक्शा</a></li>
          </ul>
        </li>

        <li class="nav-item dropdown d-none" id="adminArea">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">प्रशासन</a>
          <ul class="dropdown-menu dropdown-menu-end">
            <li><a class="dropdown-item" href="/admin/dashboard"><i class="fas fa-chart-line"></i> डैशबोर्ड</a></li>
			<li><a class="dropdown-item" href="/member/doc/admin"><i class="fas fa-id-card"></i> सदस्य निर्देशिका</a></li>
            <li class="dropdown-submenu dropend">
              <a class="dropdown-item dropdown-toggle" href="#"><i class="fas fa-users-cog"></i> सदस्य प्रबंधन</a>
              <ul class="dropdown-menu">
                <li><a class="dropdown-item" href="/admin/memberList"><i class="fas fa-list-ul"></i> सभी सदस्य</a></li>
                <li><a class="dropdown-item" href="/admin/reset-requests"><i class="fas fa-key"></i> पासवर्ड अनुरोध</a></li>
				<li><a class="dropdown-item" href="/admin/testimonials"><i class="fas fa-tasks"></i> प्रशंसापत्र प्रबंधन</a></li>
               </ul>
            </li>
            <li class="dropdown-submenu dropend">
              <a class="dropdown-item dropdown-toggle" href="#"><i class="fas fa-calendar-plus"></i> कार्यक्रम प्रबंधन</a>
              <ul class="dropdown-menu">
                <li><a class="dropdown-item" href="/admin/events"><i class="fas fa-th-list"></i> सभी कार्यक्रम</a></li>
                <li><a class="dropdown-item" href="/admin/event-form"><i class="fas fa-plus-circle"></i> कार्यक्रम जोड़ें</a></li>
              </ul>
            </li>
            <li><a class="dropdown-item" href="/admin/hall-bookings"><i class="fas fa-hotel"></i> हॉल बुकिंग्स</a></li>
          </ul>
        </li>

		<li class="nav-item dropdown" id="loginArea">
		  <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" id="loginDropdown" data-bs-toggle="dropdown">
		    <i class="fas fa-user-circle me-2"></i>
		    <span class="login-username d-none d-lg-inline">लॉगिन / सदस्यता</span>
		    <span class="user-status d-none ms-2"></span>
		  </a>
		  <ul class="dropdown-menu dropdown-menu-end" id="loginDropdownMenu">
		    <li><a class="dropdown-item" href="#" data-bs-toggle="modal" data-bs-target="#authModal"><i class="fas fa-sign-in-alt"></i> लॉगिन / सदस्य बनें</a></li>
		  </ul>
		</li>

      </ul>
    </div>
  </div>
</nav>

<%@ include file="/WEB-INF/views/includes/auth-popup.jsp" %>

<script>
/* =========================
   AUTH & UI LOGIC
========================= */
function showLoading(message = 'लोड हो रहा है...') {
  const overlay = document.getElementById("loadingOverlay");
  overlay.querySelector('.mt-3').textContent = message;
  overlay.style.display = "flex";
}

function hideLoading() {
  document.getElementById("loadingOverlay").style.display = "none";
}

function showToast(message, type = 'info') {
  const bgClass = type === 'success' ? 'bg-success' : type === 'error' ? 'bg-danger' : 'bg-warning';
  const icon = type === 'success' ? 'fa-check-circle' : 'fa-exclamation-triangle';
  const toastHtml = `
    <div class="toast align-items-center text-white ${bgClass} border-0" role="alert" aria-live="assertive" aria-atomic="true">
      <div class="d-flex">
        <div class="toast-body"><i class="fas ${icon} me-2"></i>${message}</div>
        <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
      </div>
    </div>`;
  const container = document.getElementById('toastContainer');
  container.insertAdjacentHTML('beforeend', toastHtml);
  const toastEl = container.lastElementChild;
  new bootstrap.Toast(toastEl, { delay: 4000 }).show();
}

document.addEventListener("DOMContentLoaded", function () {
  const usernameSpan = document.querySelector('.login-username');
  const statusDot = document.querySelector('.user-status');
  const dropdownMenu = document.getElementById('loginDropdownMenu');
  const adminArea = document.getElementById('adminArea');

  fetch('/api/auth/me', { credentials: 'include' })
    .then(res => res.status === 401 ? null : res.json())
    .then(res => {
      if (res && res.success) {
        const user = res.data;
        usernameSpan.textContent = user.fullName;
        statusDot.classList.remove('d-none');
        dropdownMenu.innerHTML = `
          <li><a class="dropdown-item" href="/member/profile"><i class="fas fa-id-badge"></i> प्रोफ़ाइल</a></li>
          <li><a class="dropdown-item" href="/member/payment"><i class="fas fa-receipt"></i> भुगतान</a></li>
          <li><a class="dropdown-item" href="/member/doc"><i class="fas fa-folder-open"></i> सदस्य निर्देशिका</a></li>
          <li><hr class="dropdown-divider"></li>
          <li><a class="dropdown-item text-danger" href="#" onclick="logout(event)"><i class="fas fa-sign-out-alt"></i> लॉगआउट</a></li>
        `;
        if (user.role === 'ADMIN') adminArea?.classList.remove('d-none');
      }
    });
});

function logout(e) {
  e.preventDefault();
  showLoading('लॉगआउट हो रहे हैं...');
  fetch('/logout', { method: 'POST', credentials: 'include' })
    .then(() => window.location.href = "/")
    .catch(() => { hideLoading(); showToast('त्रुटि हुई', 'error'); });
}

/* Submenu Fix */
document.querySelectorAll('.dropdown-submenu > a').forEach(el => {
  el.addEventListener('click', function (e) {
    e.preventDefault();
    e.stopPropagation();
    this.nextElementSibling?.classList.toggle('show');
  });
});
</script>

</body>
</html> 		