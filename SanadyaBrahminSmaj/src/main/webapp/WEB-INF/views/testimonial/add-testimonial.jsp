<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>

<div class="container py-4">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card shadow">
                <div class="card-header bg-primary text-white">
                    <h4 class="mb-0">प्रशंसापत्र जोड़ें</h4>
                </div>
                <div class="card-body">
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">${error}</div>
                    </c:if>

                    <form action="/member/save-testimonial" method="post">
                        <!-- User Info Display -->
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

                        <!-- Custom Designation -->
                        <div class="mb-3">
                            <label for="designation" class="form-label">पदनाम (वैकल्पिक - यदि आप अपने पेशे से अलग कुछ दिखाना चाहते हैं):</label>
                            <input type="text" class="form-control" id="designation" name="designation" 
                                   placeholder="उदा: संस्थापक, निदेशक, सलाहकार">
                            <small class="form-text text-muted">यदि खाली छोड़ा जाए तो आपका पेशा दिखेगा</small>
                        </div>

                        <!-- Message -->
                        <div class="mb-3">
                            <label for="message" class="form-label">आपका संदेश/प्रशंसापत्र: <span class="text-danger">*</span></label>
                            <textarea class="form-control" id="message" name="message" rows="5" 
                                      placeholder="समाज के बारे में आपके विचार, अनुभव या संदेश लिखें..." 
                                      required maxlength="1000"></textarea>
                            <div class="form-text">अधिकतम 1000 अक्षर</div>
                        </div>

                        <!-- Character Counter -->
                        <div class="mb-3">
                            <small class="text-muted">
                                <span id="charCount">0</span>/1000 अक्षर
                            </small>
                        </div>

                        <!-- Guidelines -->
                        <div class="alert alert-info">
                            <h6>दिशानिर्देश:</h6>
                            <ul class="mb-0">
                                <li>कृपया सकारात्मक और रचनात्मक संदेश लिखें</li>
                                <li>व्यक्तिगत आक्रमण या अनुचित भाषा का प्रयोग न करें</li>
                                <li>आपका प्रशंसापत्र समीक्षा के बाद प्रकाशित होगा</li>
                            </ul>
                        </div>

                        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                            <a href="/member/profile" class="btn btn-secondary me-md-2">रद्द करें</a>
                            <button type="submit" class="btn btn-primary">सबमिट करें</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    const messageTextarea = document.getElementById('message');
    const charCount = document.getElementById('charCount');
    
    messageTextarea.addEventListener('input', function() {
        const length = this.value.length;
        charCount.textContent = length;
        
        if (length > 900) {
            charCount.style.color = '#dc3545';
        } else if (length > 800) {
            charCount.style.color = '#ffc107';
        } else {
            charCount.style.color = '#6c757d';
        }
    });
});
</script>

