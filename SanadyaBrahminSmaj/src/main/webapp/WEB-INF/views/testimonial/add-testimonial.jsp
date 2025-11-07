<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>

<div class="container py-4">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card shadow">
                <div style="background: linear-gradient(135deg, #f87e03 0%, #b65c02 100%);" class="card-header text-white">
                    <h4 class="mb-0">
                        <c:choose>
                            <c:when test="${not empty testimonial}">प्रशंसापत्र संपादित करें</c:when>
                            <c:otherwise>प्रशंसापत्र जोड़ें</c:otherwise>
                        </c:choose>
                    </h4>
                </div>
                <div class="card-body">
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">${error}</div>
                    </c:if>

                    <form action="<c:choose>
                                      <c:when test='${not empty testimonial}'>/member/update-testimonial</c:when>
                                      <c:otherwise>/member/save-testimonial</c:otherwise>
                                   </c:choose>" method="post">

                        <!-- hidden id field for update -->
                        <c:if test="${not empty testimonial}">
                            <input type="hidden" name="id" value="${testimonial.id}">
                        </c:if>

                        <!-- User Info -->
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label">नाम:</label>
                                <input type="text" class="form-control" value="${user.fullName}" readonly>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">पेशा:</label>
                                <input type="text" class="form-control" value="${user.occupation}" readonly>
                            </div>
                        </div>

                        <!-- Designation -->
                        <div class="mb-3">
                            <label for="designation" class="form-label">पदनाम (वैकल्पिक)</label>
                            <input type="text" class="form-control" id="designation" name="designation"
                                   value="<c:out value='${testimonial.designation}'/>"
                                   placeholder="उदा: संस्थापक, निदेशक, सलाहकार">
                            <small class="form-text text-muted">यदि खाली छोड़ा जाए तो आपका पेशा दिखेगा</small>
                        </div>

                        <!-- Message -->
                        <div class="mb-3">
                            <label for="message" class="form-label">आपका संदेश/प्रशंसापत्र: <span class="text-danger">*</span></label>
                            <textarea class="form-control" id="message" name="message" rows="5"
                                      placeholder="समाज के बारे में आपके विचार, अनुभव या संदेश लिखें..." required maxlength="1000">
                                <c:out value="${testimonial.message}"/>
                            </textarea>
                            <div class="form-text">अधिकतम 1000 अक्षर</div>
                        </div>

                        <!-- Character Counter -->
                        <div class="mb-3">
                            <small class="text-muted">
                                <span id="charCount">0</span>/1000 अक्षर
                            </small>
                        </div>

                        <!-- Guidelines -->
                        <div class="alert alert-info" style="background-color: #f0c471;">
                            <h6>दिशानिर्देश:</h6>
                            <ul class="mb-0">
                                <li>कृपया सकारात्मक और रचनात्मक संदेश लिखें</li>
                                <li>व्यक्तिगत आक्रमण या अनुचित भाषा का प्रयोग न करें</li>
                                <li>आपका प्रशंसापत्र समीक्षा के बाद प्रकाशित होगा</li>
                            </ul>
                        </div>

                        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                            <a href="/member/profile" class="btn btn-secondary me-md-2">रद्द करें</a>
                            <c:choose>
                                <c:when test="${not empty testimonial}">
                                    <button type="submit" class="btn btn-primary">अपडेट करें</button>
                                </c:when>
                                <c:otherwise>
                                    <button type="submit" class="btn btn-primary">सबमिट करें</button>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        const messageTextarea = document.getElementById('message');
        const charCount = document.getElementById('charCount');

        function updateCounter() {
            const length = messageTextarea.value.trim().length;
            charCount.textContent = length;

            if (length > 900) {
                charCount.style.color = '#dc3545';
            } else if (length > 800) {
                charCount.style.color = '#ffc107';
            } else {
                charCount.style.color = '#6c757d';
            }
        }

        messageTextarea.addEventListener('input', updateCounter);
        updateCounter(); // initial count on page load (useful for edit mode)
    });
</script>
