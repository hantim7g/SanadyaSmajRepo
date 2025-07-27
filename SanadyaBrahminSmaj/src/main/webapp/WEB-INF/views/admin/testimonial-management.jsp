<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>

<div class="container-fluid py-4">
    <h2 class="mb-4">प्रशंसापत्र प्रबंधन</h2>

    <!-- Pending Testimonials -->
    <div class="card shadow mb-4">
        <div class="card-header bg-warning text-dark">
            <h5 class="mb-0">
                <i class="fas fa-clock"></i> 
                अनुमोदन की प्रतीक्षा में (${fn:length(pendingTestimonials)})
            </h5>
        </div>
        <div class="card-body">
            <c:choose>
                <c:when test="${not empty pendingTestimonials}">
                    <div class="table-responsive">
                        <table class="table table-striped" id="pendingTestimonialsTable">
                            <thead>
                                <tr>
                                    <th>सदस्य</th>
                                    <th>पदनाम</th>
                                    <th>संदेश</th>
                                    <th>तारीख</th>
                                    <th>कार्य</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="testimonial" items="${pendingTestimonials}">
                                    <tr id="testimonial-${testimonial.id}">
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <c:choose>
                                                    <c:when test="${not empty testimonial.user.profileImagePath}">
                                                        <img src="${testimonial.user.profileImagePath}" 
                                                             alt="${testimonial.user.fullName}" 
                                                             class="rounded-circle me-2" 
                                                             style="width: 40px; height: 40px; object-fit: cover;">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="bg-secondary rounded-circle me-2 d-flex align-items-center justify-content-center" 
                                                             style="width: 40px; height: 40px;">
                                                            <i class="fas fa-user text-white"></i>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                                <div>
                                                    <strong>${testimonial.user.fullName}</strong><br>
                                                    <small class="text-muted">${testimonial.user.mobile}</small>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty testimonial.designation}">
                                                    ${testimonial.designation}
                                                </c:when>
                                                <c:otherwise>
                                                    ${testimonial.user.occupation}
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <div style="max-width: 300px;">
                                                <c:choose>
                                                    <c:when test="${fn:length(testimonial.message) > 100}">
                                                        <span class="message-preview">${fn:substring(testimonial.message, 0, 100)}...</span>
                                                        <button class="btn btn-sm btn-link p-0 expand-btn" type="button">
                                                            पूरा पढ़ें
                                                        </button>
                                                        <div class="message-full d-none">${testimonial.message}</div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        ${testimonial.message}
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </td>
                                        <td>
                                            <fmt:formatDate value="${testimonial.createdDate}" pattern="dd/MM/yyyy HH:mm"/>
                                        </td>
                                        <td>
                                            <div class="btn-group" role="group">
                                                <button class="btn btn-success btn-sm approve-btn" 
                                                        data-id="${testimonial.id}">
                                                    <i class="fas fa-check"></i> स्वीकृत करें
                                                </button>
                                                <button class="btn btn-danger btn-sm reject-btn" 
                                                        data-id="${testimonial.id}">
                                                    <i class="fas fa-times"></i> अस्वीकृत करें
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="text-center py-4">
                        <p class="text-muted">कोई प्रशंसापत्र अनुमोदन की प्रतीक्षा में नहीं है।</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Approved Testimonials -->
    <div class="card shadow">
        <div class="card-header bg-success text-white">
            <h5 class="mb-0">
                <i class="fas fa-check-circle"></i> 
                स्वीकृत प्रशंसापत्र (${fn:length(approvedTestimonials)})
            </h5>
        </div>
        <div class="card-body">
            <c:choose>
                <c:when test="${not empty approvedTestimonials}">
                    <div class="table-responsive">
                        <table class="table table-striped" id="approvedTestimonialsTable">
                            <thead>
                                <tr>
                                    <th>सदस्य</th>
                                    <th>पदनाम</th>
                                    <th>संदेश</th>
                                    <th>स्वीकृत तारीख</th>
                                    <th>स्थिति</th>
                                    <th>कार्य</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="testimonial" items="${approvedTestimonials}">
                                    <tr id="approved-testimonial-${testimonial.id}">
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <c:choose>
                                                    <c:when test="${not empty testimonial.user.profileImagePath}">
                                                        <img src="${testimonial.user.profileImagePath}" 
                                                             alt="${testimonial.user.fullName}" 
                                                             class="rounded-circle me-2" 
                                                             style="width: 40px; height: 40px; object-fit: cover;">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="bg-secondary rounded-circle me-2 d-flex align-items-center justify-content-center" 
                                                             style="width: 40px; height: 40px;">
                                                            <i class="fas fa-user text-white"></i>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                                <div>
                                                    <strong>${testimonial.user.fullName}</strong><br>
                                                    <small class="text-muted">${testimonial.user.mobile}</small>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty testimonial.designation}">
                                                    ${testimonial.designation}
                                                </c:when>
                                                <c:otherwise>
                                                    ${testimonial.user.occupation}
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <div style="max-width: 300px;">
                                                <c:choose>
                                                    <c:when test="${fn:length(testimonial.message) > 100}">
                                                        <span class="message-preview">${fn:substring(testimonial.message, 0, 100)}...</span>
                                                        <button class="btn btn-sm btn-link p-0 expand-btn" type="button">
                                                            पूरा पढ़ें
                                                        </button>
                                                        <div class="message-full d-none">${testimonial.message}</div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        ${testimonial.message}
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </td>
                                        <td>
                                            <fmt:formatDate value="${testimonial.approvedDate}" pattern="dd/MM/yyyy HH:mm"/>
                                        </td>
                                        <td>
                                            <span class="badge ${testimonial.active ? 'bg-success' : 'bg-secondary'}" id="status-badge-${testimonial.id}">
                                                ${testimonial.active ? 'सक्रिय' : 'निष्क्रिय'}
                                            </span>
                                        </td>
                                        <td>
                                            <button class="btn btn-outline-primary btn-sm toggle-btn" 
                                                    data-id="${testimonial.id}"
                                                    data-active="${testimonial.active}">
                                                <i class="fas fa-toggle-${testimonial.active ? 'on' : 'off'}" id="toggle-icon-${testimonial.id}"></i>
                                                <span id="toggle-text-${testimonial.id}">${testimonial.active ? 'छुपाएं' : 'दिखाएं'}</span>
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="text-center py-4">
                        <p class="text-muted">कोई स्वीकृत प्रशंसापत्र नहीं है।</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<!-- Loading Modal -->
