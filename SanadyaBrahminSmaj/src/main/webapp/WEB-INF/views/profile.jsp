<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>

<!DOCTYPE html>
<html>
<head>
  <title>प्रोफ़ाइल</title>
  <!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"> -->
  <!-- DataTables CSS -->
<link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
<link rel="stylesheet" href="https://cdn.datatables.net/buttons/2.4.2/css/buttons.dataTables.min.css">


  <style>
    body {
      background: linear-gradient(to right, #f9f9f9, #e9f4ff);
      min-height: 100vh;
    }
 Table Styling
.table-container {
  overflow-x: auto;
}

.beautiful-table {
  border-radius: 10px;
  overflow: hidden;
  box-shadow: 0 0 15px rgba(0, 0, 0, 0.08);
  background: #fff;
}

.beautiful-table th {
  background-color: #343a40;
  color: #fff;
  text-align: center;
  font-weight: bold;
  vertical-align: middle;
}

.beautiful-table td {
  vertical-align: middle;
  text-align: center;
}

.beautiful-table tr:hover {
  background-color: #f1f1f1;
  transition: all 0.2s ease-in-out;
}

#addPaymentMsg {
  font-size: 16px;
} 

    .container {
      padding-top: 60px;
      padding-bottom: 60px;
    }

    .profile-card {
      background: #fff;
      border-radius: 10px;
      box-shadow: 0 0 30px rgba(0, 0, 0, 0.1);
      padding: 30px;
      margin-bottom: 40px;
    }

    .label-col {
      font-weight: bold;
    }

    .readonly-input {
      background-color: #f9f9f9;
      border: none;
      font-weight: bold;
    }

    .editable-input {
      border: 1px solid #ccc;
      background-color: #fff;
    }

    #profilePic {
      width: 250px;
      height: 250px;
      object-fit: cover;
      /* border-radius: 50%; */
      border: 3px solid #ccc;
    }

    .image-upload-wrapper {
      text-align: center;
    }
 .receipt-thumbnail {
      max-height: 50px;
    }
      </style>
</head>
<body>

<div class="container">

  <!-- प्रोफ़ाइल कार्ड -->
  <div class="profile-card">
    <h3 class="mb-4">🙍‍♂️ आपकी प्रोफ़ाइल जानकारी</h3>
    <div class="row">
      <div class="col-md-4 text-center mb-4 image-upload-wrapper">
        <img id="profilePic"
             src="${user.profileImagePath != null ? user.profileImagePath : '/logo/logo.png'}"
             alt="Profile Image">
        <div class="mt-2">
          <input type="file" id="profileImageInput" accept="image/*" class="form-control mt-2" style="max-width:300px;margin:auto;">
          <button id="uploadImageBtn" class="btn btn-sm btn-primary mt-2">📤 छवि अपडेट करें</button>
        </div>
      </div>

      <div class="col-md-8">
        <form id="profileForm">
          <input type="hidden" name="id" value="${user.id}" />
          <div class="row g-3">
            <div class="col-md-4"><label class="label-col">पूरा नाम</label>
              <input type="text" class="form-control readonly-input" value="${user.fullName}" readonly>
            </div>
            <div class="col-md-4"><label class="label-col">पिता का नाम</label>
              <input type="text" class="form-control readonly-input" value="${user.fatherName}" readonly>
            </div>
            <div class="col-md-4"><label class="label-col">मोबाइल</label>
              <input type="text" class="form-control readonly-input" value="${user.mobile}" readonly>
            </div>
            <div class="col-md-4"><label class="label-col">ईमेल</label>
              <input type="text" class="form-control readonly-input" value="${user.email}" readonly>
            </div>
            <div class="col-md-4"><label class="label-col">लिंग</label>
              <input type="text" class="form-control readonly-input" value="${user.gender}" readonly>
            </div>
            <div class="col-md-4"><label class="label-col">जन्म तिथि</label>
              <input type="date" class="form-control readonly-input" value="${user.dateOfBirth}" readonly>
            </div>

            <div class="col-md-6"><label class="label-col">पता</label>
              <input name="address" type="text" class="form-control editable-input" value="${user.address}">
            </div>
            <div class="col-md-6"><label class="label-col">शैक्षणिक योग्यता</label>
              <input name="education" type="text" class="form-control editable-input" value="${user.education}">
            </div>
            <div class="col-md-6"><label class="label-col">पेशा</label>
              <input name="occupation" type="text" class="form-control editable-input" value="${user.occupation}">
            </div>
            <div class="col-md-6"><label class="label-col">ब्लड ग्रुप</label>
              <input name="bloodGroup" type="text" class="form-control editable-input" value="${user.bloodGroup}">
            </div>
            <div class="col-md-6"><label class="label-col">वैवाहिक स्थिति</label>
              <select name="maritalStatus" class="form-select editable-input">
                <option value="">चुनें</option>
                <option ${user.maritalStatus == 'अविवाहित' ? 'selected' : ''}>अविवाहित</option>
                <option ${user.maritalStatus == 'विवाहित' ? 'selected' : ''}>विवाहित</option>
                <option ${user.maritalStatus == 'अन्य' ? 'selected' : ''}>अन्य</option>
              </select>
            </div>
            <div class="col-12 text-end mt-3">
              <button type="submit" class="btn btn-success">💾 सहेजें</button>
            </div>
          </div>
        </form>
        <div id="updateMsg" class="mt-3 text-center text-success fw-bold"></div>
      </div>
    </div>
  </div>

  <!-- 💳 भुगतान जोड़ें -->
  <div class="profile-card">
    <h4 class="mb-3">➕ नया भुगतान जोडें</h4>
    <form id="addPaymentForm" enctype="multipart/form-data">
      <div class="row g-3">
       <div class="col-md-4">
          <label class="label-col">ट्रांजैक्शन आईडी</label>
          <input type="text" class="form-control" name="transactionId" required />
        </div>
        <div class="col-md-2">
          <label class="label-col">राशि (₹)</label>
          <input type="number" step="0.01" class="form-control" name="amount" required />
        </div>
        <div class="col-md-2">
          <label class="label-col">माध्यम</label>
          <select name="paymentMode" class="form-select" required>
            <option value="">चुनें</option>
            <option value="UPI">UPI</option>
            <option value="Cash">Cash</option>
            <option value="Bank Transfer">Bank Transfer</option>
          </select>
        </div>
        <div class="col-md-2">
          <label class="label-col">विवरण</label>
          <input type="text" class="form-control" name="description" required />
        </div>
        <div class="col-md-2">
          <label class="label-col">स्थिति</label>
          <select name="status" class="form-select" required>
            <option value="Success">सफल</option>
            <option value="Pending">लंबित</option>
            <option value="Failed">विफल</option>
          </select>
        </div>
        <div class="col-md-4">
          <label class="label-col">भुगतान तिथि</label>
          <input type="date" class="form-control" name="paymentDate" required />
        </div>
        <div class="col-md-4">
          <label class="label-col">रसीद पट्ट अपलोड करें</label>
          <input type="file" class="form-control" name="receiptImage" accept="image/*" />
        </div>
      </div>
      <div class="text-end mt-3">
        <button class="btn btn-primary">💳 भुगतान जोड़ें</button>
      </div>
    </form>
    <div id="addPaymentMsg" class="mt-2 fw-bold text-success"></div>
  </div>

