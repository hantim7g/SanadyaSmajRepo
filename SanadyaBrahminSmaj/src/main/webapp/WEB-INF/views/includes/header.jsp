<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="hi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>सनाढ्य ब्राह्मण सभा</title>

  <!-- ✅ Fonts (Devanagari support) -->
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+Devanagari:wght@300;400;600;700&display=swap" rel="stylesheet">

  <!-- ✅ Bootstrap CSS (Latest 5.3) -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

  <!-- ✅ Font Awesome Icons -->
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

  <!-- ✅ DataTables CSS -->
  <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
  <link rel="stylesheet" href="https://cdn.datatables.net/buttons/2.4.2/css/buttons.dataTables.min.css">

  <!-- ✅ jQuery (Only Once, Latest Compatible) -->
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

  <!-- ✅ Bootstrap Bundle JS (includes Popper) -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

  <!-- ✅ DataTables Core & Buttons -->
  <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
  <script src="https://cdn.datatables.net/buttons/2.4.2/js/dataTables.buttons.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.7/pdfmake.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.7/vfs_fonts.js"></script>
  <script src="https://cdn.datatables.net/buttons/2.4.2/js/buttons.html5.min.js"></script>
  <script src="https://cdn.datatables.net/buttons/2.4.2/js/buttons.print.min.js"></script>

  <!-- ✅ Bootbox for Alerts -->
  <script src="https://cdn.jsdelivr.net/npm/bootbox@6.0.0/dist/bootbox.min.js"></script>
