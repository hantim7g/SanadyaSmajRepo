<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<style>
  /* Optional clamp for table cell previews */
  #pendingTestimonialsTable .message-preview,
  #approvedTestimonialsTable .message-preview {
    display: -webkit-box;
    -webkit-line-clamp: 3;
    -webkit-box-orient: vertical;
    overflow: hidden;
  }
</style>

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
                                        <td>${testimonial.formattedCreatedDate}</td>
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
                                        <td>${testimonial.formattedApprovedDate}</td>
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

<script>
$(document).ready(function() {
    
    function getAuthToken() {
        return localStorage.getItem('authToken');
    }
    
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
                    $.ajax({
                        url: '/admin/testimonial/approve/' + testimonialId,
                        type: 'POST',
                        dataType: 'json',
                        headers: {
                            'Authorization': 'Bearer ' + getAuthToken(),
                            'Content-Type': 'application/json'
                        },
                        success: function(response) {
                            bootbox.alert(response.message || 'प्रशंसापत्र सफलतापूर्वक स्वीकृत किया गया।');
                            $row.fadeOut(500, function() {
                                $(this).remove();
                                const remainingCount = $('#pendingTestimonialsTable tbody tr').length - 1;
                                $('.card-header .mb-0').first().html('<i class="fas fa-clock"></i> अनुमोदन की प्रतीक्षा में (' + remainingCount + ')');
                                if (remainingCount === 0) {
                                    $('#pendingTestimonialsTable').parent().html('<div class="text-center py-4"><p class="text-muted">कोई प्रशंसापत्र अनुमोदन की प्रतीक्षा में नहीं है।</p></div>');
                                }
                            });
                        },
                        error: function(xhr, status, error) {
                            let errorMessage = 'कोई त्रुटि हुई। कृपया पुनः प्रयास करें।';
                            if (xhr.responseJSON && xhr.responseJSON.message) {
                                errorMessage = xhr.responseJSON.message;
                            }
                            bootbox.alert(errorMessage);
                        }
                    });
                }
            }
        });
    });

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
                    $.ajax({
                        url: '/admin/testimonial/reject/' + testimonialId,
                        type: 'POST',
                        dataType: 'json',
                        headers: {
                            'Authorization': 'Bearer ' + getAuthToken(),
                            'Content-Type': 'application/json'
                        },
                        success: function(response) {
                            bootbox.alert(response.message || 'प्रशंसापत्र सफलतापूर्वक अस्वीकृت किया गया।');
                            $row.fadeOut(500, function() {
                                $(this).remove();
                                const remainingCount = $('#pendingTestimonialsTable tbody tr').length - 1;
                                $('.card-header .mb-0').first().html('<i class="fas fa-clock"></i> अनुमोदन की प्रतीक्षा में (' + remainingCount + ')');
                                if (remainingCount === 0) {
                                    $('#pendingTestimonialsTable').parent().html('<div class="text-center py-4"><p class="text-muted">कोई प्रशंसापत्र अनुमोदन की प्रतीक्षा में नहीं है।</p></div>');
                                }
                            });
                        },
                        error: function(xhr, status, error) {
                            let errorMessage = 'कोई त्रुटि हुई। कृपया पुनः प्रयास करें।';
                            if (xhr.responseJSON && xhr.responseJSON.message) {
                                errorMessage = xhr.responseJSON.message;
                            }
                            bootbox.alert(errorMessage);
                        }
                    });
                }
            }
        });
    });

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
                    $.ajax({
                        url: '/admin/testimonial/toggle/' + testimonialId,
                        type: 'POST',
                        dataType: 'json',
                        headers: {
                            'Authorization': 'Bearer ' + getAuthToken(),
                            'Content-Type': 'application/json'
                        },
                        success: function(response) {
                            bootbox.alert(response.message || 'स्थिति सफलतापूर्वक अपडेट की गई।');
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
                            let errorMessage = 'कोई त्रुटि हुई। कृपया पुनः प्रयास करें।';
                            if (xhr.responseJSON && xhr.responseJSON.message) {
                                errorMessage = xhr.responseJSON.message;
                            }
                            bootbox.alert(errorMessage);
                        }
                    });
                }
            }
        });
    });
});
</script>
<script>
$(document).ready(function() {
  // If DataTables is already initialized by re-render, destroy and re-init safely
  function ensureTable(tableSelector, options) {
    const $t = $(tableSelector);
    if (!$t.length) return null;
    if ($.fn.DataTable.isDataTable($t)) {
      $t.DataTable().destroy();
    }
    return $t.DataTable(options);
  }

  const commonOpts = {
    responsive: true,
    pageLength: 10,
    lengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, 'सभी']],
    order: [], // no initial sort; let user decide
    language: {
      search: 'खोजें:',
      lengthMenu: 'प्रति पृष्ठ _MENU_',
      info: 'कुल _TOTAL_ में से _START_–_END_ दिखा रहे हैं',
      infoEmpty: 'कोई प्रविष्टि नहीं',
      infoFiltered: '(फ़िल्टर किया गया _MAX_ से)',
      zeroRecords: 'कोई मेल नहीं मिला',
      paginate: { first: 'पहला', last: 'अंतिम', next: 'अगला', previous: 'पिछला' }
    },
    dom: 'Bfrtip',
    buttons: [
      { extend: 'csvHtml5', text: 'CSV', title: 'testimonials' },
      { extend: 'pdfHtml5', text: 'PDF', title: 'testimonials', orientation: 'portrait', pageSize: 'A4' },
      { extend: 'print', text: 'प्रिंट' }
    ],
    columnDefs: [
      // Member column (avatar+name) not sortable
      { targets: 0, orderable: false },
      // Message column: allow sorting but it’s long text; keep as is
      // Actions column not sortable
      { targets: -1, orderable: false }
    ]
  };

  // Pending table
  ensureTable('#pendingTestimonialsTable', $.extend(true, {}, commonOpts, {
    // e.g., default sort by Date desc (column index 3)
    order: [[3, 'desc']]
  }));

  // Approved table
  ensureTable('#approvedTestimonialsTable', $.extend(true, {}, commonOpts, {
    // default sort by Approved Date desc (column index 3)
    order: [[3, 'desc']]
  }));
});
</script>

