<%@ include file="/WEB-INF/views/includes/header.jsp" %>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
      <!DOCTYPE html>
      <html lang="hi">

      <head>
        <meta charset="UTF-8">
        <title>यूज़र कार्ड सूची</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
        <!-- Custom Styles -->
        <style>
          body {
            background: #fffaf4;
            font-family: 'Segoe UI', 'Noto Sans Devanagari', sans-serif;
          }

          .main-width {
            max-width: 1200px;
            /* or 100% */
            margin: auto;
          }


          /* FILTER BAR STYLES */
          .filter-form {
            background: linear-gradient(93deg, #fff7ed 70%, #fffbe9 100%);
            border-radius: 14px;
            box-shadow: 0 1px 8px 0 #edd1aeb2;
            padding: 1.2rem 1.1rem 0.5rem;
            margin-bottom: 2.2rem;
          }

          .filter-form input,
          .filter-form select {
            font-size: 1.07rem;
            border-radius: 8px;
            border: 1.5px solid #ecc099;
            background: #fffdfa;
            color: #57360c;
            min-height: 2.3rem;
            box-shadow: none;
            transition: border-color 0.22s, box-shadow 0.22s;
          }

          .filter-form input:focus,
          .filter-form select:focus {
            border-color: #d58d39;
            background: #fff7e3;
            box-shadow: 0 0 0 2px #ffecb890;
          }

          .filter-form .btn-primary,
          .filter-form .btn-secondary {
            border-radius: 7px;
            font-weight: 600;
            letter-spacing: .02em;
            margin-bottom: 2px;
          }

          .filter-form label {
            color: #915504;
            font-weight: 600;
            font-size: 1rem;
          }

          /* CARD STYLES */
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

          /* BADGE and STATUS STYLES */
          .profile-card .badge {
            border-radius: 1.2em;
            padding: 0.37em 0.99em 0.35em 0.99em;
            font-weight: 600;
            letter-spacing: .01em;
            font-size: .97em;
          }

          /* Action Buttons */
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

          .profile-card .btnn.btn-outline-success,
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
            box-shadow: none;
          }

          .profile-card .btn-outline-info {
            background: none;
            color: #007795 !important;
            border: 2px solid #5edcf9;
            box-shadow: none;
          }

          .profile-card .btnn:hover,
          .profile-card .btn:hover {
            background: #079610 !important;
            color: #fff !important;
            border-color: #1e9e26;
            box-shadow: 0 1px 8px 0 #8be29670;
            transform: scale(1.03);
          }

          /* Details formatting */
          .profile-card .row .col-md-6 strong,
          .profile-card .field-label {
            color: #8e6510;
            font-weight: 700;
          }

          /* Result text */
          .text-muted.fw-light {
            font-size: 1.1rem;
            font-weight: 500;
          }

          /* Pagination */
          .pagination .page-item .page-link {
            border-radius: 8px !important;
            margin: 0 2px;
            border: 1.5px solid #ffe3b9;
            font-weight: 600;
            background: #fffdfa;
            color: #bf8120;
            transition: background 0.17s;
          }

          .pagination .page-item.active .page-link,
          .pagination .page-item .page-link:focus {
            background: linear-gradient(97deg, #ffe3b7 70%, #fffbe9 100%);
            border-color: #ffd889;
            color: #b76207;
          }

          /* Responsive optimizations */
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
        </style>
      </head>

      <body>
        <div class="container my-4 main-width">
          <h2 class="mb-4 text-center" style="color:#974700;">यूज़र प्रोफाइल कार्ड</h2>

          <!-- FILTER FORM -->
          <form id="filterForm" class="mb-4 filter-form">
            <div class="row g-2 align-items-end">
              <div class="col-md-3">
                <label for="filter-name" class="form-label">नाम</label>
                <input type="text" id="filter-name" class="form-control" name="name" placeholder="नाम से खोजें">
              </div>
              <div class="col-md-3">
                <label for="filter-mobile" class="form-label">मोबाइल</label>
                <input type="text" id="filter-mobile" class="form-control" name="mobile" placeholder="मोबाइल">
              </div>
              <div class="col-md-2">
                <label for="filter-approved" class="form-label">प्रोफाइल स्थिति</label>
                <select id="filter-approved" name="approved" class="form-select">
                  <option value="">-- चयन करें --</option>
                  <option value="स्वीकृत">स्वीकृत</option>
                  <option value="प्रक्रिया में">प्रक्रिया में</option>
                  <option value="अस्वीकृत">अस्वीकृत</option>
                </select>
              </div>
              <div class="col-md-2">
                <label for="filter-annual-fee-status" class="form-label">वार्षिक शुल्क स्थिति</label>
                <select id="filter-annual-fee-status" name="annualFeeStatus" class="form-select">
                  <option value="">-- चयन करें --</option>
                  <option value="प्रतीक्षारत">प्रतीक्षारत</option>
                  <option value="प्रक्रिया में">प्रक्रिया में</option>
                  <option value="सत्यापित">सत्यापित</option>
                  <option value="अस्वीकृत">अस्वीकृत</option>
                </select>
              </div>
              <div class="col-md-2">
                <label for="filter-year-dropdown" class="form-label">शुल्क वर्ष</label>
                <select id="filter-year-dropdown" class="form-select" name="yearDropdown">
                  <option value="2025">2025</option>
                  <option value="2024">2024</option>
                  <option value="2023">2023</option>
                  <option value="2022">2022</option>
                  <option value="2021">2021</option>
                  <option value="2020">2020</option>
                </select>
              </div>
              <div class="col-12 d-flex justify-content-end gap-2 mt-2 align-items-end">
                <label for="filter-size" class="form-label me-2 mb-0 align-self-center">प्रति पृष्ठ</label>
                <select id="filter-size" name="size" class="form-select d-inline w-auto" style="max-width:70px;">
                  <option value="1">1</option>
                  <option value="2">2</option>
                  <option value="5">5</option>
                  <option value="10" selected>10</option>
                  <option value="20">20</option>
                </select>
                <button type="submit" class="btn btn-primary ms-3">🔍 खोजें</button>
                <button type="button" id="resetBtn" class="btn btn-secondary">♻️ रीसेट</button>
              </div>
            </div>
          </form>


          <!-- RESULTS COUNTER -->
          <div class="row mb-3">
            <div class="col-md-12 text-end">
              <span class="text-muted fw-light">कुल परिणाम: ${totalItems}</span>
            </div>
          </div>

          <!-- USER CARDS -->
          <c:forEach var="user" items="${userList}">
            <div class="card profile-card border-0">
              <div class="name-banner">${user.fullName}</div>
              <div class="row g-3">
                <!-- Profile Image -->
                <div class="col-md-3 d-flex align-items-center justify-content-center">
                  <img src="${user.profileImagePath != null ? user.profileImagePath : '/images/default.png'}"
                    class="profile-img shadow-sm border border-2 border-light" alt="Photo">
                </div>
                <!-- Profile Info -->
                <div class="col-md-9">
                  <div class="card-body py-2 px-1">
                    <div class="row mb-2">
                      <div class="col-md-6"><span class="field-label">पंजीयन क्रमांक:</span> <span
                          class="badge bg-light text-dark">${user.registrationNo}</span></div>
                      <div class="col-md-6"><span class="field-label">पिता का नाम:</span> ${user.fatherName}</div>
                    </div>
                    <div class="row mb-2">
                      <div class="col-md-6"><span class="field-label">गोत्र:</span> ${user.gotra}</div>
                      <div class="col-md-6"><span class="field-label">पेशा:</span> ${user.occupation}</div>
                    </div>
                    <div class="row mb-2">
                      <div class="col-md-6"><span class="field-label">पता:</span> ${user.address}, ${user.homeDistrict}
                      </div>
                      <div class="col-md-6"><span class="field-label">मोबाइल:</span> <a href="tel:${user.mobile}"
                          class="text-decoration-none">${user.mobile}</a></div>
                    </div>
                    <div class="row mb-2">
                      <div class="col-md-6"><span class="field-label">ईमेल:</span> <a href="mailto:${user.email}"
                          class="text-decoration-none">${user.email}</a></div>
                      <div class="col-md-6">
                        <span class="field-label">शर्तें स्वीकार:</span>
                        <span class="badge bg-${user.agreeToTerms ? 'success' : 'danger'}">
                          ${user.agreeToTerms ? "हाँ" : "नहीं"}
                        </span>
                      </div>
                    </div>
                    <div class="row mb-2">
                      <div class="col-md-6">
                        <span class="field-label">अंतिम वार्षिक भुगतान:</span>
                        <c:choose>
                          <c:when test="${user.lastAnnualFeePaid != null}">
                            ₹${user.lastAnnualFeeAmount} — <span class="text-muted">${user.lastAnnualFeePaid}</span>
                          </c:when>
                          <c:otherwise><span class="text-muted">--</span></c:otherwise>
                        </c:choose>
                      </div>
                      <div class="col-md-6">
                        <span class="field-label">वार्षिक भुगतान:</span> <span
                          class="text-danger fw-bold">₹${user.annualFeeStatus}</span>
                      </div>
                    </div>
                    <div class="row mb-2 align-items-center">
                      <div class="col-md-6 filedt">
                        <span class="field-label">प्रोफाइल स्थिति:</span>
                        <span
                          class="badge 
                    ${user.approved == 'स्वीकृत'? 'bg-success' : (user.approved == 'प्रक्रिया में' ? 'bg-warning text-dark' : 'bg-danger')}">${user.approved}</span>
                      </div>
                    </div>
                    <c:if
                      test="${user.approved=='प्रक्रिया में' || user.annualFeeValidated=='प्रक्रिया में' || user.otherFeeValidated=='प्रक्रिया में'}">
                      <div class="row mt-2">
                        <div class="col-md-12 d-flex justify-content-start gap-2 flex-wrap">
                          <c:if test="${user.annualFeeValidated=='प्रक्रिया में'}">
                            <button class="btn btnn btn-outline-success" data-user-id="${user.id}">
                              ✔️ वार्षिक शुल्क सत्यापित करें
                            </button>
                          </c:if>
                          <c:if test="${user.otherFeeValidated=='प्रक्रिया में'}">
                            <button class="btn btnn btn-outline-info btn-sm" data-user-id="${user.id}">
                              💼 अन्य शुल्क सत्यापित करें
                            </button>
                          </c:if>
                          <c:if test="${user.approved == 'प्रक्रिया में'}">
                            <button class="btn btn-outline-success btn-sm validate-profile-btn"
                              data-user-id="${user.id}">
                              ✅ प्रोफाइल सत्यापित करें
                            </button>
                            <button class="btn btn-outline-danger btn-sm reject-profile-btn" data-user-id="${user.id}">
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
          </c:forEach>

          <!-- Page Info & Pagination -->
          <c:if test="${totalPages > 0}">
            <p class="text-center text-muted">पृष्ठ ${currentPage + 1} / ${totalPages}</p>
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

        <!-- Annual Payment Modal (unchanged) -->
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
        <script src="${pageContext.request.contextPath}/js/memberListAdmin.js"></script>
      </body>

      </html>