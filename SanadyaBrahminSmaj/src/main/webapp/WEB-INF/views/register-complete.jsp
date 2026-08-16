<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>

<!DOCTYPE html>
<html lang="hi">
<head>
    <title>प्रोफ़ाइल पूर्ण करें - सनाढ्य ब्राह्मण सभा, कोटा</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: #fff3e0;
            font-family: 'Segoe UI', 'Noto Sans Devanagari', sans-serif;
        }
        .form-container {
            max-width: 700px;
            margin: 40px auto;
            background: #ffffff;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 8px 16px rgba(255, 102, 0, 0.3);
        }
        .page-title {
            color: #ff6600;
            text-align: center;
            margin-bottom: 20px;
        }
        .section-title {
            font-weight: 700;
            color: #7a4200;
            border-bottom: 2px solid #ffcc80;
            padding-bottom: 6px;
            margin: 24px 0 14px;
        }
        .btn-orange {
            background-color: #ff6600;
            color: white;
            font-weight: 600;
        }
        .btn-orange:hover {
            background-color: #e65c00;
            color: white;
        }
        .req {
            color: #c40000;
            font-weight: 900;
        }
        .form-control:readonly {
            background-color: #fff3d6;
        }
        .google-badge {
            background: #f1f1f1;
            border-radius: 20px;
            padding: 6px 16px;
            display: inline-block;
            font-size: 13px;
            color: #555;
        }
    </style>
