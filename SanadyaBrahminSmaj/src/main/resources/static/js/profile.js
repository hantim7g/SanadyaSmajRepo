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