<script src="https://cdn.datatables.net/1.13.8/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/responsive/2.5.0/js/dataTables.responsive.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.4.2/js/dataTables.buttons.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.7/pdfmake.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.7/vfs_fonts.js"></script>
<script src="https://cdn.datatables.net/buttons/2.4.2/js/buttons.html5.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.4.2/js/buttons.print.min.js"></script>

  <style>
    body {
      background-color: #fffaf0;
      font-family: 'Segoe UI', 'Noto Sans Devanagari', sans-serif;
    }

    .navbar-custom {
      background: linear-gradient(135deg, #f87e03 0%, #b65c02 100%);
      font-family: 'Segoe UI', sans-serif;
      font-weight: bold;
      box-shadow: 0 2px 4px rgba(0,0,0,0.15);
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

    /* Badge for notifications */
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

    /* Mobile Scaling */
    @media (max-width: 992px) {
      .navbar-custom .nav-link,
      .navbar-custom .dropdown-item,
      .navbar-custom .navbar-brand {
        font-size: 14px;
      }

      .dropdown-menu {
        min-width: auto;
        width: 100%;
        border-radius: 0;
      }

      .navbar-nav {
        text-align: center;
      }

      .navbar-nav .nav-item {
        margin-right: 0;
      }

      .navbar-brand img {
        width: 24px;
        height: 24px;
      }

      .dropdown-submenu .dropdown-menu {
        position: static;
        left: 0;
        margin-top: 0;
        margin-left: 0;
        box-shadow: none;
        background-color: #a92709;
      }
    }

    @media (max-width: 576px) {
      .navbar-custom .nav-link,
      .navbar-custom .dropdown-item,
      .navbar-custom .navbar-brand {
        font-size: 16px;
      }

      .navbar-brand {
        font-size: 18px;
      }

      .dropdown-menu {
        font-size: 15px;
      }
    }

    /* Toast notification styles */
    .toast-container {
      position: fixed;
      top: 20px;
      right: 20px;
      z-index: 9999;
    }

    .toast {
      min-width: 300px;
    }

    /* Loading indicator */
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

    .loading-spinner {
      color: #fff;
      font-size: 2rem;
      text-align: center;
    }

    .loading-spinner .spinner-border {
      width: 3rem;
      height: 3rem;
    }

    /* Navbar toggler custom styling */
    .navbar-toggler {
      border: none;
      padding: 4px 8px;
    }

    .navbar-toggler:focus {
      box-shadow: none;
    }

    .navbar-toggler-icon {
      background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 30 30'%3e%3cpath stroke='rgba%28255, 255, 255, 1%29' stroke-linecap='round' stroke-miterlimit='10' stroke-width='2' d='M4 7h22M4 15h22M4 23h22'/%3e%3c/svg%3e");
    }

    /* Dropdown divider styling */
    .dropdown-divider {
      border-color: rgba(255, 255, 255, 0.2);
      margin: 4px 0;
    }

    /* User status indicator */
    .user-status {
      display: inline-block;
      width: 8px;
      height: 8px;
      background-color: #28a745;
      border-radius: 50%;
      margin-left: 5px;
    }

    /* Accessibility improvements */
    .nav-link:focus,
    .dropdown-item:focus {
      outline: 2px solid #ffc107;
      outline-offset: 2px;
    }
  </style>
</head>
<body>

<!-- Loading Overlay -->
<div class="loading-overlay" id="loadingOverlay">
  <div class="loading-spinner">
    <div class="spinner-border" role="status">
      <span class="visually-hidden">Loading...</span>
    </div>
    <div class="mt-3">
      <div>लोड हो रहा है...</div>
      <div class="mt-1" style="font-size: 0.9rem; opacity: 0.8;">कृपया प्रतीक्षा करें</div>
    </div>
  </div>
</div>

<!-- Toast Container -->
<div class="toast-container" id="toastContainer"></div>

<nav class="navbar navbar-expand-lg navbar-custom sticky-top">
  <div class="container-fluid">
    <a class="navbar-brand fw-bold d-flex align-items-center" href="/">
      <img src="/images/logo/logo.png" alt="Logo" width="30" height="30" class="d-inline-block align-text-top me-2">
      <span class="d-none d-sm-inline">सनाढ्य ब्राह्मण सभा, कोटा</span>
      <span class="d-inline d-sm-none">सनाढ्य सभा</span>
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarNavDropdown">
      <ul class="navbar-nav ms-auto">

        <li class="nav-item">
          <a class="nav-link" href="/" aria-label="मुख्यपृष्ठ">
            <span class="d-none d-lg-inline">मुख्यपृष्ठ</span>
          </a>
        </li>

        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            हमारे बारे में
          </a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="/guidance"> मार्गदर्शन</a></li>
            <li><a class="dropdown-item" href="/officials"><i class="fas fa-users-cog"></i> पदाधिकारी</a></li>
            <li><a class="dropdown-item" href="/members"><i class="fas fa-users"></i> समिति सदस्य</a></li>
            <li><a class="dropdown-item" href="/history"><i class="fas fa-history"></i> समाज का इतिहास</a></li>
            <li><a class="dropdown-item" href="/vision"><i class="fas fa-eye"></i> उद्देश्य और लक्ष्य</a></li>
            <li><a class="dropdown-item" href="/constitution"><i class="fas fa-scroll"></i> समाज का संविधान</a></li>
          </ul>
        </li>

        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            कार्यक्रम एवं आयोजन
          </a>
          <ul class="dropdown-menu">
            <!-- <li><a class="dropdown-item" href="/events/upcoming"><i class="fas fa-clock"></i> आगामी कार्यक्रम</a></li> -->
                       <li><a class="dropdown-item" href="/events"><i class="fas fa-clock"></i>कार्यक्रम</a></li>
           
            <li><a class="dropdown-item" href="/events/past"><i class="fas fa-camera"></i> पूर्व कार्यक्रम और फोटो गैलरी</a></li>
            <li><a class="dropdown-item" href="/calendar"><i class="fas fa-calendar"></i> वार्षिक कैलेंडर</a></li>
            <li><a class="dropdown-item" href="/festivals"><i class="fas fa-star"></i> पर्व और त्योहार</a></li>
            <li><a class="dropdown-item" href="/youth/programs"><i class="fas fa-graduation-cap"></i> युवाओं के लिए कार्यक्रम</a></li>
            <li><a class="dropdown-item" href="/women/activities"><i class="fas fa-female"></i> महिला समूह की गतिविधियाँ</a></li>
          </ul>
        </li>

        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            वैवाहिक सुविधा
          </a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="/matrimony/browse"><i class="fas fa-search"></i> वर / वधु प्रोफ़ाइल ब्राउज़ करें</a></li>
            <li><a class="dropdown-item" href="/matrimony/add"><i class="fas fa-plus"></i> प्रोफ़ाइल जोड़ें</a></li>
            <li><a class="dropdown-item" href="/matrimony/my-profiles"><i class="fas fa-user-circle"></i> मेरी प्रोफ़ाइलें</a></li>
            <li><a class="dropdown-item" href="/matrimony/privacy"><i class="fas fa-shield-alt"></i> गोपनीयता और सत्यापन नीति</a></li>
          </ul>
        </li>

        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
           समाज सेवाएँ
          </a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="/donate"><i class="fas fa-donate"></i> ऑनलाइन दान</a></li>
            <li><a class="dropdown-item" href="/volunteer"><i class="fas fa-hand-holding-heart"></i> स्वयंसेवा</a></li>
            <li><a class="dropdown-item" href="/sponsor"><i class="fas fa-handshake"></i> प्रायोजक</a></li>
            <li><a class="dropdown-item" href="/services/marriage"><i class="fas fa-rings-wedding"></i> वैवाहिक सहायता</a></li>
            <li><a class="dropdown-item" href="/services/education"><i class="fas fa-book"></i> शिक्षा एवं छात्रवृत्ति</a></li>
            <li><a class="dropdown-item" href="/services/jobs"><i class="fas fa-briefcase"></i> रोजगार सहायता</a></li>
            <li><a class="dropdown-item" href="/services/health"><i class="fas fa-medkit"></i> स्वास्थ्य शिविर</a></li>
            <li><a class="dropdown-item" href="/services/social"><i class="fas fa-people-carry"></i> सामाजिक सेवा योजनाएँ</a></li>
          </ul>
        </li>

        <!-- ✅ ENHANCED TESTIMONIAL MENU -->
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle position-relative" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            <i class="fas fa-quote-left"></i> प्रशंसापत्र
            <span class="notification-badge d-none" id="testimonialNotification">0</span>
          </a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="/testimonials"><i class="fas fa-book-open"></i> सदस्यों के विचार देखें</a></li>
            
            <!-- Member Options (shown when authenticated) -->
            <li id="memberTestimonialOptions" class="d-none">
              <a class="dropdown-item" href="/member/add-testimonial"><i class="fas fa-pen-alt"></i> नया प्रशंसापत्र जोड़ें</a>
            </li>
            <li id="memberTestimonialViewOptions" class="d-none">
              <a class="dropdown-item" href="/testimonial/my-testimonials"><i class="fas fa-list-ul"></i> मेरे प्रशंसापत्र देखें</a>
            </li>
            
            <li><hr class="dropdown-divider d-none" id="testimonialDivider"></li>
            
            <!-- Admin Options (shown when admin) -->
            <li id="adminTestimonialOptions" class="d-none">
              <a class="dropdown-item position-relative" href="/admin/testimonials">
                <i class="fas fa-cogs"></i> प्रशंसापत्र प्रबंधन
                <span class="notification-badge d-none" id="adminTestimonialCount">0</span>
              </a>
            </li>
          </ul>
        </li>

        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            <i class="fas fa-building"></i> हॉल / रूम बुकिंग
          </a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="/hall/availability"><i class="fas fa-calendar-check"></i> हॉल की उपलब्धता जांचें</a></li>
            <li><a class="dropdown-item" href="/hall/booking-form"><i class="fas fa-edit"></i> बुकिंग फॉर्म</a></li>
            <li><a class="dropdown-item" href="/hall/rules"><i class="fas fa-list-alt"></i> शुल्क एवं नियम</a></li>
            <li><a class="dropdown-item" href="/hall/gallery"><i class="fas fa-images"></i> हॉल की फोटो गैलरी</a></li>
          </ul>
        </li>

        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            <i class="fas fa-envelope"></i> हमसे संपर्क करें
          </a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="/contact/details"><i class="fas fa-address-book"></i> संपर्क विवरण</a></li>
            <li><a class="dropdown-item" href="/contact/enquiry"><i class="fas fa-question-circle"></i> पूछताछ फॉर्म</a></li>
            <li><a class="dropdown-item" href="/contact/map"><i class="fas fa-map-marker-alt"></i> लोकेशन / नक्शा</a></li>
          </ul>
        </li>

        <li class="nav-item dropdown d-none" id="adminArea">
          <a class="nav-link dropdown-toggle position-relative" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            <i class="fas fa-cog"></i> प्रशासन
            <span class="notification-badge d-none" id="adminNotification">0</span>
          </a>
          <ul class="dropdown-menu dropdown-menu-end">
            <li><a class="dropdown-item" href="/admin/dashboard"><i class="fas fa-chart-bar"></i> डैशबोर्ड</a></li>

            <li class="dropdown-submenu dropend">
              <a class="dropdown-item dropdown-toggle" href="#"><i class="fas fa-users"></i> सदस्य प्रबंधन</a>
              <ul class="dropdown-menu">
                <li><a class="dropdown-item" href="/admin/memberList"><i class="fas fa-list"></i> सभी सदस्य</a></li>
                <li><a class="dropdown-item" href="/admin/reset-requests"><i class="fas fa-key"></i> पासवर्ड अनुरोध</a></li>
               </ul>
            </li>

            <li class="dropdown-submenu dropend">
              <a class="dropdown-item dropdown-toggle" href="#"><i class="fas fa-calendar"></i> कार्यक्रम</a>
              <ul class="dropdown-menu">
                <li><a class="dropdown-item" href="/admin/events"><i class="fas fa-list"></i> सभी कार्यक्रम</a></li>
                <li><a class="dropdown-item" href="/admin/event-form"><i class="fas fa-plus"></i> कार्यक्रम जोड़ें</a></li>
              </ul>
            </li>

            <li><a class="dropdown-item" href="/admin/hall-bookings"><i class="fas fa-building"></i> हॉल बुकिंग्स</a></li>
            <li><a class="dropdown-item" href="/admin/approvals"><i class="fas fa-check"></i> अनुमोदन</a></li>
          </ul>
        </li>

        <!-- 👤 Login / Member -->
        <li class="nav-item dropdown" id="loginArea">
          <a class="nav-link dropdown-toggle position-relative" href="#" role="button" id="loginDropdown" data-bs-toggle="dropdown" aria-expanded="false">
            <i class="fas fa-user"></i> 
            <span class="d-none d-lg-inline">लॉगिन / सदस्यता</span>
            <span class="user-status d-none" id="userOnlineStatus"></span>
          </a>
          <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="loginDropdown" id="loginDropdownMenu">
            <li><a class="dropdown-item" href="#" data-bs-toggle="modal" data-bs-target="#authModal"><i class="fas fa-sign-in-alt"></i> लॉगिन / सदस्य बनें</a></li>
            <li><a class="dropdown-item" href="/member/doc"><i class="fas fa-address-book"></i> सदस्य निर्देशिका</a></li>
          </ul>
        </li>

      </ul>
    </div>
  </div>
</nav>

<%@ include file="/WEB-INF/views/includes/auth-popup.jsp" %>

<!-- 🔧 Enhanced JS Logic for Auth/Admin/Testimonial Handling -->
<script>
  // Global variables
  let currentUser = null;
  let testimonialNotificationCount = 0;
  let adminNotificationCount = 0;

  // Utility Functions
  function showLoading(message = 'लोड हो रहा है...') {
    const overlay = document.getElementById("loadingOverlay");
    const messageDiv = overlay.querySelector('.loading-spinner div:last-child div:first-child');
    if (messageDiv) messageDiv.textContent = message;
    overlay.style.display = "flex";
  }

  function hideLoading() {
    document.getElementById("loadingOverlay").style.display = "none";
  }

  function showToast(message, type = 'info', duration = 5000) {
    const toastContainer = document.getElementById('toastContainer');
    const toastId = 'toast-' + Date.now();
    
    const bgClass = type === 'success' ? 'bg-success' : 
                   type === 'error' ? 'bg-danger' : 
                   type === 'warning' ? 'bg-warning' : 'bg-info';
    
    const iconClass = type === 'success' ? 'fa-check-circle' :
                     type === 'error' ? 'fa-exclamation-triangle' :
                     type === 'warning' ? 'fa-exclamation-circle' : 'fa-info-circle';
    
    const toast = document.createElement('div');
    toast.id = toastId;
    toast.className = `toast align-items-center text-white ${bgClass} border-0`;
    toast.setAttribute('role', 'alert');
    toast.setAttribute('aria-live', 'assertive');
    toast.setAttribute('aria-atomic', 'true');
    
    toast.innerHTML = `
      <div class="d-flex">
        <div class="toast-body">
          <i class="fas ${iconClass} me-2"></i>${message}
        </div>
        <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
      </div>
    `;
    
    toastContainer.appendChild(toast);
    
    const bsToast = new bootstrap.Toast(toast, { delay: duration });
    bsToast.show();
    
    // Auto remove after toast is hidden
    toast.addEventListener('hidden.bs.toast', () => {
      toast.remove();
    });
  }

  function isAdminUser(token) {
    try {
      const payload = JSON.parse(atob(token.split('.')[1]));
      return payload && payload.roles && payload.roles.includes('ADMIN');
    } catch (e) {
      console.warn("Invalid token", e);
      return false;
    }
  }

  function isTokenExpired(token) {
    if (!token) return true;
    try {
      const payloadBase64 = token.split('.')[1];
      const decodedPayload = atob(payloadBase64);
      const payload = JSON.parse(decodedPayload);
      const currentTime = Math.floor(Date.now() / 1000);
      return currentTime > payload.exp;
    } catch (e) {
      console.error("JWT decoding failed:", e);
      return true;
    }
  }

  function getUserFromToken(token) {
    try {
      const payload = JSON.parse(atob(token.split('.')[1]));
      return {
        username: payload.username || payload.sub,
        roles: payload.roles || [],
        exp: payload.exp
      };
    } catch (e) {
      console.error("Error parsing token:", e);
      return null;
    }
  }

  function updateNotificationBadge(elementId, count) {
    const badge = document.getElementById(elementId);
    if (badge) {
      if (count > 0) {
        badge.textContent = count > 99 ? '99+' : count;
        badge.classList.remove('d-none');
      } else {
        badge.classList.add('d-none');
      }
    }
  }

  function fetchNotificationCounts() {
    const token = localStorage.getItem('authToken');
    if (!token || !isAdminUser(token)) return;

    // Fetch pending testimonials count for admin
    $.ajax({
      url: '/api/admin/testimonials/pending/count',
      type: 'GET',
      headers: {
        'Authorization': 'Bearer ' + token
      },
      success: function(data) {
        testimonialNotificationCount = data.count || 0;
        updateNotificationBadge('testimonialNotification', testimonialNotificationCount);
        updateNotificationBadge('adminTestimonialCount', testimonialNotificationCount);
        
        // Update total admin notifications
        adminNotificationCount = testimonialNotificationCount; // Add other notification types here
        updateNotificationBadge('adminNotification', adminNotificationCount);
      },
      error: function(xhr) {
        if (xhr.status !== 404) {
          console.warn('Could not fetch notification counts');
        }
      }
    });
  }

  function handleLogout(e) {
    if (e) e.preventDefault();
    
    showLoading('लॉगआउट हो रहे हैं...');
    
    // Clear local storage
    localStorage.removeItem("authToken");
    localStorage.removeItem("userName");
    currentUser = null;
    
    // Make logout request to backend
    fetch('/logout', {
      method: 'GET',
      credentials: 'include'
    }).then(() => {
      hideLoading();
      showToast('सफलतापूर्वक लॉगआउट हो गए।', 'success');
      setTimeout(() => {
        window.location.href = "/";
      }, 1000);
    }).catch(error => {
      console.error('Logout error:', error);
      hideLoading();
      showToast('लॉगआउट में त्रुटि हुई।', 'error');
      setTimeout(() => {
        window.location.href = "/";
      }, 2000);
    });
  }

  // Authentication Management
  document.addEventListener("DOMContentLoaded", function () {
    const token = localStorage.getItem("authToken");
    const username = localStorage.getItem("userName") || "प्रयोगकर्ता";

    // Check token expiry on page load
    if (token && isTokenExpired(token)) {
      console.log('Token expired on page load');
      localStorage.removeItem('authToken');
      localStorage.removeItem('userName');
      currentUser = null;
      
      showToast('आपका सेशन समाप्त हो गया है। कृपया पुनः लॉगिन करें।', 'warning');
      return;
    }

    if (token) {
      currentUser = getUserFromToken(token);
      let usernameStore = currentUser ? currentUser.username : "प्रयोगकर्ता";

      // Update dropdown button
      const loginDropdown = document.getElementById("loginDropdown");
      loginDropdown.innerHTML = `
        <i class="fas fa-user-circle"></i> 
        <span class="d-none d-lg-inline">${usernameStore}</span>
        <span class="user-status" id="userOnlineStatus"></span>
      `;

      // Update dropdown menu
      document.getElementById("loginDropdownMenu").innerHTML = `
        <li><h6 class="dropdown-header"><i class="fas fa-user"></i> ${usernameStore}</h6></li>
        <li><hr class="dropdown-divider"></li>
        <li><a class="dropdown-item" href="/member/profile"><i class="fas fa-id-card"></i> प्रोफ़ाइल</a></li>
        <li><a class="dropdown-item" href="/member/payment"><i class="fas fa-credit-card"></i> भुगतान</a></li>
        <li><a class="dropdown-item" href="/testimonial/my-testimonials"><i class="fas fa-quote-right"></i> मेरे प्रशंसापत्र</a></li>
        <li><a class="dropdown-item" href="/member/list"><i class="fas fa-list"></i> सदस्य निर्देशिका</a></li>
        <li><hr class="dropdown-divider"></li>
        <li><a class="dropdown-item text-danger" href="#" onclick="handleLogout(event)"><i class="fas fa-sign-out-alt"></i> लॉगआउट</a></li>
      `;

      // ✅ Show member testimonial options for authenticated users
      document.getElementById("memberTestimonialOptions").classList.remove("d-none");
      document.getElementById("memberTestimonialViewOptions").classList.remove("d-none");
      document.getElementById("testimonialDivider").classList.remove("d-none");

      // ✅ Show admin areas for admin users
      if (isAdminUser(token)) {
        document.getElementById("adminArea").classList.remove("d-none");
        document.getElementById("adminTestimonialOptions").classList.remove("d-none");
        
        // Fetch notification counts for admin
      //  fetchNotificationCounts();
        
        // Set up periodic notification updates
       // setInterval(fetchNotificationCounts, 30000); // Update every 30 seconds
      }

      // Show online status
      document.getElementById("userOnlineStatus").classList.remove("d-none");
    }
  });

  // Handle nested dropdown toggle
  document.addEventListener('DOMContentLoaded', function () {
    document.querySelectorAll('.dropdown-submenu > a').forEach(function (element) {
      element.addEventListener('click', function (e) {
        e.preventDefault();
        e.stopPropagation();
        let submenu = this.nextElementSibling;
        if (submenu && submenu.classList.contains('dropdown-menu')) {
          submenu.classList.toggle('show');
        }
      });
    });

    // Hide all nested when main dropdown closes
    document.querySelectorAll('.dropdown').forEach(function (dropdown) {
      dropdown.addEventListener('hide.bs.dropdown', function () {
        this.querySelectorAll('.dropdown-menu.show').forEach(function (submenu) {
          submenu.classList.remove('show');
        });
      });
    });
  });

  // Token expiry check on page load
  $(document).ready(function() {
    const token = localStorage.getItem('authToken');

    if (token != null && isTokenExpired(token)) {
      console.log('Token expired on page load');
      localStorage.removeItem('authToken');
      localStorage.removeItem('userName');
      currentUser = null;
      
      bootbox.alert({
        title: "सेशन समाप्त",
        message: "आपका सेशन समाप्त हो गया है। कृपया पुनः लॉगिन करें।",
        callback: function() {
          window.location.href = "/";
        }
      });
    } else if (token) {
      console.log('Token valid on page load');
    }
  });

  // Global error handler for AJAX requests
  $(document).ajaxError(function(event, xhr, settings, thrownError) {
    if (xhr.status === 401) {
      showToast('आपका सेशन समाप्त हो गया है। कृपया पुनः लॉगिन करें।', 'error');
      localStorage.removeItem('authToken');
      localStorage.removeItem('userName');
      currentUser = null;
      setTimeout(() => {
        window.location.href = '/';
      }, 2000);
    } else if (xhr.status === 403) {
      showToast('आपको इस कार्य की अनुमति नहीं है।', 'error');
    } else if (xhr.status >= 500) {
      showToast('सर्वर में त्रुटि हुई है। कृपया बाद में पुनः प्रयास करें।', 'error');
    }
  });

  // Add authorization header to all AJAX requests
  $.ajaxSetup({
    beforeSend: function(xhr) {
      const token = localStorage.getItem('authToken');
      if (token) {
        xhr.setRequestHeader('Authorization', 'Bearer ' + token);
      }
    }
  });

  // Keyboard navigation support
  document.addEventListener('keydown', function(e) {
    if (e.key === 'Escape') {
      // Close all open dropdowns
      document.querySelectorAll('.dropdown-menu.show').forEach(function(menu) {
        bootstrap.Dropdown.getInstance(menu.previousElementSibling)?.hide();
      });
    }
  });

  // Add click tracking for analytics (optional)
  document.addEventListener('click', function(e) {
    if (e.target.classList.contains('dropdown-item')) {
      const action = e.target.textContent.trim();
      const href = e.target.getAttribute('href');
      console.log('Navigation:', { action, href });
      // Send to analytics service if needed
    }
  });

  // Network status monitoring
  window.addEventListener('online', function() {
    showToast('इंटरनेट कनेक्शन बहाल हो गया।', 'success');
  });

  window.addEventListener('offline', function() {
    showToast('इंटरनेट कनेक्शन बंद हो गया।', 'warning');
  });
</script>

</body>
</html>
