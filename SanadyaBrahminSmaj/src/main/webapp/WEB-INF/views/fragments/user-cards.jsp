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