<%@ include file="/WEB-INF/views/includes/header.jsp" %>

  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
      <!DOCTYPE html>
      <html lang="hi">

      <head>
        <meta charset="UTF-8">
        <title>यूज़र कार्ड सूची</title>


        <!-- Custom Styles -->
        <style>
          body {
            background: #fffaf4;
			
            font-family: 'Segoe UI', 'Noto Sans Devanagari', sans-serif;
          }

          .main-width {
            max-width: 1200px;
            margin: auto;
          }

          .filter-form {
            background: linear-gradient(93deg, #fff7ed 70%, #fffbe9 100%);
            border-radius: 14px;
            box-shadow: 0 1px 8px 0 #edd1aeb2;
            padding: 1.2rem 1.1rem 0.5rem;
            margin-bottom: 2.2rem;
          }

          .profile-card {
            background: linear-gradient(93deg, #ffedc2 65%, #fca854 100%);
            box-shadow: 0 2px 16px rgba(160, 128, 32, 0.08), 0 2px 6px rgba(240, 180, 80, 0.11);
            border-radius: 18px;
            margin-bottom: 30px;
            padding: 18px 25px 14px 25px;
            transition: transform 0.18s cubic-bezier(.43, .03, .44, 1.37),
              box-shadow 0.21s cubic-bezier(.5, .1, .2, .99);
            border: none;
            max-width: 1080px;
            margin-left: auto;
            margin-right: auto;
            position: relative;
          }

          .profile-card:hover {
            transform: translateY(-6px) scale(1.012);
            box-shadow: 0 16px 32px rgba(160, 128, 40, 0.11), 0 5px 18px rgba(230, 160, 40, 0.10);
            background: linear-gradient(87deg, #fff8e3 70%, #ffaa56 97%);
          }

          .name-banner {
            font-size: 1.7rem;
            font-weight: 800;
            color: #5e3400;
            margin-bottom: 11px;
            margin-left: 6px;
            border-bottom: 2px solid #e7c089;
            letter-spacing: .03em;
            word-break: break-word;
            padding-bottom: 3px;
          }

          .profile-img {
            width: 120px;
            height: 120px;
            object-fit: cover;
            border-radius: 50%;
            border: 3px solid #fff9ce;
            box-shadow: 0 1px 7px #dba2362e;
          }

          .filedt,
          .profile-card .field-label {
            color: #512f07;
            font-weight: 600;
            font-size: 1.08rem;
            letter-spacing: .01em;
          }

          .profile-card .badge {
            border-radius: 1.2em;
            padding: 0.37em 0.99em 0.35em 0.99em;
            font-weight: 600;
            letter-spacing: .01em;
            font-size: .97em;
          }

          .profile-card .btnn,
          .profile-card .btn {
            background: linear-gradient(95deg, #0ca100 60%, #32d653 100%);
            color: #fff;
            font-size: .97rem;
            border-radius: 8px;
            font-weight: 700;
            border: none;
            box-shadow: 0 0px 7px #b5e5b8ad;
            transition: background .15s;
          }

          .profile-card .btn-outline-success {
            background: none;
            color: #1b801a;
            border: 2px solid #44d842;
            box-shadow: none;
          }

          .profile-card .btn-outline-danger {
            background: none;
            color: #be1800 !important;
            border: 2px solid #fd9c88;
          }

          .profile-card .btn-outline-info {
            background: none;
            color: #007795 !important;
            border: 2px solid #5edcf9;
          }

          .profile-card .btnn:hover,
          .profile-card .btn:hover {
            background: #079610 !important;
            color: #fff !important;
            border-color: #1e9e26;
            box-shadow: 0 1px 8px 0 #8be29670;
            transform: scale(1.03);
          }

          @media (max-width: 960px) {

            .main-width,
            .profile-card {
              max-width: 99vw;
            }

            .profile-card {
              padding: 13px 4vw 10px 4vw;
            }
          }

          @media (max-width: 730px) {
            .profile-card {
              padding: 8px 2vw 9px 2vw;
            }

            .profile-img {
              width: 90px;
              height: 90px;
            }
          }

          @media (max-width: 550px) {
            .profile-card {
              padding: 9px 0vw 9px 1vw;
            }

            .profile-img {
              width: 68px;
              height: 68px;
            }

            .name-banner {
              font-size: 1.22rem;
            }
          }
		  /* 🌸 Society Role Dropdown - Premium Style */
		  .smaj-role-wrapper {
		    position: relative;
		    max-width: 260px;
		  }

		  .smaj-role-label {
		    font-weight: bold;
		    color: #6b3a00;
		    margin-bottom: 4px;
		 
		    }

		  .smaj-role-select {
		    appearance: none;
		    -webkit-appearance: none;
		    -moz-appearance: none;
		    background: linear-gradient(92deg, #fff3cf 60%, #ffd28a 100%);
		    border: 2px solid #f1c37a;
		    border-radius: 12px;
		    padding: 7px 38px 7px 14px;
		    font-weight: 700;
		    color: #5a3200;
		    box-shadow: 0 2px 8px rgba(200, 150, 60, 0.25);
		    transition: all 0.2s ease;
		    cursor: pointer;
		  }

		  .smaj-role-select:hover {
		    background: linear-gradient(92deg, #fff8e6 60%, #ffbe5c 100%);
		    border-color: #e3a647;
		  }

		  .smaj-role-select:focus {
		    outline: none;
		    border-color: #d08a2d;
		    box-shadow: 0 0 0 0.18rem rgba(255, 170, 70, 0.35);
		  }

		  /* 🔽 Custom Arrow */
		  .smaj-role-wrapper::after {
		    content: "▾";
		    position: absolute;
		    right: 14px;
		    top: 38px;
		    font-size: 1.2rem;
		    color: #8a4a00;
		    pointer-events: none;
		  }

		  /* 🎖 Selected Role Badge Look */
		  .smaj-role-badge {
		    display: inline-block;
		    margin-top: 6px;
		    background: linear-gradient(90deg, #ffd27a, #ffae42);
		    color: #5b2d00;
		    font-weight: 800;
		    border-radius: 20px;
		    padding: 4px 14px;
		    font-size: 0.85rem;
		    box-shadow: 0 1px 6px rgba(180, 120, 20, 0.35);
		  }

        </style>
      </head>

      <body>
        <div class="container my-4">
          <h2 class="mb-4 text-center">यूज़र प्रोफाइल कार्ड</h2>

          <!-- 🔍 Filter Form -->
          <!-- Replace Filter Form in memberListAdmin.jsp -->
          <form id="filterForm" class="mb-4 filter-form">
            <div class="row g-2">
              <div class="col-md-3">
                <input type="text" class="form-control" name="name" placeholder="नाम से खोजें">
              </div>
              <div class="col-md-3">
                <input type="text" class="form-control" name="mobile" placeholder="mobile">
              </div>
              <div class="col-md-2">
                <select name="approved" class="form-select">
                  <option value="">प्रोफाइल स्थिति</option>
                  <option value="स्वीकृत">स्वीकृत</option>
                  <option value="प्रक्रिया में">प्रक्रिया में</option>
                  <option value="अस्वीकृत">अस्वीकृत</option>

                </select>
              </div>
              <div class="col-md-2">
                <select name="annualFeeStatus" class="form-select">
                  <option value="">वार्षिक शुल्क स्थिति</option>
                  <option value="प्रतीक्षारत">प्रतीक्षारत</option>
                  <option value="सत्यापित/प्रक्रिया में">सत्यापित/प्रक्रिया में</option>
                  <option value="अस्वीकृत">अस्वीकृत</option>
                </select>
              </div>
              <div class="col-md-2">
                <select  class="form-select" name="yearDropdown">
					<option value="2026">वार्षिक शुल्क स्थिति 2026</option>
					<option value="2025">वार्षिक शुल्क स्थिति 2025</option>
                  <option value="2024">वार्षिक शुल्क स्थिति 2024</option>
                  <option value="2023">वार्षिक शुल्क स्थिति 2023</option>
                  <option value="2022">वार्षिक शुल्क स्थिति 2022</option>
                  <option value="2021">वार्षिक शुल्क स्थिति 2021</option>
                  <option value="2020">वार्षिक शुल्क स्थिति 2020</option>
                </select>
              </div>


              <div class="col-md-1 d-grid">
                <button type="submit" class="btn btn-primary">🔍 खोजें</button>
              </div>
              <div class="col-md-1 d-grid">
                <button type="button" id="resetBtn" class="btn btn-secondary">♻️ रीसेट</button>
              </div>
            </div>
            <div class="col-md-1">प्रति पृष्ठ:
              <select name="size" class="form-select">
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="5">5</option>
                <option value="10" selected>10</option>
                <option value="20">20</option>
              </select>
            </div>
          </form>

          <!-- 🧾 User Card List -->
          <div id="userCardListContainer">
            <div class="row align-items-left mb-3">

              <div class="col-md-12 text-end">
                <span class="text-muted fw-light">कुल परिणाम: ${totalItems}</span>
              </div>
            </div>
            <c:forEach var="user" items="${userList}">
              <div class="card profile-card border-0 shadow-sm hover-shadow mb-4">
                <div class="name-banner">${user.fullName}</div>

                <div class="row g-3">
                  <!-- Profile Image -->
                  <div class="col-md-3 d-flex align-items-center">
                    <div class="w-100 text-center">
                      <img src="${user.profileImagePath != null ? user.profileImagePath : '/images/default.png'}"
                        class="img-fluid profile-img border border-2 border-light rounded-3 shadow-sm" alt="Photo"
                        style="max-height: 200px;">
                    </div>
                  </div>

                  <!-- Profile Info -->
                  <div class="col-md-9">
                    <div class="card-body py-2">
                      <div class="row mb-2">
                        <div class="col-md-6"><label class="smaj-role-label">पंजीयन क्रमांक:</label> <span
                            class="badge bg-light text-dark">${user.registrationNo}</span></div>
                        <div class="col-md-6"><label class="smaj-role-label">पिता का नाम:</label> ${user.fatherName}</div>
                      </div>
                      <div class="row mb-2">
                        <div class="col-md-6"><label class="smaj-role-label">गोत्र:</label> ${user.gotra}</div>
                        <div class="col-md-6"><label class="smaj-role-label">पेशा:</label> ${user.occupation}</div>
                      </div>
                      <div class="row mb-2">
                        <div class="col-md-6"><label class="smaj-role-label">पता:</label> ${user.address}, ${user.homeDistrict}</div>
                        <div class="col-md-6"><label class="smaj-role-label">मोबाइल:</label> <a href="tel:${user.mobile}"
                            class="text-decoration-none">${user.mobile}</a></div>
                      </div>
                      <div class="row mb-2">
                        <div class="col-md-6"><label class="smaj-role-label">ईमेल:</label> <a href="mailto:${user.email}"
                            class="text-decoration-none">${user.email}</a></div>
                        <div class="col-md-6">
                          <label class="smaj-role-label">शर्तें स्वीकार:</label>
                          <span class="badge bg-${user.agreeToTerms ? 'success' : 'danger'}">
                            ${user.agreeToTerms ? "हाँ" : "नहीं"}
                          </span>
                        </div>
                      </div>
                      <div class="row mb-2">
                        <div class="col-md-6">
                          <label class="smaj-role-label">अंतिम वार्षिक भुगतान:</label>
                          <c:choose>
                            <c:when test="${user.lastAnnualFeePaid != null}">
                              ₹${user.lastAnnualFeeAmount} — <span class="text-muted">${user.lastAnnualFeePaid}</span>
                            </c:when>
                            <c:otherwise><span class="text-muted">--</span></c:otherwise>
                          </c:choose>
                        </div>
                        <div class="col-md-6">
                          <label class="smaj-role-label">वार्षिक भुगतान:</label> <span class="text-danger fw-bold">₹
                            ${user.annualFeeStatus}</span>
                        </div>
                      </div>

                      <div class="row mb-2 align-items-center">
                        <div class="col-md-6 filedt">
                          <label class="smaj-role-label">प्रोफाइल स्थिति:</label>
                          <span class="badge ${user.approved == 'स्वीकृत'? 'bg-success' : 'bg-warning text-dark'}">
                            ${user.approved}
                          </span>
                        </div>
					
						  <div class="col-md-6">
						    <div class="smaj-role-wrapper">
						      <label class="smaj-role-label"> समाज पद</label>

						      <select class="form-select smaj-role-select user-role-dropdown"
						              data-user-id="${user.id}"
						              data-current-role="${user.smajRole}">
						        <option value="">-- चयन करें --</option>
						        <option value="अध्यक्ष" ${user.smajRole=='अध्यक्ष'?'selected':''}>अध्यक्ष</option>
						        <option value="उपाध्यक्ष" ${user.smajRole=='उपाध्यक्ष'?'selected':''}>उपाध्यक्ष</option>
						        <option value="कोषाध्यक्ष" ${user.smajRole=='कोषाध्यक्ष'?'selected':''}>कोषाध्यक्ष</option>
						        <option value="सचिव" ${user.smajRole=='सचिव'?'selected':''}>सचिव</option>
						        <option value="सह-सचिव" ${user.smajRole=='सह-सचिव'?'selected':''}>सह-सचिव</option>
						        <option value="कार्यकारिणी सदस्य" ${user.smajRole=='कार्यकारिणी सदस्य'?'selected':''}>कार्यकारिणी सदस्य</option>
						        <option value="सदस्य" ${user.smajRole=='सदस्य'?'selected':''}>सदस्य</option>
						      </select>

						      <!--<c:if test="${not empty user.smajRole}">
						        <span class="smaj-role-badge">${user.smajRole}</span>
						      </c:if>-->
						    </div>
						  </div>
					


                        <c:if
                          test="${user.approved=='प्रक्रिया में' || user.annualFeeValidated=='प्रक्रिया में' || user.otherFeeValidated=='प्रक्रिया में'}">
                          <div class="row mt-2">
                            <div class="col-md-12 d-flex justify-content-start gap-2 flex-wrap">
                              <c:if test="${user.annualFeeValidated=='प्रक्रिया में'}">
                                <button class="btn btnn btn-outline-success validate-annual-btn"
                                  data-user-id="${user.id}">
                                  ✔️ वार्षिक शुल्क सत्यापित करें
                                </button>
                              </c:if>
                              <c:if test="${user.otherFeeValidated=='प्रक्रिया में'}">
                                <button class="btn btnn btn-outline-info btn-sm validate-other-btn"
                                  data-user-id="${user.id}">
                                  💼 अन्य शुल्क सत्यापित करें
                                </button>
                              </c:if>
                              <c:if test="${user.approved == 'प्रक्रिया में'}">
                                <button class="btn btn-outline-success btn-sm validate-profile-btn"
                                  data-user-id="${user.id}">
                                  ✅ प्रोफाइल सत्यापित करें
                                </button>
                                <button class="btn btn-outline-danger btn-sm reject-profile-btn"
                                  data-user-id="${user.id}">
                                  ❌ अस्वीकृत करें
                                </button>
                              </c:if>

                            </div>
                          </div>
                        </c:if>

                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </c:forEach>

            <!-- Page Info -->
            <c:if test="${totalPages > 0}">
              <p class="text-center text-muted">पृष्ठ ${currentPage + 1} / ${totalPages}</p>
            </c:if>
            <!-- 📄 Pagination Bar -->
            <c:if test="${totalPages > 0}">
              <nav class="mt-4">
                <ul class="pagination justify-content-center">
                  <li class="page-item ${currentPage == 0 ? 'disabled' : ''}">
                    <a class="page-link page-link-btn" href="#" data-page="${currentPage - 1}">⏮ पिछला</a>
                  </li>
                  <c:forEach begin="0" end="${totalPages - 1}" var="i">
                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                      <a class="page-link page-link-btn" href="#" data-page="${i}">${i + 1}</a>
                    </li>
                  </c:forEach>
                  <li class="page-item ${currentPage == totalPages - 1 ? 'disabled' : ''}">
                    <a class="page-link page-link-btn" href="#" data-page="${currentPage + 1}">अगला ⏭</a>
                  </li>
                </ul>
              </nav>
            </c:if>


          </div>
        </div>
        <!-- 💰 Annual Payment Modal -->
        <div class="modal fade" id="annualPaymentModal" tabindex="-1" aria-labelledby="annualPaymentModalLabel"
          aria-hidden="true">
          <div class="modal-dialog modal-xl modal-dialog-scrollable">
            <div class="modal-content">
              <div class="modal-header bg-warning text-dark">
                <h5 class="modal-title" id="annualPaymentModalLabel">🧾 वार्षिक भुगतान विवरण</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
              </div>
              <div class="modal-body" id="annualPaymentModalBody">
                <div class="text-center text-muted">लोड हो रहा है...</div>
              </div>
            </div>
          </div>
        </div>

        <!-- Script -->

        <script src="${pageContext.request.contextPath}/js/memberListAdmin.js"></script>
      </body>

      </html> 			<%@ include file="/WEB-INF/views/includes/footer.jsp" %>