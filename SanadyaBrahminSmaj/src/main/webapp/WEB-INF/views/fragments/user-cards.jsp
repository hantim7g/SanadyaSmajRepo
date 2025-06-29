<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

    <!-- Result Count and Page Size Selector -->


    <!-- User Card List -->
<div id="userCardList">
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
                          test="${user.approved=='प्रक्रिया में' || user.annualFeeStatus=='प्रक्रिया में' || user.otherFeeValidated=='प्रक्रिया में'}">
                          <div class="row mt-2">
                            <div class="col-md-12 d-flex justify-content-start gap-2 flex-wrap">
                              <c:if test="${user.annualFeeStatus=='प्रक्रिया में'}">
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



    </div>

    <!-- Page Info -->
    <c:if test="${totalPages > 0}">
      <p class="text-center text-muted">पृष्ठ ${currentPage + 1} / ${totalPages}</p>
    </c:if>

    <!-- Pagination -->
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