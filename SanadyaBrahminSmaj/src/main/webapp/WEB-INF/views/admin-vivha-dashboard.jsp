<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/views/includes/header.jsp"%>

<div class="container my-5">
<h3 class="text-center fw-bold">विवाह पंजीकरण – Admin Dashboard</h3>

<table class="table table-bordered table-hover mt-4">
<thead class="table-warning">
<tr>
<th>फोटो</th>
<th>नाम</th>
<th>लिंग</th>
<th>मोबाइल</th>
<th>स्थिति</th>
<th>कार्यवाही</th>
</tr>
</thead>

<tbody>
<c:forEach items="${profiles}" var="p">
<tr>
<td><img src="${p.profileImagePath}" width="60"></td>
<td>${p.name}</td>
<td>${p.gender}</td>
<td>${p.mobile}</td>
<td>
<c:if test="${p.approved}"><span class="badge bg-success">स्वीकृत</span></c:if>
<c:if test="${!p.approved}"><span class="badge bg-danger">लंबित</span></c:if>
</td>
<td>
<a href="/admin/vivha/approve/${p.id}" class="btn btn-success btn-sm">✔</a>
<a href="/admin/vivha/hide/${p.id}" class="btn btn-secondary btn-sm">👁‍🗨</a>
<a href="/admin/vivha/feature/${p.id}" class="btn btn-warning btn-sm">⭐</a>
<a href="/user/vivhauser/pdf/${p.id}" class="btn btn-danger btn-sm">PDF</a>
</td>
</tr>
</c:forEach>
</tbody>
</table>
</div>

<%@ include file="/WEB-INF/views/includes/footer.jsp"%>
