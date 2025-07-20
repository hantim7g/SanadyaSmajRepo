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
          .profile-card {
            background: linear-gradient(to left, #ffa347, #fca854);

            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 12px;
            margin-bottom: 20px;
            padding: 15px;
            transition: transform 0.2s ease-in-out;
          }

          .profile-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.08);
          }

          .btnn {

            background-color: #0b9e00;
            color: white;
            font-size: 1rem;
            border-radius: 8px;
            /* padding: 10px 15px; */
            font-weight: boldder;
            transition: background-color 0.3s ease;
          }

          .profile-img {

            width: 250px;
            height: 250px;
            max-height: 250px;
            align-items: center;
            object-fit: cover;
            border-radius: 8px;
          }

          .filedt {
            color: rgb(8, 6, 6);
            font-weight: 500;
            font-size: 1.2rem;
            /* margin-bottom: 10px;   */
            text-align: left;
            /* padding: 5px 0; */
            /* border-bottom: 1px solid rgb(255, 255, 255);  */
          }

          .name-banner {
            /* padding: 12px;
      border-radius: 8px; */
            font-size: 2.0rem;
            font-weight: 700;
            color: rgb(0, 0, 0);
            text-align: left;
            margin-bottom: 15px;
            margin-left: 15px;
            border-bottom: 1px solid black;

            /* box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1); */
          }
        </style>
      </head>

      <body>
        <div class="container my-4">
          <h2 class="mb-4 text-center">यूज़र प्रोफाइल कार्ड</h2>

          <!-- 🔍 Filter Form -->
          <!-- Replace Filter Form in memberListAdmin.jsp -->
          <form id="filterForm" class="mb-4">
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
                  <option value="प्रक्रिया में">प्रक्रिया में</option>
                  <option value="सत्यापित">सत्यापित</option>
                  <option value="अस्वीकृत">अस्वीकृत</option>
                </select>
              </div>
              <div class="col-md-2">
                <select  class="form-select" name="yearDropdown">
                  <option value="2025">शुल्क स्थिति 2025</option>
                  <option value="2024">शुल्क स्थिति 2024</option>
                  <option value="2023">शुल्क स्थिति 2023</option>
                  <option value="2022">शुल्क स्थिति 2022</option>
                  <option value="2021">शुल्क स्थिति 2021</option>
                  <option value="2020">शुल्क स्थिति 2020</option>
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
                        <div class="col-md-6"><strong>पंजीयन क्रमांक:</strong> <span
                            class="badge bg-light text-dark">${user.registrationNo}</span></div>
                        <div class="col-md-6"><strong>पिता का नाम:</strong> ${user.fatherName}</div>
                      </div>
                      <div class="row mb-2">
                        <div class="col-md-6"><strong>गोत्र:</strong> ${user.gotra}</div>
                        <div class="col-md-6"><strong>पेशा:</strong> ${user.occupation}</div>
                      </div>
                      <div class="row mb-2">
                        <div class="col-md-6"><strong>पता:</strong> ${user.address}, ${user.homeDistrict}</div>
                        <div class="col-md-6"><strong>मोबाइल:</strong> <a href="tel:${user.mobile}"
                            class="text-decoration-none">${user.mobile}</a></div>
                      </div>
                      <div class="row mb-2">
                        <div class="col-md-6"><strong>ईमेल:</strong> <a href="mailto:${user.email}"
                            class="text-decoration-none">${user.email}</a></div>
                        <div class="col-md-6">
                          <strong>शर्तें स्वीकार:</strong>
                          <span class="badge bg-${user.agreeToTerms ? 'success' : 'danger'}">
                            ${user.agreeToTerms ? "हाँ" : "नहीं"}
                          </span>
                        </div>
                      </div>
                      <div class="row mb-2">
                        <div class="col-md-6">
                          <strong>अंतिम वार्षिक भुगतान:</strong>
                          <c:choose>
                            <c:when test="${user.lastAnnualFeePaid != null}">
                              ₹${user.lastAnnualFeeAmount} — <span class="text-muted">${user.lastAnnualFeePaid}</span>
                            </c:when>
                            <c:otherwise><span class="text-muted">--</span></c:otherwise>
                          </c:choose>
                        </div>
                        <div class="col-md-6">
                          <strong>वार्षिक भुगतान:</strong> <span class="text-danger fw-bold">₹
                            ${user.annualFeeStatus}</span>
                        </div>
                      </div>

                      <div class="row mb-2 align-items-center">
                        <div class="col-md-6 filedt">
                          <strong>प्रोफाइल स्थिति:</strong>
                          <span class="badge ${user.approved == 'स्वीकृत'? 'bg-success' : 'bg-warning text-dark'}">
                            ${user.approved}
                          </span>
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

      </html>