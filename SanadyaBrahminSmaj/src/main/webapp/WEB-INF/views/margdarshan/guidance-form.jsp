<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="hi">
<head>
    <title>मार्गदर्शन जोड़ें / संपादित करें</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/program.css" rel="stylesheet">
</head>

<body>

<div class="container mt-4">

    <h3 class="section-title">
        <span class="line"></span>
        मार्गदर्शन जोड़ें / संपादित करें
    </h3>

    <form method="post" action="${actionUrl}" enctype="multipart/form-data">

        <input type="hidden" name="id" value="${guidance.id}" />

        <!-- NAME -->
        <div class="mb-3">
            <label class="form-label">नाम</label>
            <input type="text" name="personName" class="form-control"
                   value="${guidance.personName}" required>
        </div>

        <!-- DESIGNATION -->
        <div class="mb-3">
            <label class="form-label">पद</label>
            <input type="text" name="designation" class="form-control"
                   value="${guidance.designation}" required>
        </div>

        <!-- IMAGE -->
        <div class="mb-3">
            <label class="form-label">फोटो</label>
            <input type="file" name="imageFile" class="form-control">
            <c:if test="${not empty guidance.imageUrl}">
                <img src="${guidance.imageUrl}" width="120" class="mt-2 border">
            </c:if>
        </div>

        <!-- CONTENT -->
        <div class="mb-3">
            <label class="form-label">मार्गदर्शन संदेश</label>
            <textarea name="content" rows="6" class="form-control" required>
${guidance.content}
            </textarea>
        </div>

        <div class="text-end">
            <button type="submit" class="btn btn-success">Save</button>
            <a href="/guidance" class="btn btn-secondary">Cancel</a>
        </div>

    </form>

</div>

</body>
</html>
