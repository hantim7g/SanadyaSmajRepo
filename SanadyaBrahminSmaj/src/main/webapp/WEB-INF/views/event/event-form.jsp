<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ include file="/WEB-INF/views/includes/header.jsp" %>
<!DOCTYPE html>
<html lang="hi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>कार्यक्रम प्रबंधन | सनाढ्य ब्राह्मण सभा</title>

<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+Devanagari:wght@600&display=swap" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script> -->
<style>
  body {
    background-color: #fffaf0;
    font-family: 'Noto Sans Devanagari', 'Segoe UI', sans-serif;
  }
  .card {
    border-radius: 16px;
    box-shadow: 0 8px 24px 0 rgba(248,126,3,0.10), 0 2px 8px 0 rgba(182,92,2,0.08);
    border: none;
    background: #fff;
    margin-top: 2.5rem;
  }
  .card-header {
    border-radius: 16px 16px 0 0;
    background: linear-gradient(90deg, #f87e03 0%, #b65c02 100%);
    color: #fff;
    font-size: 1.18rem;
    font-weight: bold;
    text-align: center;
    letter-spacing: .6px;
  }
  .form-label, label {
    font-weight: 600;
    color: #b65c02;
    margin-bottom: 4px;
    font-size: 1.06rem;
    letter-spacing: .2px;
  }
  .form-control, textarea.form-control {
    border-radius: 7px;
    border: 1.3px solid #ffe6bd;
    background: #fffbe9;
    transition: border-color 0.18s;
    font-size: 1rem;
  }
  .form-control:focus {
    border-color: #ffa600;
    box-shadow: 0 0 0 .18rem #ffa60021;
  }
  .image-preview {
    max-height: 80px;
    margin-top: 5px;
    border-radius: 6px;
    border: 1px solid #ffe6bd;
    background: #fffaf6;
    box-shadow: 0 1px 5px #f7d38767;
    display: block;
  }
  .image-row {
    background: #fff7e6;
    border-radius: 7px;
    box-shadow: 0 1px 3px #ffd69b4a;
    padding-bottom: 9px;
    margin-bottom: .6rem;
  }
  .gallery-divider {
    height: 2.5px;
    background: linear-gradient(90deg, #f87e03 20%, #facc8a 100%);
    border-radius: 1px;
    margin: 1.4rem 0 .8rem;
  }
  .btn-primary {
    background: linear-gradient(94deg, #f87e03, #b65c02);
    border: none;
    font-weight: 600;
    font-size: 1.1rem;
    padding: .47rem 2.1rem;
    border-radius: 23px;
    letter-spacing: .7px;
    box-shadow: 0 2px 8px 1px #f4b06e38;
    transition: background .18s;
  }
  .btn-primary:hover {
    background: linear-gradient(104deg, #ffa600 0%, #b65c02 100%);
  }
  .btn-secondary {
    background: #fff5d9;
    border: 1px solid #fea4206a;
    color: #a65006;
    font-weight: 600;
    border-radius: 21px;
    padding: .37rem 1.12rem;
    font-size: 0.99rem;
    transition: background .18s;
  }
  .btn-secondary:hover {
    background: #ffedcc;
    color: #824101;
  }
  .btn-danger {
    border-radius: 17px;
    font-size: .96rem;
    padding: .28rem 1.1rem;
    box-shadow: none;
  }
  .btn:focus {
    outline: none !important;
    box-shadow: 0 0 0 1.5px #facc8a80;
  }
  .text-end {
    text-align: right;
  }
  @media (max-width: 600px) {
    .card {border-radius: 10px;}
    .card-header {font-size: 1rem;}
    .image-preview {max-width: 90vw;}
    .form-label {font-size: .97rem;}
  }
</style>
</head>
<body>
  <div class="container">
    <div class="card shadow">
      <div class="card-header">
        ${event.id == null ? "नया कार्यक्रम जोड़ें" : "कार्यक्रम संपादित करें"}
      </div>
      <div class="card-body px-4 pb-2 pt-3">
        <form id="eventForm" enctype="multipart/form-data" method="post"
          action="${event.id == null ? '/admin/event/save' : '/admin/event/save'}">
          <input type="hidden" name="id" value="${event.id}" />

          <div class="form-group mb-3">
            <label for="title" class="form-label">शीर्षक</label>
            <input type="text" name="title" id="title" class="form-control" value="${event.title}" required />
          </div>

          <div class="form-group mb-3">
            <label for="content" class="form-label">विवरण</label>
            <textarea name="content" id="content" class="form-control" rows="4" required>${event.content}</textarea>
          </div>

          <div class="form-group mb-3">
            <label for="author" class="form-label">लेखक</label>
            <input type="text" name="author" id="author" class="form-control" value="${event.author}" />
          </div>

          <div class="row mb-3">
            <div class="col-md-6">
              <label for="publishDate" class="form-label">प्रकाशन तिथि</label>
              <input type="date" name="publishDate" id="publishDate" class="form-control"
                value="${event.publishDate != null ? event.publishDate : ''}" />
            </div>
            <div class="col-md-6">
              <label for="eventDate" class="form-label">कार्यक्रम तिथि</label>
              <input type="date" name="eventDate" id="eventDate" class="form-control"
                value="${event.eventDate != null ? event.eventDate : ''}" />
            </div>
          </div>

          <!--<div class="form-group mb-3">
            <label for="eventUrl" class="form-label">कार्यक्रम यूआरएल</label>
            <input type="text" name="eventUrl" id="eventUrl" class="form-control" value="${event.eventUrl}" />
          </div>-->

          <div class="row mb-3">
            <div class="col-md-6">
              <div class="form-check mt-2">
                <input type="checkbox" name="corosal" value="true" class="form-check-input" id="corosalCheck"
                  <c:if test="${event.corosal}">checked</c:if> />
                <label class="form-check-label" for="corosalCheck">क्या इसे करोसाल में दिखाना है?</label>
              </div>
            </div>
            <div class="col-md-6">
              <div class="form-check mt-2">
                <input type="checkbox" name="eventStatus" value="true" class="form-check-input" id="statusCheck"
                  <c:if test="${event.eventStatus}">checked</c:if> />
                <label class="form-check-label" for="statusCheck">कार्यक्रम स्थिति (दिखाएं)</label>
              </div>
            </div>
          </div>

          <div class="form-group mb-4">
            <label for="mainImage" class="form-label">मुख्य इमेज</label>
            <input type="file" name="mainImage" id="mainImage" class="form-control" />
            <c:if test="${not empty event.mainImageUrl}">
              <img src="${event.mainImageUrl}" class="image-preview" />
            </c:if>
          </div>

          <div class="gallery-divider"></div>
          <label class="form-label mb-1">गैलरी इमेज</label>
          <div id="image-section">
            <c:forEach var="img" items="${event.images}" varStatus="status">
              <div class="row image-row mb-2 align-items-center">
                <input type="hidden" name="images[${status.index}].id" value="${img.id}" />
                <div class="col-sm-4 col-12 mb-1 mb-sm-0">
                  <input type="file" name="imageFiles" class="form-control image-input" />
                  <c:if test="${not empty img.url}">
                    <img src="${img.url}" class="image-preview mt-2" />
                  </c:if>
                </div>
                <div class="col-sm-3 col-12 mb-1 mb-sm-0">
                  <input type="text" name="images[${status.index}].caption" class="form-control"
                    placeholder="कैप्शन" value="${img.caption}" />
                </div>
                <div class="col-sm-3 col-12 mb-1 mb-sm-0">
                  <input type="text" name="images[${status.index}].altText" class="form-control"
                    placeholder="वैकल्पिक पाठ" value="${img.altText}" />
                </div>
                <div class="col-sm-2 col-12 text-sm-center text-left mt-1 mt-sm-0">
                  <button type="button" class="btn btn-danger remove-image">हटाएं</button>
                </div>
              </div>
            </c:forEach>
          </div>

          <div class="mb-2">
            <button type="button" class="btn btn-secondary" id="addImageBtn">नई इमेज जोड़ें</button>
          </div>
          <input type="hidden" id="imageIndex" value="${ event.images != null ? event.images.size() : 0 }" />
          <div class="text-end mt-4">
            <button type="submit" class="btn btn-primary">सबमिट करें</button>
          </div>
        </form>
      </div>
    </div>
  </div>
<script>
  let imageIndex = $('#imageIndex').val() || 0;
  $('#addImageBtn').click(function () {
    $('#image-section').append(`
      <div class="row image-row mb-2 align-items-center">
        <div class="col-sm-4 col-12 mb-1 mb-sm-0">
          <input type="file" name="imageFiles"  class="form-control image-input" />
          <img class="image-preview mt-2" style="display:none;" />
        </div>
        <div class="col-sm-3 col-12 mb-1 mb-sm-0">
          <input type="text" name="images[`+imageIndex+`].caption" class="form-control" placeholder="कैप्शन" />
        </div>
        <div class="col-sm-3 col-12 mb-1 mb-sm-0">
          <input type="text" name="images[`+imageIndex+`].altText" class="form-control" placeholder="वैकल्पिक पाठ" />
        </div>
        <div class="col-sm-2 col-12 text-sm-center text-left mt-1 mt-sm-0">
          <button type="button" class="btn btn-danger remove-image">हटाएं</button>
        </div>
      </div>
    `);
    $('#imageIndex').val(imageIndex++);
  });

  $(document).on('click', '.remove-image', function () {
    $(this).closest('.image-row').remove();
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
</script>
</body>
</html>
