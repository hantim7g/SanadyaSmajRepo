<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>

<style>
body{
  background:#fffaf4;
  font-family:'Segoe UI','Noto Sans Devanagari',sans-serif;
}
.search-card{
  background:linear-gradient(93deg,#fff7ed 70%,#fffbe9 100%);
  border-radius:14px;
  box-shadow:0 1px 8px #edd1aeb2;
}
.profile-card{
  background:linear-gradient(93deg,#ffedc2 65%,#fca854 100%);
  border-radius:18px;
  box-shadow:0 2px 16px rgba(160,128,32,.08),0 2px 6px rgba(240,180,80,.11);
  padding:16px 22px;
  transition:.2s ease;
}
.profile-card:hover{
  transform:translateY(-4px);
  background:linear-gradient(87deg,#fff8e3 70%,#ffaa56 97%);
}
.profile-img{
  width:130px;
  height:130px;
  object-fit:cover;
  border-radius:50%;
  border:3px solid #fff9ce;
  box-shadow:0 1px 7px #dba2362e;
}
.name-banner{
  font-size:1.6rem;
  font-weight:800;
  color:#5e3400;
  border-bottom:2px solid #e7c089;
  margin-bottom:6px;
}
.badge-featured{
  background:#ff9800;
  color:#fff;
  padding:4px 10px;
  border-radius:14px;
  font-size:.8rem;
  font-weight:700;
}
.field-label{
  font-weight:600;
  color:#512f07;
}
.gotra-box{
  background:#fff8e3;
  border:1px solid #e7c089;
  border-radius:12px;
  padding:10px;
}
.pagination .page-link{
  color:#7a3e00;
}
.pagination .active .page-link{
  background:#ff9800;
  border-color:#ff9800;
  color:#fff;
}
</style>
<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet"/>

<div class="container my-4">

<h3 class="text-center fw-bold mb-3">विवाह योग्य परिचय</h3>
<!-- ================= SEARCH ================= -->
<div class="search-card p-3 mb-4">
<form action="/admin/matrimony/list" method="get">
<div class="row g-2">

<!-- Gender -->
<div class="col-md-3">
<label class="field-label">लिंग</label>
<select name="gender" class="form-select">
  <option value="">सभी</option>
  <option value="पुरुष" ${param.gender=='पुरुष'?'selected':''}>पुरुष</option>
  <option value="महिला" ${param.gender=='महिला'?'selected':''}>महिला</option>
</select>
</div>

<!-- Manglik -->
<div class="col-md-3">
<label class="field-label">मांगलिक</label>
<select name="manglik" class="form-select">
  <option value="">सभी</option>
  <option value="हाँ" ${param.manglik=='हाँ'?'selected':''}>हाँ</option>
  <option value="नहीं" ${param.manglik=='नहीं'?'selected':''}>नहीं</option>
</select>
</div>

<!-- Qualification -->
<div class="col-md-3">
<label class="field-label">शिक्षा</label>
<input name="qualification"
       class="form-control"
       value="${fn:escapeXml(param.qualification)}">
</div>

<!-- Occupation -->
<div class="col-md-3">
<label class="field-label">पेशा</label>
<input name="occupation"
       class="form-control"
       value="${fn:escapeXml(param.occupation)}">
</div>

<!-- Exclude Gotra (Multi Select) -->
<div class="col-md-3">
<label class="field-label">गोत्र (छोड़कर)</label>

<select name="excludeGotras"
        id="excludeGotras"
        class="form-select"
        multiple>

  <c:forEach items="${gotraList}" var="g">
    <option value="${g.gotraName}"
      <c:if test="${paramValues.excludeGotras != null 
                   and fn:contains(
                       ',' += fn:join(paramValues.excludeGotras, ',') += ',',
                       ',' += g.gotraName += ','
                   )}">
        selected
      </c:if>>
      ${g.gotraName}
    </option>
  </c:forEach>

</select>
<br>
<small class="text-muted">
  चयनित गोत्रों को छोड़कर परिणाम दिखाए जाएंगे
</small>
</div>

<!-- City -->
<div class="col-md-3">
<label class="field-label">शहर</label>
<input name="city"
       class="form-control"
       value="${fn:escapeXml(param.city)}">
</div>

<!-- District -->
<div class="col-md-3">
<label class="field-label">जिला</label>
<input name="district"
       class="form-control"
       value="${fn:escapeXml(param.district)}">
</div>

<!-- Income -->
<div class="col-md-3">
<label class="field-label">आय</label>
<input name="income"
       class="form-control"
       value="${fn:escapeXml(param.income)}">
</div>
<div class="col-md-3">
  <label class="field-label">स्वीकृति स्थिति</label>
  <select name="approved" class="form-select">
    <option value="">सभी</option>
    <option value="true" ${param.approved=='true'?'selected':''}>स्वीकृत</option>
    <option value="false" ${param.approved=='false'?'selected':''}>अस्वीकृत</option>
  </select>
</div>
<div class="col-md-3">
  <label class="field-label">सक्रिय स्थिति</label>
  <select name="active" class="form-select">
    <option value="">सभी</option>
    <option value="true" ${param.active=='true'?'selected':''}>सक्रिय</option>
    <option value="false" ${param.active=='false'?'selected':''}>निष्क्रिय</option>
  </select>
</div>
<!-- Buttons -->
<div class="col-12 text-end mt-2">
  <button class="btn btn-warning px-4">खोजें</button>
  <a href="/user/matrimony/list" class="btn btn-outline-dark ms-2">रीसेट</a>
</div>


</div>
</form>
</div>

<!-- ================= RESULT ================= -->
<c:if test="${empty profiles}">
<div class="alert alert-warning text-center">कोई परिणाम नहीं मिला।</div>
</c:if>

<c:forEach items="${profiles}" var="p">

<div class="profile-card mb-4">
<div class="row g-3 align-items-start">

<!-- LEFT -->
<div class="name-banner">${p.name} (${p.gender})</div>
<div class="col-md-3 text-center">
<img src="${p.profileImagePath}" class="profile-img mb-2">

</div>

<!-- CENTER -->
<!-- CENTER -->
<div class="col-md-5">

  <!-- DOB | Birth Time -->
  <div class="row mb-1">
    <div class="col-6">
      <b>जन्म तिथि:</b> ${p.dob}
    </div>
    <div class="col-6">
      <b>जन्म समय:</b> ${p.birthTime}
    </div>
  </div>

  <!-- Father | Mother -->
  <div class="row mb-1">
    <div class="col-6">
      <b>पिता:</b> ${p.fatherName}
    </div>
    <div class="col-6">
      <b>माता:</b> ${p.motherName}
    </div>
  </div>

  <!-- Education | Occupation -->
  <div class="row mb-1">
    <div class="col-6">
      <b>शिक्षा:</b> ${p.qualification}
    </div>
    <div class="col-6">
      <b>पेशा:</b> ${p.occupation}
    </div>
  </div>

  <!-- Income | Marital Status -->
  <div class="row mb-1">
    <div class="col-6">
      <b>आय:</b> ${p.income}
    </div>
    <div class="col-6">
      <b>स्थिति:</b> ${p.maritalStatus}
    </div>
  </div>

  <!-- Height | Manglik -->
  <div class="row mb-1">
    <div class="col-6">
      <b>कद:</b> ${p.height}
    </div>
    <div class="col-6">
      <b>मांगलिक:</b>
      <span class="${p.manglik=='हाँ'?'text-danger fw-bold':'text-success fw-bold'}">
        ${p.manglik}
      </span>
    </div>
  </div>

  <!-- Address (Full width for readability) -->
  <div class="row mb-1">
    <div class="col-12">
      <b>निवास:</b>
      <span class="text-muted">
      ${p.houseAddress},   ${p.city},${p.state}
      </span>
    </div>
  </div>
  <div class="row mb-1">
      <div class="col-12">
        <b>मोबाइल:</b>
        <span class="text-muted">
          ${p.mobile}
        </span>
      </div>
    </div>

</div>


<!-- RIGHT -->
<div class="col-md-4">
<div class="mb-2">

</div>

<div class="gotra-box mb-2">
<div class="field-label mb-1">गोत्र विवरण</div>
<ul class="mb-0 ps-3 small">
<li>स्वयं: ${p.gotra}</li>
<li>माता: ${p.motherGotra}</li>
<li>दादी: ${p.dadiGotra}</li>
<li>नानी: ${p.naniGotra}</li>
</ul>
</div>

<div class="text-end">
<a href="/user/vivhauser/pdf/${p.id}" class="btn btn-success btn-sm">
📄 बायोडाटा PDF
</a>
</div>
<div class="mb-2">

  <!-- APPROVED -->
  <span class="badge ${p.approved ? 'bg-success' : 'bg-danger'}">
    ${p.approved ? 'स्वीकृत' : 'अस्वीकृत'}
  </span>

  <button
    class="btn btn-sm ${p.approved ? 'btn-outline-danger' : 'btn-outline-success'} ms-2"
    onclick="toggleApprove(${p.id}, ${!p.approved})">
    ${p.approved ? 'अस्वीकृत करें' : 'स्वीकृत करें'}
  </button>

</div>

<div class="mb-2">

  <!-- ACTIVE -->
  <span class="badge ${p.active ? 'bg-primary' : 'bg-secondary'}">
    ${p.active ? 'सक्रिय' : 'निष्क्रिय'}
  </span>

  <button
    class="btn btn-sm ${p.active ? 'btn-outline-secondary' : 'btn-outline-primary'} ms-2"
    onclick="toggleActive(${p.id}, ${!p.active})">
    ${p.active ? 'निष्क्रिय करें' : 'सक्रिय करें'}
  </button>

</div>


</div>

</div>
</div>

</c:forEach>

<!-- ================= PAGINATION ================= -->
<c:if test="${totalPages > 1}">
<nav>
<ul class="pagination justify-content-center">

<li class="page-item ${currentPage==0?'disabled':''}">
<a class="page-link" href="?page=${currentPage-1}">पिछला</a>
</li>

<c:forEach begin="0" end="${totalPages-1}" var="i">
<li class="page-item ${i==currentPage?'active':''}">
<a class="page-link" href="?page=${i}">${i+1}</a>
</li>
</c:forEach>

<li class="page-item ${currentPage+1==totalPages?'disabled':''}">
<a class="page-link" href="?page=${currentPage+1}">अगला</a>
</li>

</ul>
</nav>
</c:if>

</div>

<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>

<script>
$(document).ready(function () {
  $('#excludeGotras').select2({
    placeholder: "गोत्र (छोड़कर)",
    allowClear: true,
    width: '100%'
  });
});
</script>
<script>
function toggleApprove(id, approved) {

  bootbox.confirm({
    title: "पुष्टि करें",
    message: approved 
        ? "क्या आप इस प्रोफ़ाइल को <b>स्वीकृत</b> करना चाहते हैं?"
        : "क्या आप इस प्रोफ़ाइल को <b>अस्वीकृत</b> करना चाहते हैं?",
    centerVertical: true,
    buttons: {
      cancel: {
        label: 'रद्द करें',
        className: 'btn-secondary'
      },
      confirm: {
        label: 'हाँ, करें',
        className: 'btn-success'
      }
    },
    callback: function (result) {
      if (result) {
        $.post('/admin/matrimony/' + id + '/approve', { approved: approved })
          .done(function () {
            bootbox.alert({
              message: "स्थिति सफलतापूर्वक अपडेट की गई ✅",
              centerVertical: true,
              callback: function () {
                location.reload();
              }
            });
          })
          .fail(function () {
            bootbox.alert({
              message: "❌ स्वीकृति प्रक्रिया विफल रही",
              centerVertical: true
            });
          });
      }
    }
  });
}

function toggleActive(id, active) {

  bootbox.confirm({
    title: "पुष्टि करें",
    message: active
        ? "क्या आप इस प्रोफ़ाइल को <b>सक्रिय</b> करना चाहते हैं?"
        : "क्या आप इस प्रोफ़ाइल को <b>निष्क्रिय</b> करना चाहते हैं?",
    centerVertical: true,
    buttons: {
      cancel: {
        label: 'रद्द करें',
        className: 'btn-secondary'
      },
      confirm: {
        label: 'हाँ, करें',
        className: 'btn-warning'
      }
    },
    callback: function (result) {
      if (result) {
        $.post('/admin/matrimony/' + id + '/active', { active: active })
          .done(function () {
            bootbox.alert({
              message: "स्थिति सफलतापूर्वक अपडेट की गई ✅",
              centerVertical: true,
              callback: function () {
                location.reload();
              }
            });
          })
          .fail(function () {
            bootbox.alert({
              message: "❌ सक्रियता अपडेट नहीं हो सकी",
              centerVertical: true
            });
          });
      }
    }
  });
}
</script>

<%@ include file="/WEB-INF/views/includes/footer.jsp" %>
