<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>


    <%@ include file="/WEB-INF/views/includes/header.jsp" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
            <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="hi">
<head>
    <title>मार्गदर्शन जोड़ें / संपादित करें</title>
<style>
	body {
	    background: #f8f6f2;
	    font-family: 'Noto Sans Devanagari', sans-serif;
	}

	.section-title {
	    font-weight: 700;
	    color: #9c4a00;
	    margin-bottom: 30px;
	    display: flex;
	    align-items: center;
	}

	.section-title .line {
	    width: 5px;
	    height: 28px;
	    background: #e65100;
	    margin-right: 10px;
	}

	.program-card {
	    background: #ffffff;
	    border: 2px solid #000;
	    padding: 20px;
	    display: flex;
	    gap: 20px;
	    margin-bottom: 25px;
	}

	.program-image img {
	    width: 180px;
	    height: 160px;
	    object-fit: cover;
	    border: 2px solid #000;
	}

	.program-content {
	    flex: 1;
	}

	.program-name {
	    font-weight: bold;
	    margin-bottom: 2px;
	}

	.program-designation {
	    font-size: 14px;
	    color: #555;
	    margin-bottom: 12px;
	}

	.program-text {
	    border: 2px solid #000;
	    padding: 15px;
	    line-height: 1.8;
	    background: #fffdf8;
	}

	.admin-actions {
	    margin-top: 15px;
	}</style>

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
		<div class="mb-3">
		    <label class="form-label">प्राथमिकता (Priority)</label>
		    <input type="number"
		           name="priority"
		           class="form-control"
		           min="1"
		           value="${guidance.priority}"
		           required>
		    <small class="text-muted">
		        कम संख्या = पहले दिखेगा (जैसे 1, 2, 3)
		    </small>
		</div>
        <div class="text-end">
            <button type="submit" class="btn btn-success">Save</button>
            <a href="/guidance" class="btn btn-secondary">Cancel</a>
        </div>

    </form>

</div>

</body>
</html> 			<%@ include file="/WEB-INF/views/includes/footer.jsp" %>
