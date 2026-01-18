<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <title>Create Message</title>
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <link href="<c:url value='/webjars/bootstrap/5.3.3/css/bootstrap.min.css'/>" rel="stylesheet" />
            <style>
                .form-section-title {
                    font-weight: 600;
                    margin-top: 24px;
                }

                .img-preview {
                    max-width: 220px;
                    max-height: 220px;
                    display: none;
                    border: 1px solid #dee2e6;
                    border-radius: 6px;
                }

                .required::after {
                    content: " *";
                    color: #dc3545;
                }

                .help-text {
                    font-size: 0.9rem;
                    color: #6c757d;
                }

                .card {
                    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.06);
                }
            </style>
        </head>

        <body>
            <div class="container py-4">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h3 class="mb-0">Create Message</h3>
                    <a class="btn btn-outline-secondary btn-sm" href="<c:url value='/admin/messages'/>">Back</a>
                </div>

                <div class="card">
                    <div class="card-body">
                        <form id="messageForm" action="<c:url value='/admin/messages'/>" method="post"
                            enctype="multipart/form-data" novalidate>
                            <div class="row g-3">
                                <div class="col-12">
                                    <label class="form-label required">Title</label>
                                    <input type="text" name="title" class="form-control" maxlength="200" required />
                                    <div class="invalid-feedback">Title is required.</div>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label">Author Name</label>
                                    <input type="text" name="authorName" class="form-control" maxlength="200" />
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Author Title</label>
                                    <input type="text" name="authorTitle" class="form-control" maxlength="200" />
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Author Subtitle</label>
                                    <input type="text" name="authorSubtitle" class="form-control" maxlength="250" />
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">City/Area</label>
                                    <input type="text" name="cityOrArea" class="form-control" maxlength="120" />
                                </div>

                                <div class="col-12">
                                    <label class="form-label">Lead</label>
                                    <textarea name="lead" class="form-control" rows="3" maxlength="1000"
                                        placeholder="Short intro paragraph"></textarea>
                                </div>

                                <div class="col-lg-6">
                                    <label class="form-label">Content (Plain)</label>
                                    <textarea name="content" class="form-control" rows="7"
                                        placeholder="Plain text content"></textarea>
                                    <div class="help-text">If HTML is provided below, it will be used instead of plain
                                        text.</div>
                                </div>
                                <div class="col-lg-6">
                                    <label class="form-label">Content (HTML)</label>
                                    <textarea name="contentHtml" class="form-control" rows="7"
                                        placeholder="&lt;p&gt;Formatted HTML&lt;/p&gt;"></textarea>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label">Quote</label>
                                    <input type="text" name="quote" class="form-control" maxlength="1000" />
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label">Date Text</label>
                                    <input type="text" name="dateText" class="form-control" maxlength="120"
                                        placeholder="e.g., 15 Aug 2025" />
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label">Signature Name</label>
                                    <input type="text" name="signatureName" class="form-control" maxlength="200" />
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label">Signature Designation</label>
                                    <input type="text" name="signatureDesignation" class="form-control"
                                        maxlength="200" />
                                </div>

                                <div class="col-12">
                                    <label class="form-label">Footer Note</label>
                                    <textarea name="footerNote" class="form-control" rows="3"
                                        maxlength="1000"></textarea>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label">Page Number</label>
                                    <input type="text" name="pageNumber" class="form-control" maxlength="20" />
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label">Photo (PNG/JPG/WEBP)</label>
                                    <input type="file" id="photo" name="photo" accept="image/png,image/jpeg,image/webp"
                                        class="form-control" />
                                    <div class="help-text">Max 5MB. Stored under /images/ for serving.</div>
                                    <img id="photoPreview" class="img-preview mt-2" alt="Preview" />
                                </div>
                            </div>

                            <hr class="my-4" />

                            <div class="d-flex gap-2">
                                <button type="submit" class="btn btn-primary">Save</button>
                                <a href="<c:url value='/admin/messages'/>" class="btn btn-outline-secondary">Cancel</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <script src="<c:url value='/webjars/jquery/3.7.1/jquery.min.js'/>"></script>
            <script src="<c:url value='/webjars/bootstrap/5.3.3/js/bootstrap.bundle.min.js'/>"></script>
            <script>
                (function () {
                    const form = document.getElementById('messageForm');
                    form.addEventListener('submit', function (event) {
                        if (!form.checkValidity()) {
                            event.preventDefault();
                            event.stopPropagation();
                        }
                        form.classList.add('was-validated');
                    }, false);

                    $('#photo').on('change', function () {
                        const file = this.files && this.files[0];
                        const $preview = $('#photoPreview');
                        if (!file) {
                            $preview.hide().attr('src', '');
                            return;
                        }
                        if (!/^image\\/(png | jpe ? g | webp)$ / i.test(file.type)) {
                        alert('Only PNG/JPG/WEBP images are allowed.');
                        this.value = '';
                        $preview.hide().attr('src', '');
                        return;
                    }
                    if (file.size > 5 * 1024 * 1024) {
                        alert('File too large. Max 5MB.');
                        this.value = '';
                        $preview.hide().attr('src', '');
                        return;
                    }
                    const reader = new FileReader();
                    reader.onload = function (e) {
                        $preview.attr('src', e.target.result).show();
                    };
                    reader.readAsDataURL(file);
                });
}) ();
            </script>
        </body>

        </html> 			<%@ include file="/WEB-INF/views/includes/footer.jsp" %>