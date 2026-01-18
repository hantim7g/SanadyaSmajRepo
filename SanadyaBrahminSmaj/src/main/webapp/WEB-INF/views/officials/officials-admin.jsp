<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>


    <%@ include file="/WEB-INF/views/includes/header.jsp" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
            <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="hi">
<head>
  <title>पदाधिकारी प्रबंधन</title>

  <!-- Bootstrap -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

  <!-- jQuery -->
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

  <!-- jQuery UI (Drag & Drop) -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.13.2/jquery-ui.min.css">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.13.2/jquery-ui.min.js"></script>

  <!-- Cropper -->
  <link rel="stylesheet" href="https://unpkg.com/cropperjs/dist/cropper.css">
  <script src="https://unpkg.com/cropperjs/dist/cropper.js"></script>

  <style>
    .square-img {
      width: 120px;
      height: 120px;
      object-fit: cover;
      border-radius: 10px;
      border: 3px solid #f87e03;
    }

    .officer-card {
      cursor: move;
    }

    .inactive {
      opacity: 0.5;
    }
  </style>
</head>

<body>

<div class="container mt-4">
  <h3 class="mb-3">पदाधिकारी प्रबंधन</h3>

  <button class="btn btn-success mb-3" onclick="openModal()">+ नया जोड़ें</button>

  <div id="sortable" class="row">
    <c:forEach items="${officials}" var="o">
      <div class="col-md-3 mb-3 officer-card ${!o.active ? 'inactive' : ''}"
           data-id="${o.id}">
        <div class="card p-2 text-center">
          <img src="${o.imageUrl}" class="square-img mx-auto">
          <div class="fw-bold mt-2">${o.name}</div>
          <div class="text-warning">${o.designation}</div>

          <div class="mt-2">
            <button class="btn btn-sm btn-primary"
                    onclick="editOfficer(${o.id},'${o.name}','${o.designation}','${o.imageUrl}')">
              Edit
            </button>

            <button class="btn btn-sm btn-secondary"
                    onclick="toggle(${o.id})">
              ${o.active ? 'Hide' : 'Show'}
            </button>
          </div>
        </div>
      </div>
    </c:forEach>
  </div>
</div>

<!-- MODAL -->
<div class="modal fade" id="officerModal">
  <div class="modal-dialog">
    <div class="modal-content p-3">
      <form id="officerForm">
        <input type="hidden" name="id" id="id">
        <input type="hidden" name="imageUrl" id="imageUrl">

        <input class="form-control mb-2" name="name" id="name" placeholder="नाम" required>
        <input class="form-control mb-2" name="designation" id="designation" placeholder="पद" required>

        <img id="preview" class="square-img d-none mb-2">

        <input type="file" id="imgInput" class="form-control mb-2">

        <button class="btn btn-success w-100">Save</button>
      </form>
    </div>
  </div>
</div>

<!-- JS -->
<script>
let cropper;

/* Drag & Drop */
$("#sortable").sortable({
  update: function () {
    let ids = [];
    $(".officer-card").each(function () {
      ids.push($(this).data("id"));
    });

    $.ajax({
      url: "/officials/admin/order",
      method: "POST",
      contentType: "application/json",
      data: JSON.stringify(ids)
    });
  }
});

/* Toggle Active */
function toggle(id) {
  $.post("/officials/admin/toggle/" + id, () => location.reload());
}

/* Modal */
function openModal() {
  $("#officerForm")[0].reset();
  $("#preview").addClass("d-none");
  $("#officerModal").modal("show");
}

/* Edit */
function editOfficer(id, name, desig, img) {
  $("#id").val(id);
  $("#name").val(name);
  $("#designation").val(desig);
  $("#imageUrl").val(img);
  $("#preview").attr("src", img).removeClass("d-none");
  $("#officerModal").modal("show");
}

/* Image Crop */
$("#imgInput").on("change", function (e) {
  const reader = new FileReader();
  reader.onload = function () {
    $("#preview").attr("src", reader.result).removeClass("d-none");
    cropper = new Cropper(document.getElementById("preview"), {
      aspectRatio: 1
    });
  };
  reader.readAsDataURL(e.target.files[0]);
});

/* Save */
$("#officerForm").submit(function (e) {
  e.preventDefault();
  $.post("/officials/admin/save", $(this).serialize(), () => location.reload());
});
</script>

</body>
</html> 			<%@ include file="/WEB-INF/views/includes/footer.jsp" %>
