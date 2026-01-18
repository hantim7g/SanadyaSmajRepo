<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="hi">
<head>
<meta charset="UTF-8">
<title>पर्व और त्यौहार</title>


<style>
body { background:#fff8ef; font-family:'Noto Sans Devanagari', sans-serif; }

.page-header {
  background:#b45f06;
  color:#fff;
  padding:14px 20px;
  font-weight:700;
  border-radius:8px;
  box-shadow:0 4px 12px rgba(0,0,0,.2);
}

.festival-box {
  background:#fff;
  border-radius:14px;
  padding:18px;
  box-shadow:0 6px 18px rgba(0,0,0,.08);
  transition:.3s;
}
.festival-box:hover {
  transform:translateY(-4px);
  box-shadow:0 10px 24px rgba(180,95,6,.35);
}

.festival-date {
  font-weight:700;
  color:#c04b00;
}
.festival-name {
  font-weight:700;
  font-size:1.05rem;
}
.admin-actions a { margin-left:8px; text-decoration:none; }
</style>
</head>

<body>

<div class="container my-4">

<div class="page-header mb-3">⭐ पर्व और त्यौहार</div>

<c:if test="${isAdmin}">
  <div class="text-end mb-3">
    <button class="btn btn-success btn-sm" data-bs-toggle="modal" data-bs-target="#festivalModal">
      + नया पर्व जोड़ें
    </button>
  </div>
</c:if>

<div class="row g-3">
<c:forEach items="${festivalList}" var="f">
  <div class="col-12">
    <div class="festival-box d-flex justify-content-between">

      <div>
        <div class="festival-date">📅 ${f.festivalDate}</div>
        <div class="festival-name mt-1">⭐ ${f.festivalName}</div>
        <div class="mt-1">${f.description}</div>
      </div>

      <c:if test="${isAdmin}">
        <div class="admin-actions">
          <a href="#" class="edit-btn text-primary"
             data-id="${f.id}"
             data-date="${f.rawDate}"
             data-name="${f.festivalName}"
             data-desc="${f.description}">✏️</a>

          <a href="#" class="delete-btn text-danger" data-id="${f.id}">🗑️</a>
        </div>
      </c:if>

    </div>
  </div>
</c:forEach>
</div>

</div>

<!-- Modal -->
<div class="modal fade" id="festivalModal">
  <div class="modal-dialog">
    <form class="modal-content" id="festivalForm">
      <div class="modal-header">
        <h5 class="modal-title">पर्व और त्यौहार</h5>
        <button class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body">
        <input type="hidden" id="id">

        <label>तिथि</label>
        <input type="date" class="form-control mb-2" id="festivalDate" required>

        <label>पर्व का नाम</label>
        <input class="form-control mb-2" id="festivalName" required>

        <label>विवरण</label>
        <textarea class="form-control" id="description"></textarea>
      </div>
      <div class="modal-footer">
        <button class="btn btn-success">सहेजें</button>
      </div>
    </form>
  </div>
</div>


<script>
$(".edit-btn").click(function(){
  $("#id").val($(this).data("id"));
  $("#festivalDate").val($(this).data("date"));
  $("#festivalName").val($(this).data("name"));
  $("#description").val($(this).data("desc"));
  $("#festivalModal").modal("show");
});

$(".delete-btn").click(function(){
  let id=$(this).data("id");
  bootbox.confirm({
    title:"पुष्टि करें",
    message:"क्या आप यह पर्व हटाना चाहते हैं?",
    centerVertical:true,
    callback:function(result){
      if(result){
        $.ajax({
          url:"/admin/festival/delete/"+id,
          type:"DELETE",
          success:()=>location.reload()
        });
      }
    }
  });
});

$("#festivalForm").submit(function(e){
  e.preventDefault();
  $.post("/admin/festival/save",{
    id:$("#id").val(),
    festivalDate:$("#festivalDate").val(),
    festivalName:$("#festivalName").val(),
    description:$("#description").val()
  },()=>location.reload());
});
</script>

</body>
</html>
