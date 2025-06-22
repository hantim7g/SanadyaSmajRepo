<%@ page language="java"  contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="hi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <title>सनाढ्य ब्राह्मण सभा</title>

  <!-- Bootstrap 5 CDN -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>


    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <!-- Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+Devanagari:wght@600&display=swap" rel="stylesheet">



  <style>
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
        font-size: 12px;
      }

      .navbar-brand {
        font-size: 14px;
      }

      .dropdown-menu {
        font-size: 12px;
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

</html>
<script>
  document.addEventListener("DOMContentLoaded", function () {
    const token = localStorage.getItem("authToken");
     const usernameStore = localStorage.getItem("userName");

    if (token) {
      let userName = "प्रयोगकर्ता";

      try {
        const payload = JSON.parse(atob(token.split('.')[1]));
        userName = usernameStore  || "प्रयोगकर्ता";
      } catch (e) {
        console.warn("Invalid token", e);
      }

      // Update dropdown button
      const loginDropdown = document.getElementById("loginDropdown");
      loginDropdown.textContent = userName;

      // Update dropdown menu
      const dropdownMenu = document.getElementById("loginDropdownMenu");
      dropdownMenu.innerHTML = `
        <li><a class="dropdown-item" href="/member/profile">👤 प्रोफ़ाइल देखें</a></li>
        <li><a class="dropdown-item" href="/member/list">📜 सदस्य निर्देशिका</a></li>
        <li><hr class="dropdown-divider"></li>
        <li><a class="dropdown-item text-danger" href="/api/auth/logout" id="logoutBtn">🚪 लॉगआउट</a></li>
      `;

      // Logout logic
      document.addEventListener("click", function (e) {
        if (e.target && e.target.id === "logoutBtn") {
          localStorage.removeItem("authToken");
          location.reload();
        }
      });
    }
  });
</script>
