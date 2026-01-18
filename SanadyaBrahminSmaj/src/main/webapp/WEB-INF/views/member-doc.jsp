<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>


    <%@ include file="/WEB-INF/views/includes/header.jsp" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
            <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html >
<head>


    <!-- Bootstrap -->
<!--    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
-->
    <!-- Icons -->
    <!--<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
-->
    <!-- jQuery -->
    <!--<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
-->
    <style>
        body {
            background: #f6f3ef;
            font-family: "Noto Serif Devanagari", serif;
        }

        .book-header {
            background: #5a2d0c;
            color: #fff;
            padding: 25px;
            border-radius: 12px;
            text-align: center;
            margin-bottom: 30px;
        }

        .book-header h2 {
            font-weight: bold;
        }

        .book-page {
            background: #fffaf3;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.08);
        }

        .rule-item {
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 1px dashed #c2b59b;
        }

        .rule-number {
            font-size: 20px;
            font-weight: bold;
            color: #7a3e0d;
        }

        .rule-title {
            font-size: 18px;
            font-weight: 600;
            color: #3e2723;
            margin-bottom: 6px;
        }

        .rule-desc {
            font-size: 16px;
            line-height: 1.8;
            color: #444;
            white-space: pre-line;
        }

        .status-badge {
            font-size: 12px;
        }

        .admin-actions button {
            margin-right: 5px;
        }

        .add-btn {
            border-radius: 25px;
        }
    </style>
</head>

<body>

<div class="container mt-4 mb-5">

    <!-- HEADER -->
    <div class="book-header shadow">
        <h2>📜 सदस्य निर्देशिका</h2>
    </div>

    <!-- ADMIN ADD BUTTON -->
    <c:if test="${admin}">
        <div class="text-end mb-3">
            <button class="btn btn-success add-btn" onclick="openAdd()">
                <i class="fa fa-plus"></i> नया नियम जोड़ें
            </button>
        </div>
    </c:if>

    <!-- BOOK PAGE -->
    <div class="book-page">

        <c:forEach items="${rules}" var="r" varStatus="i">
            <div class="rule-item">

                <!-- Rule Number -->
                <div class="rule-number">
                    ${i.count}.
                    <span class="rule-title">${r.ruleTitle}</span>
					<c:if test="${admin}">
                    <span class="badge ms-2 status-badge
                        ${r.active ? 'bg-success' : 'bg-danger'}">
                        ${r.active ? 'प्रभावी' : 'निष्क्रिय'}
                    </span></c:if>
                </div>

                <!-- Rule Description -->
                <div class="rule-desc mt-2">
                    ${r.ruleDescription}
                </div>

                <!-- ADMIN ACTIONS -->
                <c:if test="${admin}">
                    <div class="admin-actions mt-3">
                        <button class="btn btn-sm btn-warning" onclick="editRule(${r.id})">
                            <i class="fa fa-edit"></i> Edit
                        </button>

                        <button class="btn btn-sm btn-secondary" onclick="toggleRule(${r.id})">
                            <i class="fa fa-power-off"></i>
                            ${r.active ? 'Disable' : 'Enable'}
                        </button>

                        <button class="btn btn-sm btn-danger" onclick="deleteRule(${r.id})">
                            <i class="fa fa-trash"></i> Delete
                        </button>
                    </div>
                </c:if>

            </div>
        </c:forEach>

    </div>
</div>

<!-- MODAL (same as before) -->
<div class="modal fade" id="ruleModal">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content p-3">

            <h5 class="text-center mb-3">📜 नियम विवरण</h5>

            <input type="hidden" id="ruleId">

            <label>शीर्षक</label>
            <input class="form-control mb-2" id="ruleTitle">

            <label>विवरण</label>
            <textarea class="form-control mb-3" id="ruleDesc" rows="4"></textarea>

            <button class="btn btn-primary w-100" onclick="saveRule()">Save</button>
        </div>
    </div>
</div>

<script>
function openAdd(){
    $("#ruleId,#ruleTitle,#ruleDesc").val('');
    $("#ruleModal").modal('show');
}
function saveRule(){
    $.ajax({
        url:'/member/doc/save',
        type:'POST',
        contentType:'application/json',
        data:JSON.stringify({
            id:$("#ruleId").val(),
            ruleTitle:$("#ruleTitle").val(),
            ruleDescription:$("#ruleDesc").val()
        }),
        success:()=>location.reload()
    });
}
function editRule(id){
    $.get('/member/doc/get/'+id,function(d){
        $("#ruleId").val(d.id);
        $("#ruleTitle").val(d.ruleTitle);
        $("#ruleDesc").val(d.ruleDescription);
        $("#ruleModal").modal('show');
    });
}
function toggleRule(id){
    $.post('/member/doc/toggle/'+id,()=>location.reload());
}
function deleteRule(id){
    if(confirm("नियम हटाना चाहते हैं?")){
        $.ajax({url:'/member/doc/delete/'+id,type:'DELETE',success:()=>location.reload()});
    }
}
</script>

<!--<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
-->
</body>
</html> 			<%@ include file="/WEB-INF/views/includes/footer.jsp" %>
