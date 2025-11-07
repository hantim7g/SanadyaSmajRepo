<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>

<div class="container py-4">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card shadow">
                <div class="card-header bg-primary text-white">
                    <h4 class="mb-0"><i class="fas fa-edit"></i> प्रशंसापत्र संपादित करें</h4>
                </div>
                <div class="card-body">
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fas fa-exclamation-triangle"></i> ${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <form action="/member/update-testimonial/${testimonial.id}" method="post" id="editTestimonialForm">
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label">नाम:</label>
                                <input type="text" class="form-control" value="${testimonial.user.fullName}" readonly>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">वर्तमान स्थिति:</label>
                                <span class="badge ${testimonial.status == 'स्वीकृत' ? 'bg-success' : testimonial.status == 'अस्वीकृत' ? 'bg-danger' : 'bg-warning'}">
                                    ${testimonial.status}
                                </span>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="designation" class="form-label">
                                पदनाम (वैकल्पिक - वर्तमान पेशा: "${testimonial.user.occupation}"):
                            </label>
                            <input type="text" class="form-control" id="designation" name="designation" 
                                   value="${testimonial.designation}" 
                                   placeholder="उदा: संस्थापक, निदेशक, सलाहकार">
                            <small class="form-text text-muted">
                                यदि खाली छोड़ा जाए तो आपका पेशा "${testimonial.user.occupation}" दिखेगा
                            </small>
                        </div>

                        <div class="mb-3">
                            <label for="message" class="form-label">
                                आपका संदेश/प्रशंसापत्र: <span class="text-danger">*</span>
                            </label>
                            <textarea class="form-control" id="message" name="message" rows="6" 
                                      placeholder="समाज के बारे में आपके विचार, अनुभव या संदेश लिखें..." 
                                      required maxlength="1000">${testimonial.message}</textarea>
                            <div class="form-text">अधिकतम 1000 अक्षर</div>
                        </div>

                        <div class="mb-3">
                            <small class="text-muted">
                                <span id="charCount">${fn:length(testimonial.message)}</span>/1000 अक्षर
                            </small>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-6">
                                <small class="text-muted">
                                    <i class="fas fa-clock"></i> बनाया गया: ${testimonial.formattedCreatedDate}
                                </small>
                            </div>
                            <div class="col-md-6">
                                <c:if test="${not empty testimonial.updatedDate}">
                                    <small class="text-muted">
                                        <i class="fas fa-edit"></i> अंतिम अपडेट: ${testimonial.formattedUpdatedDate}
                                    </small>
                                </c:if>
                            </div>
                        </div>

                        <c:if test="${testimonial.status == 'स्वीकृत'}">
                            <div class="alert alert-warning">
                                <h6><i class="fas fa-info-circle"></i> ध्यान दें:</h6>
                                <p class="mb-0">यह प्रशंसापत्र पहले से स्वीकृत है। संपादन के बाद यह पुनः समीक्षा के लिए जाएगा।</p>
                            </div>
                        </c:if>

                        <div class="alert alert-info">
                            <h6><i class="fas fa-lightbulb"></i> दिशानिर्देश:</h6>
                            <ul class="mb-0">
                                <li>कृपया सकारात्मक और रचनात्मक संदेश लिखें</li>
                                <li>व्यक्तिगत आक्रमण या अनुचित भाषा का प्रयोग न करें</li>
                                <li>संपादन के बाद प्रशंसापत्र पुनः समीक्षा के लिए जाएगा</li>
                            </ul>
                        </div>

                        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                            <a href="/testimonial/my-testimonials" class="btn btn-secondary me-md-2">
                                <i class="fas fa-arrow-left"></i> वापस जाएं
                            </a>
                            <button type="submit" class="btn btn-primary" id="updateBtn">
                                <i class="fas fa-save"></i> अपडेट करें
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
$(document).ready(function() {
    const messageTextarea = $('#message');
    const charCount = $('#charCount');
    const updateBtn = $('#updateBtn');
    const form = $('#editTestimonialForm');
    
    messageTextarea.on('input', function() {
        const length = this.value.length;
        charCount.text(length);
        
        if (length > 900) {
            charCount.css('color', '#dc3545');
        } else if (length > 800) {
            charCount.css('color', '#ffc107');
        } else {
            charCount.css('color', '#6c757d');
        }
    });
    
    form.on('submit', function(e) {
        updateBtn.prop('disabled', true);
        updateBtn.html('<i class="fas fa-spinner fa-spin"></i> अपडेट हो रहा है...');
        
        setTimeout(function() {
            updateBtn.prop('disabled', false);
            updateBtn.html('<i class="fas fa-save"></i> अपडेट करें');
        }, 5000);
    });
});
</script>