</head>
<body>
<div class="container form-container">
    <h3 class="page-title">✏️ पंजीकरण पूर्ण करें</h3>

    <c:if test="${not empty successMessage}">
        <div class="alert alert-success">${successMessage}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <div class="text-center mb-3">
        <span class="google-badge">
            <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" fill="currentColor" class="bi bi-google me-1" viewBox="0 0 16 16">
                <path d="M15.545 6.558a9.42 9.42 0 0 1 .139 1.626c0 2.434-.87 4.492-2.384 5.885h.002C11.978 15.292 10.158 16 8 16A8 8 0 1 1 8 0a7.689 7.689 0 0 1 5.352 2.082l-2.284 2.284A4.347 4.347 0 0 0 8 3.166c-2.087 0-3.86 1.408-4.492 3.304a4.792 4.792 0 0 0 0 3.063h.003c.635 1.893 2.405 3.301 4.492 3.301 1.078 0 2.004-.276 2.722-.764h-.003a3.702 3.702 0 0 0 1.599-2.431H8v-3.08h7.545z"/>
            </svg>
            Google खाते से लॉगिन
        </span>
        <p class="text-muted mt-2">कृपया नीचे अपनी शेष जानकारी भरें। अनुमोदन के बाद आप सभी सुविधाओं का उपयोग कर सकेंगे।</p>
        <p class="text-muted small">तब तक आप रूम बुकिंग, विवाह पंजीकरण और अन्य सार्वजनिक सुविधाओं का उपयोग कर सकते हैं।</p>
    </div>

    <form method="post" action="/register/complete">
        <!-- ===== PERSONAL DETAILS ===== -->
        <div class="section-title">व्यक्तिगत जानकारी <span class="req">*</span></div>

        <div class="mb-3">
            <label class="form-label">पूरा नाम <span class="req">*</span></label>
            <input type="text" name="fullName" class="form-control" value="${user.fullName}" required>
        </div>

        <div class="row g-3">
            <div class="col-md-6">
                <label class="form-label">पिता का नाम</label>
                <input type="text" name="fatherName" class="form-control" value="${user.fatherName}">
            </div>
            <div class="col-md-6">
                <label class="form-label">गोत्र</label>
                <input type="text" name="gotra" class="form-control" value="${user.gotra}" placeholder="गोत्र दर्ज करें">
            </div>
        </div>

        <div class="row g-3 mt-2">
            <div class="col-md-4">
                <label class="form-label">जन्म तिथि</label>
                <input type="date" name="dateOfBirth" class="form-control" value="${user.dateOfBirth}">
            </div>
            <div class="col-md-4">
                <label class="form-label">लिंग</label>
                <select name="gender" class="form-select">
                    <option value="">चुनें</option>
                    <option value="पुरुष" ${user.gender == 'पुरुष' ? 'selected' : ''}>पुरुष</option>
                    <option value="महिला" ${user.gender == 'महिला' ? 'selected' : ''}>महिला</option>
                    <option value="अन्य" ${user.gender == 'अन्य' ? 'selected' : ''}>अन्य</option>
                </select>
            </div>
            <div class="col-md-4">
                <label class="form-label">रक्त समूह</label>
                <select name="bloodGroup" class="form-select">
                    <option value="">चुनें</option>
                    <option value="A+" ${user.bloodGroup == 'A+' ? 'selected' : ''}>A+</option>
                    <option value="A-" ${user.bloodGroup == 'A-' ? 'selected' : ''}>A-</option>
                    <option value="B+" ${user.bloodGroup == 'B+' ? 'selected' : ''}>B+</option>
                    <option value="B-" ${user.bloodGroup == 'B-' ? 'selected' : ''}>B-</option>
                    <option value="AB+" ${user.bloodGroup == 'AB+' ? 'selected' : ''}>AB+</option>
                    <option value="AB-" ${user.bloodGroup == 'AB-' ? 'selected' : ''}>AB-</option>
                    <option value="O+" ${user.bloodGroup == 'O+' ? 'selected' : ''}>O+</option>
                    <option value="O-" ${user.bloodGroup == 'O-' ? 'selected' : ''}>O-</option>
                </select>
            </div>
        </div>

        <!-- ===== CONTACT & ADDRESS ===== -->
        <div class="section-title">पता और संपर्क</div>

        <div class="mb-3">
            <label class="form-label">मोबाइल</label>
            <input type="text" class="form-control" value="${user.mobile}" readonly>
        </div>

        <div class="mb-3">
            <label class="form-label">ईमेल</label>
            <input type="email" class="form-control" value="${user.email}" readonly>
        </div>

        <div class="mb-3">
            <label class="form-label">पता</label>
            <textarea name="address" class="form-control" rows="2">${user.address}</textarea>
        </div>

        <div class="row g-3">
            <div class="col-md-6">
                <label class="form-label">शहर</label>
                <input type="text" name="city" class="form-control" value="${user.city}" placeholder="शहर/गाँव">
            </div>
            <div class="col-md-6">
                <label class="form-label">गृह जिला</label>
                <input type="text" name="homeDistrict" class="form-control" value="${user.homeDistrict}" placeholder="जिला">
            </div>
        </div>

        <!-- ===== EDUCATION & OCCUPATION ===== -->
        <div class="section-title">शिक्षा और व्यवसाय</div>

        <div class="row g-3">
            <div class="col-md-6">
                <label class="form-label">शिक्षा</label>
                <input type="text" name="education" class="form-control" value="${user.education}">
            </div>
            <div class="col-md-6">
                <label class="form-label">व्यवसाय</label>
                <input type="text" name="occupation" class="form-control" value="${user.occupation}">
            </div>
        </div>

        <div class="row g-3 mt-2">
            <div class="col-md-6">
                <label class="form-label">वैवाहिक स्थिति</label>
                <select name="maritalStatus" class="form-select">
                    <option value="">चुनें</option>
                    <option value="अविवाहित" ${user.maritalStatus == 'अविवाहित' ? 'selected' : ''}>अविवाहित</option>
                    <option value="विवाहित" ${user.maritalStatus == 'विवाहित' ? 'selected' : ''}>विवाहित</option>
                    <option value="विधुर" ${user.maritalStatus == 'विधुर' ? 'selected' : ''}>विधुर</option>
                    <option value="विधवा" ${user.maritalStatus == 'विधवा' ? 'selected' : ''}>विधवा</option>
                    <option value="तलाकशुदा" ${user.maritalStatus == 'तलाकशुदा' ? 'selected' : ''}>तलाकशुदा</option>
                </select>
            </div>
        </div>

        <div class="text-center mt-4">
            <p class="text-muted small">सबमिट करने के बाद आपका पंजीकरण अनुमोदन के लिए भेज दिया जाएगा।</p>
            <button type="submit" class="btn btn-orange px-5">प्रोफ़ाइल सहेजें</button>
            <a href="/home" class="btn btn-secondary ms-2">बाद में करें</a>
        </div>
    </form>
</div>
</body>
</html>
<%@ include file="/WEB-INF/views/includes/footer.jsp" %>