<!-- 🧾 भुगतान इतिहास -->
<div class="profile-card mt-5">
  <h4 class="mb-3">🧾 भुगतान इतिहास</h4>
  <div class="table-responsive">
    <table id="paymentTable" class="table table-bordered table-hover display nowrap" style="width:100%">
      <thead class="table-dark">
        <tr>
          <th>भुगतान तिथि</th>
          <th>राशि (₹)</th>
          <th>माध्यम</th>
          <th>विवरण</th>
          <th>स्थिति</th>
          <th>मान्य</th>
            <th>रसीद</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach items="${paymentList}" var="payment">
          <tr>
              <td><fmt:formatDate value="${payment.paymentDate}" pattern="dd-MM-yyyy HH:mm" /></td>
            <td><c:out value="${payment.amount}" /></td>
            <td><c:out value="${payment.paymentMode}" /></td>
            <td><c:out value="${payment.description}" /></td>
            <td>
              <span class="badge 
                ${payment.status == 'Success' ? 'bg-success' : 
                  payment.status == 'Pending' ? 'bg-warning text-dark' : 
                  'bg-danger'}">
                <c:out value="${payment.status}" />
              </span>
            </td>
            <td>
              <span class="badge 
                ${payment.validated == 'सत्यापित' ? 'bg-success' : 
                  payment.validated == 'प्रक्रिया में' ? 'bg-warning text-dark' : 
                  'bg-danger'}">
                <c:out value="${payment.validated}" />
              </span>
            </td>
              <td>
                <c:if test="${not empty payment.receiptImagePath}">
                  <a href="${pageContext.request.contextPath}/images/${payment.receiptImagePath}" target="_blank">
                    <img src="${pageContext.request.contextPath}/images/${payment.receiptImagePath}" class="receipt-thumbnail" alt="Receipt" />
                  </a>
                </c:if>
              </td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </div>
</div>


</div>
<!-- ✅ jQuery First (only once) -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- ✅ DataTables core JS -->
<script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>

<!-- ✅ DataTables Buttons + Export -->
<script src="https://cdn.datatables.net/buttons/2.4.2/js/dataTables.buttons.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.7/pdfmake.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.7/vfs_fonts.js"></script>
<script src="https://cdn.datatables.net/buttons/2.4.2/js/buttons.html5.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.4.2/js/buttons.print.min.js"></script>

<!-- ✅ Custom JS (after DataTables) -->
<script src="${pageContext.request.contextPath}/js/profile.js"></script>
<script>
  $(document).ready(function () {
    $('#paymentTable').DataTable({
      dom: 'Bfrtip',
      buttons: [
        {
          extend: 'excelHtml5',
          title: 'भुगतान_इतिहास',
          text: '📥 Excel डाउनलोड करें'
        },
        {
          extend: 'csvHtml5',
          title: 'भुगतान_इतिहास',
          text: '📄 CSV डाउनलोड करें'
        },
        {
          extend: 'pdfHtml5',
          title: 'भुगतान_इतिहास',
          text: '📄 PDF डाउनलोड करें',
          orientation: 'landscape',
          pageSize: 'A4'
        },
        {
          extend: 'print',
          text: '🖨️ प्रिंट करें'
        }
      ],
      language: {
        search: "🔍 खोजें:",
        lengthMenu: "_MENU_ प्रविष्टियाँ दिखाएँ",
        info: "_TOTAL_ में से _START_ से _END_ तक दिखा रहे हैं",
        paginate: {
          first: "पहला",
          last: "अंतिम",
          next: "➡️",
          previous: "⬅️"
        },
        zeroRecords: "कोई मेल नहीं मिला",
        infoEmpty: "कोई डेटा उपलब्ध नहीं",
        infoFiltered: "(कुल _MAX_ से छाँटा गया)"
      },
      responsive: true
    });
  });
</script>

</body>
</html>
