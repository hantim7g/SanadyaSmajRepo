<%@ include file="/WEB-INF/views/includes/header.jsp" %>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>


<!DOCTYPE html>
<html>
<head>
    <title>लॉगिन - सनाढ्य ब्राह्मण सभा, कोटा</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: #fff3e0;
        }
        .login-container {
            max-width: 400px;
            margin: 80px auto;
            background: #ffffff;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 8px 16px rgba(255, 102, 0, 0.3);
        }
        .login-title {
            color: #ff6600;
            text-align: center;
            margin-bottom: 20px;
        }
        .btn-orange {
            background-color: #ff6600;
            color: white;
        }
        .btn-orange:hover {
            background-color: #e65c00;
        }
    </style>
</head>
<body>

<div class="container login-container">
    <h2 class="login-title">लॉगिन करें</h2>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <form method="post" action="${pageContext.request.contextPath}/api/auth/login" id="loginForm">
        <div class="mb-3">
            <label for="mobile" class="form-label">मोबाइल नंबर</label>
            <input type="text" class="form-control" id="mobile" name="mobile" required>
        </div>

        <div class="mb-3">
            <label for="password" class="form-label">पासवर्ड</label>
            <input type="password" class="form-control" id="password" name="password" required>
        </div>

        <button type="submit" class="btn btn-orange w-100">लॉगिन</button>
    </form>

    <div class="text-center mt-3">
        <a href="/register.jsp">नया खाता बनाएँ</a>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script>
    $("#loginForm").on("submit", function (e) {
        e.preventDefault();
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/api/auth/login",
            contentType: "application/json",
            data: JSON.stringify({
                mobile: $("#mobile").val(),
                password: $("#password").val()
            }),
            success: function (response) {
                localStorage.setItem("token", response.data.token);
                window.location.href = "/home.jsp";
            },
            error: function () {
                alert("लॉगिन विफल हुआ। कृपया मोबाइल और पासवर्ड जांचें।");
            }
        });
    });
</script>

</body>
</html>
