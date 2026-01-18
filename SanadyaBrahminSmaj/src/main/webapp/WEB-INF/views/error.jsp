<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="hi">
          <%@ include file="/WEB-INF/views/includes/header.jsp" %>

<head>
    <meta charset="UTF-8">
    <title>त्रुटि पृष्ठ</title>
    <link href="https://fonts.googleapis.com/css2?family=Baloo+2&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Baloo 2', cursive;
            background-color: #f8f9fa;
        }

        .error-container {
            margin-top: 100px;
            text-align: center;
        }

        .error-code {
            font-size: 120px;
            font-weight: bold;
            color: #dc3545;
        }

        .error-message {
            font-size: 24px;
            color: #343a40;
            margin-bottom: 30px;
        }

        .home-btn {
            font-size: 18px;
            padding: 10px 25px;
            border-radius: 8px;
        }

        .fadeInUp {
            animation: fadeInUp 1s ease-out;
        }

        @keyframes fadeInUp {
            from {
                transform: translateY(40px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }
    </style>
</head>

<body>
    <div class="container error-container fadeInUp">
        <div class="error-code">⚠️</div>
        <div class="error-message">
            क्षमा करें! यह पृष्ठ अभी निर्माणाधीन है या कोई त्रुटि हो गई है।
        </div>
        <button class="btn btn-primary home-btn" onclick="window.location.href='/'">मुखपृष्ठ पर जाएँ</button>
    </div>

    <script>
        $(document).ready(function () {
            $('.home-btn').hover(function () {
                $(this).toggleClass('btn-success btn-primary');
            });
        });
    </script>
</body>
</html> 			<%@ include file="/WEB-INF/views/includes/footer.jsp" %>
