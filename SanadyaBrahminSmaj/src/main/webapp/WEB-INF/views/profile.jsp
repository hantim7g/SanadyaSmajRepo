<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

        <!DOCTYPE html>
        <html>
      <%@ include file="/WEB-INF/views/includes/header.jsp" %>

        <head>
          <title>प्रोफ़ाइल</title>]
          

          <style>
            body {
              background: linear-gradient(to right, #f9f9f9, #e9f4ff);
              min-height: 100vh;
            }

            Table Styling .table-container {
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
                  <img id="profilePic" src="${user.profileImagePath != null ? user.profileImagePath : '/logo/logo.png'}"
                    alt="Profile Image">
                  <div class="mt-2">
                    <input type="file" id="profileImageInput" accept="image/*" class="form-control mt-2"
                      style="max-width:300px;margin:auto;">
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
                        <input name="education" type="text" class="form-control editable-input"
                          value="${user.education}">
                      </div>
                      <div class="col-md-6"><label class="label-col">पेशा</label>
                        <input name="occupation" type="text" class="form-control editable-input"
                          value="${user.occupation}">
                      </div>
                      <div class="col-md-6"><label class="label-col">ब्लड ग्रुप</label>
                        <input name="bloodGroup" type="text" class="form-control editable-input"
                          value="${user.bloodGroup}">
                      </div>
                      <div class="col-md-6"><label class="label-col">वैवाहिक स्थिति</label>
                        <select name="maritalStatus" class="form-select editable-input">
                          <option value="">चुनें</option>
                          <option ${user.maritalStatus=='अविवाहित' ? 'selected' : '' }>अविवाहित</option>
                          <option ${user.maritalStatus=='विवाहित' ? 'selected' : '' }>विवाहित</option>
                          <option ${user.maritalStatus=='अन्य' ? 'selected' : '' }>अन्य</option>
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
                    <select name="description" class="form-select" required>
                      <option value="">चुनें</option>
                      <option value="वार्षिक शुल्क">वार्षिक शुल्क</option>
                      <option value="हॉल बुकिंग शुल्क">हॉल बुकिंग शुल्क</option>
                      <option value="दान">दान</option>
                      <option value="सदस्यता शुल्क">सदस्यता शुल्क</option>
                      <option value="अन्य">अन्य</option>
                    </select>
                  </div>
                  <div class="col-md-2">
                    <label class="label-col">स्थिति</label>
                    <select name="status" class="form-select" required>
                      <option value="सफल">सफल</option>
                      <option value="लंबित">लंबित</option>
                      <option value="विफल">विफल</option>
                    </select>
                  </div>
                  <div class="col-md-2">
                    <label class="label-col">भुगतान तिथि</label>
                    <input type="date" class="form-control" name="paymentDate" required />
                  </div>
                  <div class="col-md-2">
                    <label class="label-col">समय से</label>
                    <input type="date" class="form-control" name="feeFrom" required />
                  </div>
                  <div class="col-md-2">
                    <label class="label-col">समय तक</label>
                    <input type="date" class="form-control" name="feeTo" required />
                  </div>
                  <div class="col-md-4">
                    <label class="label-col">रसीद पट्ट अपलोड करें</label>
                    <input type="file" class="form-control" name="receiptImage" accept="image/*" />
                  </div>
                  <div class="col-md-8">
                    <label class="label-col">भुगतान का कारण</label>
                    <textarea name="reason" class="form-control" rows="2"
                      placeholder="उदाहरण: भुगतान की विस्तृत जानकारी लिखें..."></textarea>
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
                      <th>समय से</th>
                       <th>समय तक</th>
                      <th>भुगतान का कारण</th>
                      <th>स्थिति</th>
                      <th>मान्य</th>
                      <th>रसीद</th>
                      <th>एक्शन</th>

                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach items="${paymentList}" var="payment">
                      <tr>
                        <td>
                          <fmt:formatDate value="${payment.paymentDate}" pattern="dd-MM-yyyy HH:mm" />
                        </td>
                        <td>
                          <c:out value="${payment.amount}" />
                        </td>
                        <td>
                          <c:out value="${payment.paymentMode}" />
                        </td>
                        <td>
                          <c:out value="${payment.description}" />
                        </td>
                                                <td>
                          <fmt:formatDate value="${payment.feeFrom}" pattern="dd-MM-yyyy HH:mm" />
                        </td>
                                                <td>
                          <fmt:formatDate value="${payment.feeTo}" pattern="dd-MM-yyyy HH:mm" />
                        </td>
                        <td>
                          <c:out value="${payment.reason}" />
                        </td>

                        <td>
                          <span class="badge 
                ${payment.status == 'सफल' ? 'bg-success' : 
                  payment.status == 'लंबित' ? 'bg-warning text-dark' : 
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
                            <a href="${pageContext.request.contextPath}/images/${payment.receiptImagePath}"
                              target="_blank">
                              <img src="${pageContext.request.contextPath}/images/${payment.receiptImagePath}"
                                class="receipt-thumbnail" alt="Receipt" />
                            </a>
                          </c:if>
                        </td>
                        <td>
                          <c:if test="${payment.validated != 'सत्यापित'}">
                            <button class="btn btn-sm btn-outline-primary edit-payment-btn" data-id="${payment.id}"
                              data-txn="${payment.transactionId}" data-amount="${payment.amount}"
                              data-mode="${payment.paymentMode}" data-desc="${payment.description}"
                              data-status="${payment.status}" data-date="${payment.paymentDate}"
                              data-feeFrom="${payment.feeFrom}" data-feeTo="${payment.feeTo}"
                              data-reason="${payment.reason}">
                              ✏️ संपादित करें
                            </button>
                          </c:if>
                        </td>

                      </tr>
                    </c:forEach>
                  </tbody>
                </table>
              </div>
            </div>


          </div>
                    <script src="${pageContext.request.contextPath}/js/profile.js"></script>
          <script>
            
          </script>
          <!-- ✏️ Edit Payment Modal -->
          <div class="modal fade" id="editPaymentModal" tabindex="-1" aria-labelledby="editPaymentLabel"
            aria-hidden="true">
            <div class="modal-dialog modal-lg">
              <div class="modal-content">
                <form id="editPaymentForm" method="post" action="/api/payment/member/payment/update"
                  enctype="multipart/form-data">
                  <div class="modal-header">
                    <h5 class="modal-title" id="editPaymentLabel">📝 भुगतान विवरण संपादित करें</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="बंद करें"></button>
                  </div>
                  <div class="modal-body">
                    <input type="hidden" name="Id" id="editPaymentId" />

                    <div class="row g-3">
                      <div class="col-md-4">
                        <label>ट्रांजैक्शन आईडी</label>
                        <input type="text" class="form-control" name="transactionId" id="editTransactionId" required />
                      </div>
                      <div class="col-md-2">
                        <label>राशि (₹)</label>
                        <input type="number" class="form-control" name="amount" id="editAmount" step="0.01" required />
                      </div>
                      <div class="col-md-2">
                        <label>माध्यम</label>
                        <select name="paymentMode" class="form-select" id="editPaymentMode" required>
                          <option value="UPI">UPI</option>
                          <option value="Cash">Cash</option>
                          <option value="Bank Transfer">Bank Transfer</option>
                        </select>
                      </div>
                      <div class="col-md-8">
                        <label>टिप्पणी / विवरण</label>
                        <textarea name="reason" id="editreason" class="form-control" rows="2"></textarea>
                      </div>

                      <div class="col-md-2">
                        <label>विवरण</label>
                        <select name="description" class="form-select" id="editDescription" required>
                          <option value="वार्षिक शुल्क">वार्षिक शुल्क</option>
                          <option value="हॉल बुकिंग शुल्क">हॉल बुकिंग शुल्क</option>
                          <option value="दान">दान</option>
                          <option value="सदस्यता शुल्क">सदस्यता शुल्क</option>
                          <option value="अन्य">अन्य</option>
                        </select>
                      </div>
                      <div class="col-md-2">
                        <label>स्थिति</label>
                        <select name="status" class="form-select" id="editStatus" required>
                          <option value="सफल">सफल</option>
                          <option value="लंबित">लंबित</option>
                          <option value="विफल">विफल</option>
                        </select>
                      </div>
                      <div class="col-md-4">
                        <label>भुगतान तिथि</label>
                        <input type="date" class="form-control" name="paymentDate" id="editPaymentDate" required />
                      </div>
                      <div class="col-md-4">
                        <label>समय से</label>
                        <input type="date" class="form-control" name="feeFrom" id="editFeeFrom" required />
                      </div>
                      <div class="col-md-4">
                        <label>समय तक</label>
                        <input type="date" class="form-control" name="feeTo" id="editFeeTo" required />
                      </div>
                      <div class="col-md-4">
                        <label>रसीद अपलोड करें (यदि पुनः जरूरी हो)</label>
                        <input type="file" class="form-control" name="receiptImage" />
                      </div>
                    </div>
                  </div>
                  <div class="modal-footer">
                    <button type="submit" class="btn btn-success">💾 अपडेट करें</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">❌ बंद करें</button>
                  </div>
                </form>
              </div>
            </div>
          </div>

        </body>

        </html>