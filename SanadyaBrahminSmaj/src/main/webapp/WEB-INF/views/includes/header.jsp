<%@ page language="java"  contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="hi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <title>सनाढ्य ब्राह्मण सभा</title>
<!-- ✅ Fonts (Devanagari support) -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+Devanagari:wght@600&display=swap" rel="stylesheet">

<!-- ✅ Bootstrap CSS (Latest 5.3) -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- ✅ DataTables CSS -->
<link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
<link rel="stylesheet" href="https://cdn.datatables.net/buttons/2.4.2/css/buttons.dataTables.min.css">

<!-- ✅ jQuery (Only Once, Latest Compatible) -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

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
<script src="https://cdn.jsdelivr.net/npm/bootbox@5.5.2/dist/bootbox.min.js"></script>

  <style>
     body {
            background-color: #fffaf0;
            font-family: 'Segoe UI', 'Noto Sans Devanagari', sans-serif;
        }
    .navbar-custom {
      background: linear-gradient(to right, #f87e03, #b65c02);
      font-family: 'Segoe UI', sans-serif;
      font-weight: bold;
    }

    .navbar-custom .nav-link,
    .navbar-custom .navbar-brand {
      color: #fff;
      padding-left: 8px;
      padding-right: 8px;
    }

    .navbar-custom .nav-link:hover,
    .navbar-custom .dropdown-item:hover {
      color: #000;
      background-color: #ffa600;
    } 

    .dropdown-menu {
      background-color: #b65c02;
      border-radius: 0px;
      /* padding: 0.5rem; */
      /* min-width: 250px; */
      
    }

    .dropdown-item {
      color: #fff;
       font-family: 'Segoe UI', sans-serif;
      font-weight: bold;
    }

    .dropdown-item:hover {
      background-color: #a92709;
    }

    .navbar-nav .nav-item {
      margin-right: -2px;
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
    }

@media (max-width: 576px) {
  .navbar-custom .nav-link,
  .navbar-custom .dropdown-item,
  .navbar-custom .navbar-brand {
    font-size: 16px; /* Increased from 12px */
  }

  .navbar-brand {
    font-size: 18px; /* Increased from 14px */
  }

  .dropdown-menu {
    font-size: 15px; /* Optional: make dropdown more readable */
  }
}
  </style>

</head>
<body>

<nav class="navbar navbar-expand-lg navbar-custom sticky-top shadow-lg">
  <div class="container-fluid">
    <a class="navbar-brand fw-bold" href="#">
      <img src="/images/logo/logo.png" alt="Logo" width="30" height="30" class="d-inline-block align-text-top">
      सनाढ्य ब्राह्मण सभा, कोटा
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarNavDropdown">
      <ul class="navbar-nav ms-auto">

        <li class="nav-item"><a class="nav-link" href="/">🏠मुख्यपृष्ठ</a></li>

        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">हमारे बारे में</a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="/guidance">मार्गदर्शन</a></li>
            <li><a class="dropdown-item" href="/officials">पदाधिकारी</a></li>
            <li><a class="dropdown-item" href="/members">समिति सदस्य</a></li>
            <li><a class="dropdown-item" href="/history">समाज का इतिहास</a></li>
            <li><a class="dropdown-item" href="/vision">उद्देश्य और लक्ष्य</a></li>
            <li><a class="dropdown-item" href="/constitution">समाज का संविधान</a></li>
          
          </ul>
        </li>

        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">कार्यक्रम एवं आयोजन</a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="/events/upcoming">आगामी कार्यक्रम</a></li>
            <li><a class="dropdown-item" href="/events/past">पूर्व कार्यक्रम और फोटो गैलरी</a></li>
            <li><a class="dropdown-item" href="/calendar">वार्षिक कैलेंडर</a></li>
            <li><a class="dropdown-item" href="/festivals">पर्व और त्योहार</a></li>
            <li><a class="dropdown-item" href="/youth/programs">युवाओं के लिए कार्यक्रम</a></li>
            <li><a class="dropdown-item" href="/women/activities">महिला समूह की गतिविधियाँ</a></li>
          </ul>
        </li>

        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">वैवाहिक सुविधा</a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="/matrimony/browse">वर / वधु प्रोफ़ाइल ब्राउज़ करें</a></li>
            <li><a class="dropdown-item" href="/matrimony/add">प्रोफ़ाइल जोड़ें</a></li>
                <li><a class="dropdown-item" href="/matrimony/my-profiles">मेरी प्रोफ़ाइलें</a></li>
            <li><a class="dropdown-item" href="/matrimony/privacy">गोपनीयता और सत्यापन नीति</a></li>
          </ul>
        </li>

        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">समाज सेवाएँ</a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="/donate">ऑनलाइन दान</a></li>
            <li><a class="dropdown-item" href="/volunteer">स्वयंसेवा</a></li>
            <li><a class="dropdown-item" href="/sponsor">प्रायोजक</a></li>
            <li><a class="dropdown-item" href="/services/marriage">वैवाहिक सहायता</a></li>
            <li><a class="dropdown-item" href="/services/education">शिक्षा एवं छात्रवृत्ति</a></li>
            <li><a class="dropdown-item" href="/services/jobs">रोजगार सहायता</a></li>
            <li><a class="dropdown-item" href="/services/health">स्वास्थ्य शिविर</a></li>
            <li><a class="dropdown-item" href="/services/social">सामाजिक सेवा योजनाएँ</a></li>
          </ul>
        </li>

       

        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">हॉल / रूम बुकिंग</a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="/hall/availability">हॉल की उपलब्धता जांचें</a></li>
            <li><a class="dropdown-item" href="/hall/booking-form">बुकिंग फॉर्म</a></li>
            <li><a class="dropdown-item" href="/hall/rules">शुल्क एवं नियम</a></li>
            <li><a class="dropdown-item" href="/hall/gallery">हॉल की फोटो गैलरी</a></li>
          </ul>
        </li>

        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">हमसे संपर्क करें</a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="/contact/details">संपर्क विवरण</a></li>
            <li><a class="dropdown-item" href="/contact/enquiry">पूछताछ फॉर्म</a></li>
            <li><a class="dropdown-item" href="/contact/map">लोकेशन / नक्शा</a></li>
          </ul>
        </li>
        <li class="nav-item dropdown d-none" id="adminArea">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">⚙️ प्रशासन</a>
          <ul class="dropdown-menu dropdown-menu-end">
            <li><a class="dropdown-item" href="/admin/dashboard">📊 डैशबोर्ड</a></li>

            <li class="dropdown-submenu dropend">
              <a class="dropdown-item dropdown-toggle" href="#">👥 सदस्य प्रबंधन</a>
              <ul class="dropdown-menu">
                <li><a class="dropdown-item" href="/admin/memberList">सभी सदस्य</a></li>
                <li><a class="dropdown-item" href="/admin/reset-requests">🔑 पासवर्ड अनुरोध</a></li>

                <li><a class="dropdown-item" href="/admin/registrations">पंजीकरण अनुरोध</a></li>
                <li><a class="dropdown-item" href="/admin/verified">सत्यापित सदस्य</a></li>
              </ul>
            </li>

            <li class="dropdown-submenu dropend">
              <a class="dropdown-item dropdown-toggle" href="#">📅 कार्यक्रम</a>
              <ul class="dropdown-menu">
                <li><a class="dropdown-item" href="/admin/events">सभी कार्यक्रम</a></li>
                <li><a class="dropdown-item" href="/admin/event-form">कार्यक्रम जोड़ें</a></li>
              </ul>
            </li>

            <li><a class="dropdown-item" href="/admin/hall-bookings">🏛️ हॉल बुकिंग्स</a></li>
            <li><a class="dropdown-item" href="/admin/approvals">✅ अनुमोदन</a></li>
          </ul>
        </li>

        <!-- 👤 Login / Member -->
<li class="nav-item dropdown" id="loginArea">
  <a class="nav-link dropdown-toggle" href="#" role="button" id="loginDropdown" data-bs-toggle="dropdown" aria-expanded="false">
    लॉगिन / सदस्यता
  </a>
  <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="loginDropdown" id="loginDropdownMenu">
    <li><a class="dropdown-item" href="#" data-bs-toggle="modal" data-bs-target="#authModal">🔐 लॉगिन / सदस्य बनें</a></li>
    <li><a class="dropdown-item" href="/member/doc">📜 सदस्य निर्देशिका</a></li>
  </ul>
</li>

        
      </ul>
    </div>
  </div>
</nav>
<%@ include file="/WEB-INF/views/includes/auth-popup.jsp" %>
</body>

<!-- 🔧 JS Logic for Auth/Admin Handling -->
<script>
  function isAdminUser(token) {
    try {
      const payload = JSON.parse(atob(token.split('.')[1]));
      return payload && payload.roles && payload.roles.includes('ADMIN');
    } catch (e) {
      console.warn("Invalid token", e);
      return false;
    }
  }

  document.addEventListener("DOMContentLoaded", function () {
    const token = localStorage.getItem("authToken");
    const username = localStorage.getItem("userName") || "प्रयोगकर्ता";
debugger;
    if (token) {
      let usernameStore = "प्रयोगकर्ता";

      try {
        const payload = JSON.parse(atob(token.split('.')[1]));
        usernameStore = payload.username || "प्रयोगकर्ता";
      } catch (e) {
        console.warn("Invalid token", e);
      }

      // Update dropdown button
      const loginDropdown = document.getElementById("loginDropdown");
      loginDropdown.textContent = usernameStore;

      // Update dropdown menu
      const dropdownMenu = document.getElementById("loginDropdownMenu").innerHTML = `
        <li><a class="dropdown-item" href="/member/profile">प्रोफ़ाइल</a></li>
               <li><a class="dropdown-item" href="/member/payment">भुगतान</a></li>
        
        <li><a class="dropdown-item" href="/member/list">सदस्य निर्देशिका</a></li>
        <li><hr class="dropdown-divider"></li>
<li><a class="dropdown-item text-danger" href="#" onclick="handleLogout(event)">लॉगआउट</a></li>
      `;

      if (isAdminUser(token)) {
        document.getElementById("adminArea").classList.remove("d-none");
      }

   
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
function handleLogout(e) {
  if (e) e.preventDefault();
  localStorage.removeItem("authToken");
  localStorage.removeItem("userName");
  window.location.href = "/logout";
}


$(document).ready(function() {
    const token = localStorage.getItem('authToken'); // or your token key

    if (token!=null && isTokenExpired(token)) {
        console.log('Token expired on page load');

        // Clear stored auth data
        localStorage.removeItem('authToken');
        localStorage.removeItem('userName'); // if stored

        // Optionally show alert and redirect to login
        bootbox.alert({
            title: "सेशन समाप्त",
            message: "आपका सेशन समाप्त हो गया है। कृपया पुनः लॉगिन करें।",
            callback: function() {
                window.location.href = "/"; // your login page
            }
        });
    } else {
        console.log('Token valid on page load');
        // You can call a function here to update UI for logged-in user
        // e.g., AuthManager.updateUI({isAuthenticated:true, ...})
    }
});

function isTokenExpired(token) {
    if (!token) return true; // No token means expired/not logged in
    try {
        // Decode the JWT payload (base64)
        const payloadBase64 = token.split('.')[1];
        const decodedPayload = atob(payloadBase64);
        const payload = JSON.parse(decodedPayload);

        // exp is in seconds since epoch
        const currentTime = Math.floor(Date.now() / 1000);

        // Token is expired if current time > exp claim
        return currentTime > payload.exp;
    } catch (e) {
        console.error("JWT decoding failed:", e);
        return true; // Treat as expired if any error occurs
    }
}


</script>

</html>