<%@ page language="java"  contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="profile-card">
  <div class="table-responsive">
    <table class="table table-bordered table-hover">
      <thead class="table-dark">
        <tr>
          <th>भुगतान तिथि</th>
          <th>राशि (₹)</th>
          <th>माध्यम</th>
          <th>विवरण</th>
          <th>स्थिति</th>
          <th>मान्य</th>
          <th>रसीद</th>
          <th>भुगतान का कारण</th>
           <th>एक्शन</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach items="${paymentList}" var="payment">
          <tr>
            <td><fmt:formatDate value="${payment.paymentDate}" pattern="dd-MM-yyyy HH:mm" /></td>
            <td>${payment.amount}</td>
            <td>${payment.paymentMode}</td>
            <td>${payment.description}</td>
            <td>
              <span class="badge 
                ${payment.status == 'सफल' ? 'bg-success' : 
                  payment.status == 'Pending' ? 'bg-warning text-dark' : 
                  'bg-danger'}">
                ${payment.status}
              </span>
            </td>
            <td>
              <span class="badge 
                ${payment.validated == 'सत्यापित' ? 'bg-success' : 
                  payment.validated == 'प्रक्रिया में' ? 'bg-warning text-dark' : 
                  'bg-danger'}">
                ${payment.validated}
              </span>
            </td>
            <td>
              <c:if test="${not empty payment.receiptImagePath}">
                <a href="${payment.receiptImagePath}" target="_blank">
                  <img src="${payment.receiptImagePath}" class="receipt-thumbnail" style="height: 50px;" alt="Receipt" />
                </a>
              </c:if>
            </td>
             <td>${payment.reason}</td>
              <td>
  <c:if test="${payment.validated != 'सत्यापित'}">
    <button class="btn btn-sm btn-success validate-payment-btn" data-payment-id="${payment.id}">
      ✔️ सत्यापित करें
    </button>
    <button class="btn btn-sm btn-danger reject-payment-btn" data-payment-id="${payment.id}">
      ❌ अस्वीकृत करें
    </button>
    <input type="text" class="form-control mt-1 reason-input" placeholder="कारण दर्ज करें..." />
  </c:if>
</td>

            </td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </div>
</div>
