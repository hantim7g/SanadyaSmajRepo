  // ✅ Profile Save
let latestImagePath = null; // Store the latest uploaded image path globally

// ✅ Submit Profile Data
$('#profileForm').submit(function (e) {
  e.preventDefault();
  const formData = {};
  $('#profileForm').serializeArray().forEach(field => {
    formData[field.name] = field.value;
  });

  if (latestImagePath) {
    formData["profileImagePath"] = latestImagePath; // Include updated path
  }

  $.ajax({
    url: '/api/user/update',
    type: 'POST',
    contentType: 'application/json',
    data: JSON.stringify(formData),
    headers: {
      Authorization: 'Bearer ' + localStorage.getItem("authToken")
    },
    success: function () {
      $('#updateMsg').text("प्रोफ़ाइल सफलतापूर्वक अपडेट हो गई।").removeClass("text-danger").addClass("text-success");
    },
    error: function () {
      $('#updateMsg').text("अपडेट करने में त्रुटि हुई।").removeClass("text-success").addClass("text-danger");
    }
  });
});

// ✅ Image Preview before upload
$('#profileImageInput').change(function () {
  const reader = new FileReader();
  reader.onload = function (e) {
    $('#profilePic').attr('src', e.target.result);
  }
  if (this.files && this.files[0]) {
    reader.readAsDataURL(this.files[0]);
  }
});

// ✅ Image Upload + trigger user update
$('#uploadImageBtn').click(function () {
  const fileInput = $('#profileImageInput')[0];
  if (!fileInput.files.length) return alert("कृपया छवि चुनें।");

  const formData = new FormData();
  formData.append("image", fileInput.files[0]);

  $.ajax({
    url: '/api/user/upload-image',
    method: 'POST',
    data: formData,
    processData: false,
    contentType: false,
    headers: {
      Authorization: 'Bearer ' + localStorage.getItem("authToken")
    },
    success: function (res) {
      latestImagePath = res.imagePath; // Save latest path
      $('#profilePic').attr("src", latestImagePath);
      alert("प्रोफ़ाइल फ़ोटो सफलतापूर्वक अपडेट हो गई।");

      // Auto-save updated path
      $('#profileForm').submit();
    },
    error: function () {
      alert("छवि अपलोड करने में त्रुटि हुई।");
    }
  });
});

$(document).ready(function () {

  $('#addPaymentForm').on('submit', function (e) {
    e.preventDefault();
debugger;	
    const form = this;
    const formData = new FormData();

    // ⬇️ JSON object तैयार करो
    const payment = {
      transactionId: form.transactionId.value,
      amount: parseFloat(form.amount.value),
      paymentMode: form.paymentMode.value,
      description: form.description.value,
      status: form.status.value,
      paymentDate: form.paymentDate.value,
      feeFrom:form.feeFrom.value,
      feeTo:form.feeTo.value,
      reason:form.reason.value
    };

    // 🧾 Add JSON string
    formData.append("payment", JSON.stringify(payment));

    // 📎 Add receipt image if selected
    const receiptFile = form.receiptImage.files[0];
    if (receiptFile) {
      formData.append("receiptImage", receiptFile);
    }

    // 🔐 CSRF (अगर Spring Security है तो यहाँ जोड़ें)
    // formData.append("_csrf", $('meta[name="_csrf"]').attr('content'));

    // 📡 AJAX call
    $.ajax({
      url: '/api/payment/add',
      type: 'POST',
      data: formData,
      processData: false, // don't process
      contentType: false, // let browser set it
      success: function (response) {
        $('#addPaymentMsg').text('✅ भुगतान सफलतापूर्वक जोड़ा गया!');
        form.reset();
        // 🧾 Optionally reload table or page:
        setTimeout(() => location.reload(), 1000);
      },
      error: function (xhr) {
        console.error(xhr);
        $('#addPaymentMsg').text('❌ भुगतान जोड़ने में समस्या आई।');
      }
    });
  });

});

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
              $('#editPaymentForm').submit(function (e) {
      e.preventDefault(); // prevent default form submit

      const form = $(this)[0];
      const formData = new FormData(form);

      $.ajax({
        url: '/api/payment/member/payment/update',
        method: 'POST',
        data: formData,
        processData: false,
        contentType: false,
        success: function (res) {
          debugger;
          if (res.includes("redirect:/")) {
            // Extract redirect URL and redirect
            const redirectUrl = res.replace("redirect:", "").trim();
            window.location.href = redirectUrl;
          } else {
            // Unexpected success message — just show it
            bootbox.alert("✅ " + res);
          }
        },
        error: function (xhr) {
           debugger;
          let msg = "❌ भुगतान अपडेट नहीं हो सका। कृपया पुनः प्रयास करें।";
          if (xhr.responseText) {
            msg = xhr.responseText;
          }
          bootbox.alert({
            title: "त्रुटि",
            message: msg,
            centerVertical: true
          });
        }
      });
    });
            });
            $(document).on('click', '.edit-payment-btn', function () {
              $('#editPaymentId').val($(this).data('id'));
              $('#editTransactionId').val($(this).data('txn'));
              $('#editAmount').val($(this).data('amount'));
              $('#editPaymentMode').val($(this).data('mode'));
              $('#editDescription').val($(this).data('desc'));
              $('#editStatus').val($(this).data('status'));
              $('#editreason').val($(this).data('reason'));


              const dateVal = new Date($(this).data('date')).toISOString().split('T')[0];
              $('#editPaymentDate').val(dateVal);
              const fromDateVal = new Date($(this).data('feefrom')).toISOString().split('T')[0];
              $('#editFeeFrom').val(fromDateVal);
              const toDateVal = new Date($(this).data('feeto')).toISOString().split('T')[0];
              $('#editFeeTo').val(toDateVal);
              const modal = new bootstrap.Modal(document.getElementById('editPaymentModal'));
              modal.show();
            });
