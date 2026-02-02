<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="hi">
<head>
<meta charset="UTF-8">
<title>गोत्र सूची</title>

<style>
body { background:#fff8ef; font-family:'Noto Sans Devanagari', sans-serif; }

.page-header {
  background:#6f2dbd;
  color:#fff;
  padding:14px 20px;
  font-weight:700;
  border-radius:8px;
}

.gotra-box {
  background:#fff;
  border-radius:12px;
  padding:16px;
  box-shadow:0 6px 18px rgba(0,0,0,.08);
  display:flex;
  justify-content:space-between;
  align-items:center;
}
</style>
</head>

<body>

<div class="container my-4">

<div class="page-header mb-3">🕉️ सनाढ्य ब्राह्मण गोत्र सूची</div>

<c:if test="${isAdmin}">
  <div class="text-end mb-3">
    <button class="btn btn-success btn-sm" data-bs-toggle="modal" data-bs-target="#gotraModal">
      + नया गोत्र जोड़ें
    </button>
  </div>
</c:if>

<c:forEach items="${gotraList}" var="g">
  <div class="gotra-box mb-2">
    <div>
      <strong>${g.gotraName}</strong><br>
      <small>${g.samaj}</small>
    </div>

    <c:if test="${isAdmin}">
      <div>
        <a href="#" class="edit-btn text-primary"
           data-id="${g.id}"
           data-name="${g.gotraName}">✏️</a>

        <a href="#" class="delete-btn text-danger"
           data-id="${g.id}">🗑️</a>
      </div>
    </c:if>
  </div>
</c:forEach>

</div>

<!-- Modal -->
<div class="modal fade" id="gotraModal">
  <div class="modal-dialog">
    <form class="modal-content" id="gotraForm">
      <div class="modal-header">
        <h5 class="modal-title">गोत्र विवरण</h5>
        <button class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <div class="modal-body">
        <input type="hidden" id="id">
        <label>गोत्र का नाम</label>
        <input class="form-control" id="gotraName" required>
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
  $("#gotraName").val($(this).data("name"));
  $("#gotraModal").modal("show");
});

$(".delete-btn").click(function(){
  let id=$(this).data("id");
  bootbox.confirm({
    title:"पुष्टि करें",
    message:"क्या आप यह गोत्र हटाना चाहते हैं?",
    callback:function(result){
      if(result){
        $.ajax({
          url:"/admin/gotra/delete/"+id,
          type:"DELETE",
          success:()=>location.reload()
        });
      }
    }
  });
});

$("#gotraForm").submit(function(e){
  e.preventDefault();
  $.post("/admin/gotra/save",{
    id:$("#id").val(),
    gotraName:$("#gotraName").val()
  },()=>location.reload());
});
</script>

</body>
</html>
