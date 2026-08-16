<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>

<!DOCTYPE html>
<html >
<head>
<meta charset="UTF-8">
<title>विवाह योग्य परिचय पंजीकरण</title>

<style>
body{
  background:#f6f1e9;
  font-family:'Noto Sans Devanagari', sans-serif;
}

.card{
  background:#fffdf7;
  box-shadow:0 0 20px rgba(0,0,0,.1);
  border-radius:14px;
}

.section-title{
  background:linear-gradient(90deg,#ff9800,#ffc107);
  padding:8px 14px;
  font-weight:bold;
  border-radius:8px;
  margin-top:25px;
}

.form-control,.form-select{
  border-radius:10px;
}

.profile-image-preview{
  border:3px solid #ff9800;
  border-radius:12px;
  max-height:240px;
  object-fit:cover;
}

.admin-box{
  background:#fff3cd;
  padding:15px;
  border-radius:10px;
  margin-top:20px;
}
</style>
</head>

<body>

<div class="container my-5">
<div class="card p-4">

<h3 class="text-center text-primary fw-bold">
विवाह योग्य युवक / युवती परिचय फॉर्म
</h3>

<c:if test="${not empty success}">
<div class="alert alert-success text-center mt-3">
आपकी जानकारी सफलतापूर्वक सुरक्षित कर ली गई है।
</div>
</c:if>

<form action="/user/vivhauser/save" method="post" enctype="multipart/form-data">

<input type="hidden" name="id" value="${vivhauser.id}" />

<div class="row mt-4">

<!-- IMAGE -->
<div class="col-md-4 text-center">
<img id="previewImage"
src="${vivhauser.profileImagePath != null ? vivhauser.profileImagePath : '/images/default.png'}"
class="img-fluid profile-image-preview mb-2">

<input type="file" name="image" id="imageInput"
class="form-control mt-2" accept="image/*">
</div>

<!-- DETAILS -->
<div class="col-md-8">

<!-- व्यक्तिगत जानकारी -->
<div class="section-title">व्यक्तिगत जानकारी</div>
<div class="row g-3 mt-1">
<div class="col-md-6">
<label>पूरा नाम</label>
<input type="text" name="name" value="${vivhauser.name}" class="form-control" required>
</div>

<div class="col-md-6">
<label>लिंग</label>
<select name="gender" class="form-select">
<option ${vivhauser.gender=='पुरुष'?'selected':''}>पुरुष</option>
<option ${vivhauser.gender=='महिला'?'selected':''}>महिला</option>
</select>
</div>

<div class="col-md-6">
<label>जन्म तिथि</label>
<input type="date" name="dob" value="${vivhauser.dob}" class="form-control">
</div>

<div class="col-md-6">
<label>जन्म समय</label>
<input type="text" name="birthTime" value="${vivhauser.birthTime}" class="form-control">
</div>

<div class="col-md-6">
<label>मोबाइल</label>
<input type="text" name="mobile" value="${vivhauser.mobile}" class="form-control" required>
</div>

<div class="col-md-6">
<label>ईमेल</label>
<input type="email" name="email" value="${vivhauser.email}" class="form-control">
</div>
</div>

<!-- वैवाहिक विवरण -->
<div class="section-title">वैवाहिक विवरण</div>
<div class="row g-3 mt-1">
<div class="col-md-4">
<label>कद</label>
<input type="text" name="height" value="${vivhauser.height}" class="form-control">
</div>

<div class="col-md-4">
<label>वजन</label>
<input type="text" name="weight" value="${vivhauser.weight}" class="form-control">
</div>

<div class="col-md-4">
<label>वैवाहिक स्थिति</label>
<select name="maritalStatus" class="form-select">
<option>अविवाहित</option>
<option>तलाकशुदा</option>
<option>विधवा / विधुर</option>
</select>
</div>
</div>

<!-- शिक्षा / व्यवसाय -->
<div class="section-title">शिक्षा व व्यवसाय</div>
<div class="row g-3 mt-1">
<div class="col-md-6">
<label>शैक्षणिक योग्यता</label>
<input type="text" name="qualification" value="${vivhauser.qualification}" class="form-control">
</div>

<div class="col-md-6">
<label>पेशा</label>
<input type="text" name="occupation" value="${vivhauser.occupation}" class="form-control">
</div>

<div class="col-md-6">
<label>वार्षिक आय</label>
<input type="text" name="income" value="${vivhauser.income}" class="form-control">
</div>
</div>

<!-- ज्योतिष -->
<div class="section-title">ज्योतिष विवरण</div>
<div class="row g-3 mt-1">
	<div class="col-md-6">
	  <label>स्वयं का गोत्र</label>
	  <select name="gotra" class="form-select" onchange="toggleGotra(this,'selfGotraDiv')">
	    <option value="">-- गोत्र चुनें --</option>

	    <c:forEach items="${gotraList}" var="g">
	      <option value="${g.gotraName}"
	        ${vivhauser.gotra == g.gotraName ? 'selected' : ''}>
	        ${g.gotraName}
	      </option>
	    </c:forEach>

	    <option value="OTHER" ${not empty vivhauser.customGotra ? 'selected' : ''}>अन्य</option>
	  </select>
	</div>

	<div class="col-md-6" id="selfGotraDiv" style="display:none">
	  <label>अपना गोत्र लिखें</label>
	  <input type="text" name="customGotra"
	         value="${vivhauser.customGotra}"
	         class="form-control">
	</div>


<div class="col-md-4">
<label>राशि</label>
<input type="text" name="rashi" value="${vivhauser.rashi}" class="form-control">
</div>

<div class="col-md-4">
<label>मांगलिक</label>
<select name="manglik" class="form-select">
<option>नहीं</option>
<option>हाँ</option>
</select>
</div>
</div>
<div class="section-title mt-4">पारिवारिक एवं गोत्र विवरण</div>

<div class="row g-3 mt-1">

  <!-- माता -->
  <div class="col-md-6">
    <label>माता का नाम</label>
    <input type="text" name="motherName"
           value="${vivhauser.motherName}"
           class="form-control">
  </div>

  <div class="col-md-6">
    <label>माता का गोत्र</label>
    <select name="motherGotra" class="form-select"
            onchange="toggleGotra(this,'motherGotraDiv')">

      <option value="">-- गोत्र चुनें --</option>
      <c:forEach items="${gotraList}" var="g">
        <option value="${g.gotraName}"
          ${vivhauser.motherGotra == g.gotraName ? 'selected' : ''}>
          ${g.gotraName}
        </option>
      </c:forEach>

      <option value="OTHER" ${not empty vivhauser.motherCustomGotra ? 'selected' : ''}>अन्य</option>
    </select>
  </div>

  <div class="col-md-6" id="motherGotraDiv" style="display:none">
    <label>माता का गोत्र लिखें</label>
    <input type="text" name="motherCustomGotra"
           value="${vivhauser.motherCustomGotra}"
           class="form-control">
  </div>


  <!-- दादी -->
  <div class="col-md-6">
    <label>दादी का नाम (पिता की माता)</label>
    <input type="text" name="dadiName"
           value="${vivhauser.dadiName}"
           class="form-control">
  </div>

  <div class="col-md-6">
    <label>दादी का गोत्र</label>
    <select name="dadiGotra" class="form-select"
            onchange="toggleGotra(this,'dadiGotraDiv')">

      <option value="">-- गोत्र चुनें --</option>
      <c:forEach items="${gotraList}" var="g">
        <option value="${g.gotraName}"
          ${vivhauser.dadiGotra == g.gotraName ? 'selected' : ''}>
          ${g.gotraName}
        </option>
      </c:forEach>

      <option value="OTHER" ${not empty vivhauser.dadiCustomGotra ? 'selected' : ''}>अन्य</option>
    </select>
  </div>

  <div class="col-md-6" id="dadiGotraDiv" style="display:none">
    <label>दादी का गोत्र लिखें</label>
    <input type="text" name="dadiCustomGotra"
           value="${vivhauser.dadiCustomGotra}"
           class="form-control">
  </div>


  <!-- नानी -->
  <div class="col-md-6">
    <label>नानी का नाम (माता की माता)</label>
    <input type="text" name="naniName"
           value="${vivhauser.naniName}"
           class="form-control">
  </div>

  <div class="col-md-6">
    <label>नानी का गोत्र</label>
    <select name="naniGotra" class="form-select"
            onchange="toggleGotra(this,'naniGotraDiv')">

      <option value="">-- गोत्र चुनें --</option>
      <c:forEach items="${gotraList}" var="g">
        <option value="${g.gotraName}"
          ${vivhauser.naniGotra == g.gotraName ? 'selected' : ''}>
          ${g.gotraName}
        </option>
      </c:forEach>

      <option value="OTHER" ${not empty vivhauser.naniCustomGotra ? 'selected' : ''}>अन्य</option>
    </select>
  </div>

  <div class="col-md-6" id="naniGotraDiv" style="display:none">
    <label>नानी का गोत्र लिखें</label>
    <input type="text" name="naniCustomGotra"
           value="${vivhauser.naniCustomGotra}"
           class="form-control">
  </div>





</div>

<!-- परिवार -->
<div class="section-title">पारिवारिक जानकारी</div>
<div class="row g-3 mt-1">
<div class="col-md-6">
<label>पिता का नाम</label>
<input type="text" name="fatherName" value="${vivhauser.fatherName}" class="form-control">
</div>

<div class="col-md-6">
<label>पिता का व्यवसाय</label>
<input type="text" name="fatherOccupation" value="${vivhauser.fatherOccupation}" class="form-control">
</div>



<div class="section-title mt-4">पता विवरण</div>

<div class="row g-3 mt-1">

  <div class="col-md-12">
    <label>मकान / गली / मोहल्ला</label>
    <textarea name="houseAddress"
              class="form-control"
              rows="2">${vivhauser.houseAddress}</textarea>
  </div>

  <div class="col-md-4">
    <label>शहर / कस्बा</label>
    <input type="text"
           name="city"
           value="${vivhauser.city}"
           class="form-control"
           placeholder="जैसे: कोटा">
  </div>

  <div class="col-md-4">
    <label>जिला</label>
    <input type="text"
           name="district"
           value="${vivhauser.district}"
           class="form-control"
           placeholder="जैसे: कोटा">
  </div>

  <div class="col-md-4">
    <label>राज्य</label>
    <input type="text"
           name="state"
           value="${vivhauser.state}"
           class="form-control"
           placeholder="जैसे: राजस्थान">
  </div>

  <div class="col-md-4">
    <label>पिन कोड</label>
    <input type="text"
           name="pincode"
           value="${vivhauser.pincode}"
           class="form-control"
           maxlength="6">
  </div>

</div>

</div>

<!-- जीवनसाथी अपेक्षा -->
<div class="section-title">जीवनसाथी से अपेक्षा</div>
<div class="row g-3 mt-1">
<div class="col-md-6">
<label>अपेक्षित शिक्षा</label>
<input type="text" name="expectedEducation" value="${vivhauser.expectedEducation}" class="form-control">
</div>

<div class="col-md-6">
<label>अपेक्षित आय</label>
<input type="text" name="expectedIncome" value="${vivhauser.expectedIncome}" class="form-control">
</div>

<div class="col-md-12">
<label>अन्य अपेक्षाएँ</label>
<textarea name="expectations" class="form-control">${vivhauser.expectations}</textarea>
</div>
</div>

<!-- ADMIN CONTROLS -->
<!--<c:if test="${isAdmin}">
<div class="admin-box">
<strong>Admin Controls</strong><br><br>
<a href="/vivhauser/approve/${vivhauser.id}" class="btn btn-success btn-sm">✔ Approve</a>
<a href="/vivhauser/reject/${vivhauser.id}" class="btn btn-danger btn-sm">✖ Reject</a>
<a href="/vivhauser/delete/${vivhauser.id}" class="btn btn-dark btn-sm">🗑 Delete</a>
</div>
</c:if>-->

<!-- SUBMIT -->
<div class="text-end mt-4">
<button type="submit" class="btn btn-primary px-4">
${vivhauser.id == null ? 'फॉर्म सबमिट करें' : 'अपडेट करें'}
</button>
</div>

</div>
</div>
</form>

</div>
</div>

<script>
document.getElementById("imageInput").addEventListener("change", function(e){
  const reader = new FileReader();
  reader.onload = function(evt){
    document.getElementById("previewImage").src = evt.target.result;
  }
  if(e.target.files.length>0){
    reader.readAsDataURL(e.target.files[0]);
  }
});
</script>
<script>
function toggleGotra(select, divId){
  const div = document.getElementById(divId);
  const input = div.querySelector('input');
  if(select.value === 'OTHER'){
    div.style.display = 'block';
    input.required = true;
  } else {
    div.style.display = 'none';
    input.required = false;
  }
}

document.addEventListener('DOMContentLoaded', function () {
  document.querySelectorAll('select[onchange^="toggleGotra"]').forEach(function (select) {
    const divId = select.getAttribute('onchange').match(/'([^']+)'/)[1];
    toggleGotra(select, divId);
  });
});
</script>

</body>
</html>

<%@ include file="/WEB-INF/views/includes/footer.jsp" %>
