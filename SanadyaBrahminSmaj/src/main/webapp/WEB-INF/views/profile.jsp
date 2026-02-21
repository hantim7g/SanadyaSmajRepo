<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="hi">
<%@ include file="/WEB-INF/views/includes/header.jsp" %>

<head>
    <title>प्रोफ़ाइल एवं भुगतान</title>
    <style>
        body { background: #fffaf4; font-family: 'Segoe UI', 'Noto Sans Devanagari', sans-serif; min-height: 100vh; }
        .container { padding-top: 40px; padding-bottom: 60px; }
        .profile-card { background: linear-gradient(93deg, #fff7ed 65%, #ffedc2 100%); border-radius: 18px; box-shadow: 0 4px 15px rgba(160, 128, 32, 0.1); padding: 30px; margin-bottom: 35px; border: 1px solid #f1c37a; }
        .card-title { font-size: 1.5rem; font-weight: 800; color: #5e3400; border-bottom: 2px solid #e7c089; padding-bottom: 10px; margin-bottom: 25px; }
        .label-col { font-weight: 700; color: #6b3a00; margin-bottom: 5px; display: block; }
        .form-control, .form-select { border-radius: 10px; border: 1px solid #f1c37a; padding: 10px 15px; }
        .readonly-input { background-color: #fdf2e4; font-weight: 600; color: #5a3200; }
        .btn-premium { background: linear-gradient(95deg, #0ca100 60%, #32d653 100%); border: none; color: white; font-weight: 700; padding: 10px 25px; border-radius: 10px; transition: 0.3s; cursor: pointer; }
        .badge { padding: 6px 12px; border-radius: 8px; font-weight: 600; display: inline-block; min-width: 85px; text-align: center; }
        .badge-success { background-color: #0ca100 !important; color: white !important; }
        .badge-warning { background-color: #ffc107 !important; color: #332b00 !important; }
        .badge-danger { background-color: #dc3545 !important; color: white !important; }
        .receipt-thumbnail { width: 45px; height: 45px; object-fit: cover; border-radius: 6px; border: 1px solid #ddd; transition: transform 0.2s; }
        .receipt-thumbnail:hover { transform: scale(2.5); z-index: 10; }
        .fy-checkbox-group { display: flex; flex-wrap: wrap; gap: 12px; border: 1px solid #f1c37a; padding: 15px; border-radius: 12px; background: #fff; }
    </style>
</head>

<body>
    <div class="container">
        <div class="profile-card">
            <h3 class="card-title"> आपकी विस्तृत प्रोफ़ाइल</h3>
            <div class="row">
                <div class="col-md-3 text-center mb-4">
                    <img id="profilePic" src="${not empty user.profileImagePath ? user.profileImagePath : '/images/default.png'}" alt="Profile" style="width:200px; height:200px; object-fit:cover; border-radius:15px; border:4px solid #fff;">
                    <div class="mt-3">
                        <input type="file" id="profileImageInput" accept="image/*" class="form-control form-control-sm mb-2">
                        <button id="uploadImageBtn" class="btn btn-sm btn-outline-primary w-100">📤 फोटो बदलें</button>
                    </div>
                </div>
                <div class="col-md-9">
                    <form id="profileForm">
                        <input type="hidden" name="id" value="${user.id}" />
                        <div class="row g-3">
                            <div class="col-md-4"><label class="label-col">पूरा नाम</label><input type="text" class="form-control readonly-input" name="fullName" value="${user.fullName}" readonly></div>
                            <div class="col-md-4"><label class="label-col">पिता का नाम</label><input name="fatherName" type="text" class="form-control" value="${user.fatherName}"></div>
                            <div class="col-md-4"><label class="label-col">गोत्र</label><input name="gotra" type="text" class="form-control" value="${user.gotra}"></div>
                            <div class="col-md-4"><label class="label-col">मोबाइल</label><input type="text" class="form-control readonly-input" name="mobile" value="${user.mobile}" readonly></div>
                            <div class="col-md-4"><label class="label-col">ईमेल</label><input name="email" type="email" class="form-control" value="${user.email}"></div>
                            <div class="col-md-4"><label class="label-col">जन्म तिथि</label><input name="dateOfBirth" type="date" class="form-control" value="${user.dateOfBirth}"></div>                            
                            <div class="col-md-12"><label class="label-col">स्थाई पता</label><input name="address" type="text" class="form-control" value="${user.address}"></div>
                            <div class="col-md-4"><label class="label-col">शैक्षणिक योग्यता</label><input name="education" type="text" class="form-control" value="${user.education}"></div>
                            <div class="col-md-4"><label class="label-col">पेशा / कार्य</label><input name="occupation" type="text" class="form-control" value="${user.occupation}"></div>
                            <div class="col-md-4"><label class="label-col">ब्लड ग्रुप</label><input name="bloodGroup" type="text" class="form-control" value="${user.bloodGroup}"></div>
                            <div class="col-md-4"><label class="label-col">आधार नंबर</label><input name="aadharNumber" type="text" class="form-control" value="${user.aadharNumber}"></div>
                            <div class="col-md-4"><label class="label-col">जिला</label><input name="homeDistrict" type="text" class="form-control" value="${user.homeDistrict}"></div>
                            <div class="col-md-4">
                                <label class="label-col">वैवाहिक स्थिति</label>
                                <select name="maritalStatus" class="form-select">
                                    <option value="अविवाहित" ${user.maritalStatus == 'अविवाहित' ? 'selected' : ''}>अविवाहित</option>
                                    <option value="विवाहित" ${user.maritalStatus == 'विवाहित' ? 'selected' : ''}>विवाहित</option>
                                    <option value="अन्य" ${user.maritalStatus == 'अन्य' ? 'selected' : ''}>अन्य</option>
                                </select>
                            </div>
                            <div class="col-md-12"><label class="label-col">संस्था / संगठन</label><input name="organizationAffiliation" type="text" class="form-control" value="${user.organizationAffiliation}"></div>
                            <div class="col-md-12 text-end mt-4"><button type="submit" class="btn btn-premium w-25">💾 प्रोफ़ाइल अपडेट करें</button></div>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <div class="profile-card d-none">
            <h4 class="card-title">➕ नया भुगतान जोडें</h4>
            <form id="addPaymentForm" enctype="multipart/form-data">
                <div class="row g-3">
                    <div class="col-md-4"><label class="label-col">ट्रांजैक्शन आईडी</label><input type="text" class="form-control" name="transactionId" required /></div>
                    <div class="col-md-2"><label class="label-col">राशि (₹)</label><input type="number" step="0.01" class="form-control" name="amount" required /></div>
                    <div class="col-md-3">
                        <label class="label-col">माध्यम</label>
                        <select name="paymentMode" class="form-select" required>
                            <option value="UPI">UPI / ऑनलाइन</option>
                            <option value="Cash">Cash (नकद)</option>
                            <option value="Bank Transfer">Bank Transfer</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label class="label-col">विवरण</label>
                        <select name="description" class="form-select" required>
                            <option value="">-- चुनें --</option>
                            <option value="वार्षिक शुल्क">वार्षिक शुल्क</option>
                            <option value="दान">दान</option>
                            <option value="सदस्यता शुल्क">सदस्यता शुल्क</option>
                        </select>
                    </div>
                    <div class="col-12" id="fySection" style="display:none;">
                        <label class="label-col">वित्तीय वर्ष चुनें</label>
                        <div class="fy-checkbox-group">
                            <label><input type="checkbox" name="financialYears" value="2024-25"> <span>2024-25</span></label>
                            <label><input type="checkbox" name="financialYears" value="2025-26"> <span>2025-26</span></label>
                        </div>
                    </div>
                    <div class="col-md-3 date-range-group"><label class="label-col">समय से</label><input type="date" class="form-control" name="feeFrom" /></div>
                    <div class="col-md-3 date-range-group"><label class="label-col">समय तक</label><input type="date" class="form-control" name="feeTo" /></div>
                    <div class="col-md-3"><label class="label-col">भुगतान तिथि</label><input type="date" class="form-control" name="paymentDate" required /></div>
                    <div class="col-md-3"><label class="label-col">रसीद</label><input type="file" class="form-control" name="receiptImage" /></div>
                    <div class="col-md-12"><label class="label-col">टिप्पणी</label><textarea name="reason" class="form-control" rows="2"></textarea></div>
                    <input type="hidden" name="status" value="लंबित">
                </div>
                <div class="text-end mt-4"><button type="submit" class="btn btn-premium">💳 भुगतान सुरक्षित करें</button></div>
            </form>
            <div id="addPaymentMsg" class="mt-2 fw-bold text-center"></div>
        </div>

        <div class="profile-card d-none">
            <h4 class="card-title">🧾 भुगतान इतिहास</h4>
            <div class="table-responsive">
                <table id="paymentTable" class="table table-hover beautiful-table w-100">
                    <thead>
                        <tr>
                            <th >ट्रांजैक्शन आईडी</th><th>भुगतान तिथि</th><th>समय से</th><th>समय तक</th><th>माध्यम</th><th>राशि</th><th>विवरण</th><th>सत्यापन</th><th>रसीद</th><th>एक्शन</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${paymentList}" var="p">
                            <tr>
								<td class="fw-bold">${p.transactionId}</td>
								                                <td>${p.paymentDate}</td>
																<td>${p.feeFrom}</td>
																<td>${p.feeTo}</td>
																<td>${p.paymentMode}</td>

                                <td class="fw-bold">₹${p.amount}</td>
                                <td>${p.description}</td>
<!--                                <td><span class="fw-bold badge ${p.status == 'सफल' ? 'badge-success' : (p.status == 'विफल' ? 'badge-danger' : 'badge-warning')}">${p.status}</span></td>
-->                                <td><span class="fw-bold badge ${p.validated == 'सत्यापित' ? 'badge-success' : 'badge-warning'}">${p.validated}</span></td>
                                <td>
                                    <c:if test="${not empty p.receiptImagePath}">
                                        <a href="${p.receiptImagePath}" target="_blank"><img src="${p.receiptImagePath}" class="receipt-thumbnail"></a>
                                    </c:if>
                                </td>
                                <td>
                                    <c:if test="${p.validated != 'सत्यापित'}">
                                        <button class="btn btn-sm btn-outline-primary edit-payment-btn" 
                                            data-id="${p.id}" data-txn="${p.transactionId}" data-amount="${p.amount}" 
                                            data-mode="${p.paymentMode}" data-desc="${p.description}" 
                                            data-date="${p.paymentDate}" data-feefrom="${p.feeFrom}" 
                                            data-feeto="${p.feeTo}" data-reason="${p.reason}" data-status="${p.status}">✏️</button>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

	<div class="modal fade d-none" id="editPaymentModal" tabindex="-1">
	    <div class="modal-dialog modal-lg">
	        <div class="modal-content" style="border-radius: 20px;">
	            <div class="modal-header" style="background: #5e3400; color: white;">
	                <h5 class="modal-title">📝 भुगतान विवरण संपादित करें</h5>
	                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
	            </div>
	            <div class="modal-body">
	                <form id="editPaymentForm" enctype="multipart/form-data">
	                    <input type="hidden" name="Id" id="editPaymentId" />
	                    
	                    <div class="row g-3">
	                        <div class="col-md-6">
	                            <label class="label-col">ट्रांजैक्शन आईडी</label>
	                            <input type="text" class="form-control" name="transactionId" id="editTransactionId" required />
	                        </div>
	                        <div class="col-md-3">
	                            <label class="label-col">राशि (₹)</label>
	                            <input type="number" step="0.01" class="form-control" name="amount" id="editAmount" required />
	                        </div>
	                        <div class="col-md-3">
	                            <label class="label-col">माध्यम</label>
	                            <select name="paymentMode" id="editPaymentMode" class="form-select">
	                                <option value="UPI">UPI / ऑनलाइन</option>
	                                <option value="Cash">Cash (नकद)</option>
	                                <option value="Bank Transfer">Bank Transfer</option>
	                            </select>
	                        </div>
	                        <div class="col-md-6">
	                            <label class="label-col">विवरण</label>
	                            <input type="text" class="form-control" name="description" id="editDescription" readonly />
	                        </div>
	                        <div class="col-md-6">
	                            <label class="label-col">भुगतान तिथि</label>
	                            <input type="date" class="form-control" name="paymentDate" id="editPaymentDate" required />
	                        </div>
	                        <div class="col-md-6">
	                            <label class="label-col">समय से (Fee From)</label>
	                            <input type="date" class="form-control" name="feeFrom" id="editFeeFrom" />
	                        </div>
	                        <div class="col-md-6">
	                            <label class="label-col">समय तक (Fee To)</label>
	                            <input type="date" class="form-control" name="feeTo" id="editFeeTo" />
	                        </div>
	                        <div class="col-md-12">
	                            <label class="label-col">नई रसीद (यदि बदलनी हो)</label>
	                            <input type="file" class="form-control" name="receiptImage" id="editReceiptImage" accept="image/*" />
	                        </div>
	                        <div class="col-12">
	                            <label class="label-col">टिप्पणी / कारण</label>
	                            <textarea name="reason" id="editreason" class="form-control" rows="2"></textarea>
	                        </div>
	                        <input type="hidden" name="status" id="editStatus">
	                    </div>
	                    <div class="text-end mt-4">
	                        <button type="submit" class="btn btn-premium">💾 बदलाव सुरक्षित करें</button>
	                    </div>
	                </form>
	            </div>
	        </div>
	    </div>
	</div>
  
    <script src="${pageContext.request.contextPath}/js/profile.js"></script>
</body>
</html>