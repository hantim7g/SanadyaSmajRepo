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
		<div class="container my-4">
		  <h3 class="text-center  page-title mb-3">🏨 उपलब्ध रूम/हॉल/फ्लोर</h3>

		  <div class="row g-4">
			<c:forEach items="${rooms}" var="r">
			  <div class="col-md-4">
			    <div class="room-card position-relative h-100">

			      <!-- PRICE -->
			      <div class="price-badge">
			        ₹${r.basePrice} / रात
			      </div>

			      <!-- FORM START -->
			      <form method="post" action="/bookings/add">

			        <!-- IMAGE -->
			        <img src="/images/${r.images[0].imageUrl}"
			             alt="रूम छवि">

			        <div class="p-3">

			          <h5 class="fw-bold mb-1">
			            ${r.roomTypeLabel}
			          </h5>

			          <p class="mb-1">
			            <strong>रूम:</strong> ${r.roomNumber}
			          </p>

			          <p class="mb-1">
			            <strong>फ्लोर:</strong> ${r.floorLabel}
			          </p>

			          <p class="mb-2">
			            <strong>स्थिति:</strong> ${r.statusLabel}
			          </p>

			          <!-- ===== DATES FROM SEARCH FORM ===== -->
			          <input type="hidden" class='checkInDate'id="checkInDate" name="checkInDate"
			                 value="${param.fromDate}">
			          <input type="hidden" class='checkOutDate' id="checkOutDate" name="checkOutDate"
			                 value="${param.toDate}">

			          <!-- ROOM ID -->
			          <input type="hidden" name="roomId" value="${r.id}">

			          <button type="submit"
			                  class="btn btn-book w-100 mt-2">
			            🛏️ बुक करें
			          </button>

			        </div>
			      </form>
			      <!-- FORM END -->

			    </div>
			  </div>
			</c:forEach>

		  </div>
		</div>

	</body>
	<script>
	function bookRoom(roomId, btn) {

	  const card = btn.closest('.card-body');

	  const checkIn =$('#fromDate').val();
	  const checkOut = $('#toDate').val();
	  $('#toDate').val();
	  $('#toDate').val();

	  if (!checkIn || !checkOut) {
	    bootbox.alert("कृपया चेक-इन और चेक-आउट तिथि चुनें");
	    return;
	  }

	  const url =
	    "/bookings/add"
	    + "?roomId=" + roomId
	    + "&checkInDate=" + checkIn
	    + "&checkOutDate=" + checkOut;

	  window.location.href = url;
	}
	</script>

	</html>