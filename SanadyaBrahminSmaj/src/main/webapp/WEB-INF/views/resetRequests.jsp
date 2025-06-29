<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

    <%@ include file="/WEB-INF/views/includes/header.jsp" %>


<div class="container mt-5">
<div id="resetStatusMessage" class="alert alert-success d-none text-center fw-bold"></div>

  <h3 class="text-center mb-4">🔁 पासवर्ड रीसेट अनुरोध सूची</h3>

  <table class="table table-bordered table-striped">
    <thead class="table-dark">
      <tr>
        <th>मोबाइल नंबर</th>
        <th>कारण</th>
        <th>अनुरोध दिनांक</th>
        <th>कार्य</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach items="${resetRequests}" var="req">
        <tr>
          <td>${req.mobile}</td>
          <td>${req.reason}</td>
          <td>${req.requestDate}</td>
          <td>
<form class="reset-action-form d-inline" data-action="approve" data-id="${req.id}">
              <input type="text" name="adminRemarks" placeholder="टिप्पणी" required class="form-control mb-1">
              <button type="submit" class="btn btn-success btn-sm">✔️ स्वीकृत करें</button>
            </form>
<form class="reset-action-form d-inline" data-action="reject" data-id="${req.id}">
              <input type="text" name="adminRemarks" placeholder="टिप्पणी" required class="form-control mb-1">
              <button type="submit" class="btn btn-danger btn-sm">❌ अस्वीकृत करें</button>
            </form>
          </td>
        </tr>
      </c:forEach>
    </tbody>
  </table>
</div>
<script>
$(document).ready(function () {
  $('.reset-action-form').submit(function (e) {
    e.preventDefault();

    const form = $(this);
    const id = form.data('id');
    const action = form.data('action');
    const remarks = form.find('input[name="adminRemarks"]').val().trim();

    if (!remarks) {
      alert("कृपया टिप्पणी भरें।");
      return;
    }

    $.ajax({
      url: `/api/admin/password-reset/${id}/${action}`,
      type: 'POST',
      data: { adminRemarks: remarks },
      success: function (res) {
        $('#resetStatusMessage')
          .removeClass("d-none alert-danger")
          .addClass("alert-success")
          .text(res.message);

        setTimeout(() => location.reload(), 2000); // refresh list after 2s
      },
      error: function (xhr) {
        const msg = xhr.responseJSON?.message || "❌ कार्रवाई विफल हुई";
        $('#resetStatusMessage')
          .removeClass("d-none alert-success")
          .addClass("alert-danger")
          .text(msg);
      }
    });
  });
});
</script>