<div class="modal fade" id="loadingModal" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false">
    <div class="modal-dialog modal-sm modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-body text-center py-4">
                <div class="spinner-border text-primary" role="status">
                    <span class="visually-hidden">Loading...</span>
                </div>
                <div class="mt-2">कृपया प्रतीक्षा करें...</div>
            </div>
        </div>
    </div>
</div>

<script>
$(document).ready(function() {
    
    // Get auth token from localStorage
    function getAuthToken() {
        return localStorage.getItem('authToken');
    }
    
    // Show loading modal
    function showLoading() {
        $('#loadingModal').modal('show');
    }
    
    // Hide loading modal
    function hideLoading() {
        $('#loadingModal').modal('hide');
    }
    
    // Success notification
    function showSuccess(message) {
        bootbox.alert({
            title: "सफलता",
            message: message,
            className: "success-modal"
        });
    }
    
    // Error notification
    function showError(message) {
        bootbox.alert({
            title: "त्रुटि",
            message: message,
            className: "error-modal"
        });
    }

    // Expand/Collapse message functionality
    $(document).on('click', '.expand-btn', function() {
        const preview = $(this).prev('.message-preview');
        const full = $(this).next('.message-full');
        
        if (full.hasClass('d-none')) {
            preview.addClass('d-none');
            full.removeClass('d-none');
            $(this).text('कम दिखाएं');
        } else {
            preview.removeClass('d-none');
            full.addClass('d-none');
            $(this).text('पूरा पढ़ें');
        }
    });

    // Approve testimonial
    $(document).on('click', '.approve-btn', function() {
        const testimonialId = $(this).data('id');
        const $row = $('#testimonial-' + testimonialId);
        
        bootbox.confirm({
            title: "पुष्टि करें",
            message: "क्या आप इस प्रशंसापत्र को स्वीकृत करना चाहते हैं?",
            buttons: {
                confirm: {
                    label: 'हाँ, स्वीकृत करें',
                    className: 'btn-success'
                },
                cancel: {
                    label: 'रद्द करें',
                    className: 'btn-secondary'
                }
            },
            callback: function (result) {
                if (result) {
                    showLoading();
                    
                    $.ajax({
                        url: '/admin/testimonial/approve/' + testimonialId,
                        type: 'POST',
                        dataType: 'json',
                        headers: {
                            'Authorization': 'Bearer ' + getAuthToken(),
                            'Content-Type': 'application/json'
                        },
                        success: function(response) {
                            hideLoading();
                            showSuccess(response.message || 'प्रशंसापत्र सफलतापूर्वक स्वीकृत किया गया।');
                            
                            // Remove row with animation
                            $row.fadeOut(500, function() {
                                $(this).remove();
                                
                                // Update count
                                const remainingCount = $('#pendingTestimonialsTable tbody tr').length - 1;
                                $('.card-header .mb-0').html('<i class="fas fa-clock"></i> अनुमोदन की प्रतीक्षा में (' + remainingCount + ')');
                                
                                // Show empty message if no pending testimonials
                                if (remainingCount === 0) {
                                    $('#pendingTestimonialsTable').parent().html(
                                        '<div class="text-center py-4"><p class="text-muted">कोई प्रशंसापत्र अनुमोदन की प्रतीक्षा में नहीं है।</p></div>'
                                    );
                                }
                            });
                        },
                        error: function(xhr, status, error) {
                            hideLoading();
                            console.error('Error approving testimonial:', error);
                            
                            let errorMessage = 'कोई त्रुटि हुई। कृपया पुनः प्रयास करें।';
                            if (xhr.responseJSON && xhr.responseJSON.message) {
                                errorMessage = xhr.responseJSON.message;
                            } else if (xhr.status === 401) {
                                errorMessage = 'आपका सेशन समाप्त हो गया है। कृपया पुनः लॉगिन करें।';
                            } else if (xhr.status === 403) {
                                errorMessage = 'आपको यह कार्य करने की अनुमति नहीं है।';
                            }
                            
                            showError(errorMessage);
                        }
                    });
                }
            }
        });
    });

    // Reject testimonial
    $(document).on('click', '.reject-btn', function() {
        const testimonialId = $(this).data('id');
        const $row = $('#testimonial-' + testimonialId);
        
        bootbox.confirm({
            title: "पुष्टि करें",
            message: "क्या आप इस प्रशंसापत्र को अस्वीकृत करना चाहते हैं?",
            buttons: {
                confirm: {
                    label: 'हाँ, अस्वीकृत करें',
                    className: 'btn-danger'
                },
                cancel: {
                    label: 'रद्द करें',
                    className: 'btn-secondary'
                }
            },
            callback: function (result) {
                if (result) {
                    showLoading();
                    
                    $.ajax({
                        url: '/admin/testimonial/reject/' + testimonialId,
                        type: 'POST',
                        dataType: 'json',
                        headers: {
                            'Authorization': 'Bearer ' + getAuthToken(),
                            'Content-Type': 'application/json'
                        },
                        success: function(response) {
                            hideLoading();
                            showSuccess(response.message || 'प्रशंसापत्र सफलतापूर्वक अस्वीकृत किया गया।');
                            
                            // Remove row with animation
                            $row.fadeOut(500, function() {
                                $(this).remove();
                                
                                // Update count
                                const remainingCount = $('#pendingTestimonialsTable tbody tr').length - 1;
                                $('.card-header .mb-0').html('<i class="fas fa-clock"></i> अनुमोदन की प्रतीक्षा में (' + remainingCount + ')');
                                
                                // Show empty message if no pending testimonials
                                if (remainingCount === 0) {
                                    $('#pendingTestimonialsTable').parent().html(
                                        '<div class="text-center py-4"><p class="text-muted">कोई प्रशंसापत्र अनुमोदन की प्रतीक्षा में नहीं है।</p></div>'
                                    );
                                }
                            });
                        },
                        error: function(xhr, status, error) {
                            hideLoading();
                            console.error('Error rejecting testimonial:', error);
                            
                            let errorMessage = 'कोई त्रुटि हुई। कृपया पुनः प्रयास करें।';
                            if (xhr.responseJSON && xhr.responseJSON.message) {
                                errorMessage = xhr.responseJSON.message;
                            } else if (xhr.status === 401) {
                                errorMessage = 'आपका सेशन समाप्त हो गया है। कृपया पुनः लॉगिन करें।';
                            } else if (xhr.status === 403) {
                                errorMessage = 'आपको यह कार्य करने की अनुमति नहीं है।';
                            }
                            
                            showError(errorMessage);
                        }
                    });
                }
            }
        });
    });

    // Toggle active status
    $(document).on('click', '.toggle-btn', function() {
        const testimonialId = $(this).data('id');
        const isActive = $(this).data('active');
        const $button = $(this);
        const $badge = $('#status-badge-' + testimonialId);
        const $icon = $('#toggle-icon-' + testimonialId);
        const $text = $('#toggle-text-' + testimonialId);
        
        const actionText = isActive ? 'छुपाना' : 'दिखाना';
        
        bootbox.confirm({
            title: "पुष्टि करें",
            message: `क्या आप इस प्रशंसापत्र को ${actionText} चाहते हैं?`,
            buttons: {
                confirm: {
                    label: 'हाँ',
                    className: 'btn-primary'
                },
                cancel: {
                    label: 'रद्द करें',
                    className: 'btn-secondary'
                }
            },
            callback: function (result) {
                if (result) {
                    showLoading();
                    
                    $.ajax({
                        url: '/admin/testimonial/toggle/' + testimonialId,
                        type: 'POST',
                        dataType: 'json',
                        headers: {
                            'Authorization': 'Bearer ' + getAuthToken(),
                            'Content-Type': 'application/json'
                        },
                        success: function(response) {
                            hideLoading();
                            showSuccess(response.message || 'स्थिति सफलतापूर्वक अपडेट की गई।');
                            
                            // Update UI elements
                            const newActive = !isActive;
                            $button.data('active', newActive);
                            
                            if (newActive) {
                                $badge.removeClass('bg-secondary').addClass('bg-success').text('सक्रिय');
                                $icon.removeClass('fa-toggle-off').addClass('fa-toggle-on');
                                $text.text('छुपाएं');
                            } else {
                                $badge.removeClass('bg-success').addClass('bg-secondary').text('निष्क्रिय');
                                $icon.removeClass('fa-toggle-on').addClass('fa-toggle-off');
                                $text.text('दिखाएं');
                            }
                        },
                        error: function(xhr, status, error) {
                            hideLoading();
                            console.error('Error toggling testimonial:', error);
                            
                            let errorMessage = 'कोई त्रुटि हुई। कृपया पुनः प्रयास करें।';
                            if (xhr.responseJSON && xhr.responseJSON.message) {
                                errorMessage = xhr.responseJSON.message;
                            } else if (xhr.status === 401) {
                                errorMessage = 'आपका सेशन समाप्त हो गया है। कृपया पुनः लॉगिन करें।';
                            } else if (xhr.status === 403) {
                                errorMessage = 'आपको यह कार्य करने की अनुमति नहीं है।';
                            }
                            
                            showError(errorMessage);
                        }
                    });
                }
            }
        });
    });
});
</script>

<style>
.success-modal .modal-header {
    background-color: #d4edda;
    border-color: #c3e6cb;
}

.error-modal .modal-header {
    background-color: #f8d7da;
    border-color: #f5c6cb;
}

.table th {
    background-color: #f8f9fa;
    font-weight: 600;
}

.btn-group .btn {
    margin-right: 5px;
}

.btn-group .btn:last-child {
    margin-right: 0;
}

.message-preview, .message-full {
    line-height: 1.4;
}

.expand-btn {
    color: #007bff;
    text-decoration: none;
    font-size: 0.875rem;
}

.expand-btn:hover {
    text-decoration: underline;
}

.spinner-border {
    width: 3rem;
    height: 3rem;
}

.fade-out {
    opacity: 0;
    transition: opacity 0.5s ease-out;
}
</style>

