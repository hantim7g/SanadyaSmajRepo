<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- Bootstrap & jQuery -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<style>
  body {
    font-size: 16px;
    transition: all 0.3s ease;
  }

  .font-small { font-size: 14px !important; }
  .font-medium { font-size: 16px !important; }
  .font-large { font-size: 18px !important; }

  /* Dark mode */
  body.dark-mode {
    background-color: #121212;
    color: #e0e0e0;
  }

  body.dark-mode .navbar {
    background-color: #1f1f1f;
  }

  .theme-primary { --bs-primary: #0d6efd; }
  .theme-success { --bs-primary: #198754; }
  .theme-warning { --bs-primary: #ffc107; }

  .notification-icon {
    position: relative;
  }

  .notification-icon .badge {
    position: absolute;
    top: -6px;
    right: -6px;
  }
</style>

<!-- Header Navbar -->
<nav class="navbar navbar-expand-lg bg-light shadow-sm px-3">
  <a class="navbar-brand" href="#"><strong>🌐 MySite</strong></a>

  <div class="ms-auto d-flex align-items-center gap-2">

    <!-- 🔔 Notification Bell -->
    <div class="notification-icon">
      <button class="btn btn-outline-secondary btn-sm" id="notificationBtn" title="Notifications">
        🔔
      </button>
      <span class="badge bg-danger rounded-circle" id="notificationCount">3</span>
    </div>

    <!-- 🌐 Language -->
    <button id="toggleLang" class="btn btn-outline-primary btn-sm">🌐 हिन्दी</button>

    <!-- 🔠 Font Size -->
    <div class="btn-group" role="group">
      <button class="btn btn-outline-secondary btn-sm" onclick="changeFontSize('small')">A-</button>
      <button class="btn btn-outline-secondary btn-sm" onclick="changeFontSize('medium')">A</button>
      <button class="btn btn-outline-secondary btn-sm" onclick="changeFontSize('large')">A+</button>
    </div>

    <!-- 🌙 Dark Mode -->
    <button id="toggleDark" class="btn btn-outline-dark btn-sm">🌙</button>

    <!-- 🗣️ Text-to-Speech -->
    <button id="speakBtn" class="btn btn-outline-success btn-sm">🗣️ Speak</button>

    <!-- 🎨 Theme Color -->
    <select id="themeSelector" class="form-select form-select-sm" style="width: auto;">
      <option value="primary">Primary</option>
      <option value="success">Success</option>
      <option value="warning">Warning</option>
    </select>
  </div>
</nav>

<!-- Script Section -->
<script>
  // Font size handling
  function changeFontSize(size) {
    $('body').removeClass('font-small font-medium font-large').addClass('font-' + size);
    localStorage.setItem('fontSize', size);
  }

  // Language toggle
  $('#toggleLang').click(function () {
    const current = $(this).text().trim();
    const newLang = current.includes('हिन्दी') ? 'hi' : 'en';
    $('html').attr('lang', newLang);
    $(this).text(newLang === 'hi' ? '🌐 English' : '🌐 हिन्दी');
    localStorage.setItem('language', newLang);
  });

  // Dark mode toggle
  $('#toggleDark').click(function () {
    $('body').toggleClass('dark-mode');
    localStorage.setItem('darkMode', $('body').hasClass('dark-mode') ? 'yes' : 'no');
  });

  // Text-to-speech
  $('#speakBtn').click(function () {
    let text = window.getSelection().toString() || $('body').text().trim();
    const speech = new SpeechSynthesisUtterance(text);
    window.speechSynthesis.speak(speech);
  });

  // Theme switcher
  $('#themeSelector').change(function () {
    const selected = $(this).val();
    $('body').removeClass('theme-primary theme-success theme-warning').addClass('theme-' + selected);
    localStorage.setItem('themeColor', selected);
  });

  // Load saved preferences
  $(function () {
    const fontSize = localStorage.getItem('fontSize') || 'medium';
    const language = localStorage.getItem('language') || 'en';
    const darkMode = localStorage.getItem('darkMode') === 'yes';
    const themeColor = localStorage.getItem('themeColor') || 'primary';

    changeFontSize(fontSize);
    $('#toggleLang').text(language === 'hi' ? '🌐 English' : '🌐 हिन्दी');
    $('html').attr('lang', language);
    if (darkMode) $('body').addClass('dark-mode');
    $('body').addClass('theme-' + themeColor);
    $('#themeSelector').val(themeColor);
  });

  // Simulate clearing notifications
  $('#notificationBtn').click(function () {
    $('#notificationCount').fadeOut();
    alert("You have 3 new messages!");
  });
</script>
