<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>

<html>
<head>
  <title>Event Form</title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"/>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <style>
    .image-preview {
      max-height: 100px;
      margin-top: 5px;
    }
  </style>
</head>
<body>
<div class="container mt-5">
  <h2>${event.id == null ? "Create Event" : "Update Event"}</h2>
  <form id="eventForm" enctype="multipart/form-data">
    <input type="hidden" name="id" value="${event.id}"/>

    <div class="form-group">
      <label>Title</label>
      <input type="text" name="title" class="form-control" value="${event.title}" required />
    </div>

    <div class="form-group">
      <label>Description</label>
      <textarea name="content" class="form-control" required>${event.content}</textarea>
    </div>

    <div class="form-group">
      <label>Main Image</label>
      <input type="file" name="mainImage" class="form-control" />
      <c:if test="${not empty event.mainImageUrl}">
        <img src="${event.mainImageUrl}" class="image-preview" />
      </c:if>
    </div>

    <label>Gallery Images</label>
    <div id="image-section">
      <c:forEach var="img" items="${event.images}" varStatus="status">
        <div class="row image-row mb-2">
          <input type="hidden" name="images[${status.index}].id" value="${img.id}" />
          <div class="col-md-3">
            <input type="file" name="imageFiles[${status.index}]" class="form-control image-input" />
            <c:if test="${not empty img.url}">
              <img src="${img.url}" class="image-preview" />
            </c:if>
          </div>
          <div class="col-md-3">
            <input type="text" name="images[${status.index}].caption" class="form-control" placeholder="Caption" value="${img.caption}" />
          </div>
          <div class="col-md-3">
            <input type="text" name="images[${status.index}].altText" class="form-control" placeholder="Alt Text" value="${img.altText}" />
          </div>
          <div class="col-md-2">
            <button type="button" class="btn btn-danger remove-image">Remove</button>
          </div>
        </div>
      </c:forEach>
    </div>
    <button type="button" class="btn btn-secondary" id="addImageBtn">Add Image</button>

    <button type="submit" class="btn btn-primary mt-3">Submit</button>
  </form>
</div>

<script>
  let imageIndex = ${event.images != null ? event.images.size() : 0};

  $('#addImageBtn').click(function () {
    $('#image-section').append(`
      <div class="row image-row mb-2">
        <div class="col-md-3">
          <input type="file" name="imageFiles[${imageIndex}]" class="form-control image-input" />
          <img class="image-preview" style="display:none;" />
        </div>
        <div class="col-md-3">
          <input type="text" name="images[${imageIndex}].caption" class="form-control" placeholder="Caption" />
        </div>
        <div class="col-md-3">
          <input type="text" name="images[${imageIndex}].altText" class="form-control" placeholder="Alt Text" />
        </div>
        <div class="col-md-2">
          <button type="button" class="btn btn-danger remove-image">Remove</button>
        </div>
      </div>
    `);
    imageIndex++;
  });

  $(document).on('change', '.image-input', function () {
    const input = this;
    const preview = $(this).siblings('.image-preview');
    if (input.files && input.files[0]) {
      const reader = new FileReader();
      reader.onload = function (e) {
        preview.attr('src', e.target.result).show();
      };
      reader.readAsDataURL(input.files[0]);
    }
  });

  $(document).on('click', '.remove-image', function () {
    $(this).closest('.image-row').remove();
  });

  $('#eventForm').submit(function (e) {
    e.preventDefault();
    const formData = new FormData(this);

    $.ajax({
      url: '/admin/event/save',
      type: 'POST',
      data: formData,
      enctype: 'multipart/form-data',
      processData: false,
      contentType: false,
      success: function () {
        alert("Event saved successfully!");
        window.location.href = "/events/list";
      },
      error: function () {
        alert("Error saving event");
      }
    });
  });
</script>
</body>
</html>
