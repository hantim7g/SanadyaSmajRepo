  $(document).ready(function () {
    $('#filterForm').on('submit', function (e) {
      e.preventDefault();
      fetchFilteredUsers(0); // reset to first page on filter
    });

    // other fee Buttons
    $(document).on('click', '.validate-other-btn', function () {
  const userId = $(this).data('user-id');

  // Show modal and loading message
  $('#annualPaymentModal').modal('show');
  $('#annualPaymentModalBody').html('<div class="text-center text-muted">लोड हो रहा है...</div>');

  // Load payment details via AJAX
  $.get('/admin/user/' + userId + '/otherPayments', function (html) {
    $('#annualPaymentModalBody').html(html);
  }).fail(function () {
    $('#annualPaymentModalBody').html('<div class="text-danger text-center">डेटा लोड करने में त्रुटि हुई।</div>');
  });
});










    // Validate Buttons
    $(document).on('click', '.validate-annual-btn', function () {
  const userId = $(this).data('user-id');

  // Show modal and loading message
  $('#annualPaymentModal').modal('show');
  $('#annualPaymentModalBody').html('<div class="text-center text-muted">लोड हो रहा है...</div>');

  // Load payment details via AJAX
  $.get('/admin/user/' + userId + '/annualPayments', function (html) {
    $('#annualPaymentModalBody').html(html);
  }).fail(function () {
    $('#annualPaymentModalBody').html('<div class="text-danger text-center">डेटा लोड करने में त्रुटि हुई।</div>');
  });
});

// Validate individual payment from modal
// Validate individual payment from modal
$(document).on('click', '.validate-payment-btn', function () {
  const paymentId = $(this).data('payment-id');
  const reason = $(this).closest('tr').find('.reason-input').val() || 'सत्यापित किया गया';
  const $btn = $(this);
  $btn.prop("disabled", true).text("⏳ सत्यापन...");

  $.post(`/admin/validatePayment/${paymentId}/${encodeURIComponent(reason)}`, function () {
    alert('भुगतान सत्यापित हुआ');
    $btn.closest('tr').find('td:eq(5) span')
      .removeClass().addClass('badge bg-success').text('सत्यापित');
    $btn.siblings().remove(); // remove reject + input
    $btn.remove();
  }).fail(function () {
    alert('सत्यापन में त्रुटि!');
    $btn.prop("disabled", false).text("✔️ सत्यापित करें");
  });
});

$(document).on('click', '.reject-payment-btn', function () {
  const paymentId = $(this).data('payment-id');
  const reason = $(this).closest('tr').find('.reason-input').val();

  if (!reason) {
    alert('कृपया अस्वीकृति का कारण दर्ज करें।');
    return;
  }

  const $btn = $(this);
  $btn.prop("disabled", true).text("⏳ अस्वीकृति...");

  $.post(`/admin/rejectPayment/${paymentId}/${encodeURIComponent(reason)}`, function () {
    alert('भुगतान अस्वीकृत किया गया');
    $btn.closest('tr').find('td:eq(5) span')
      .removeClass().addClass('badge bg-danger').text('अस्वीकृत');
    $btn.siblings().remove();
    $btn.remove();
  }).fail(function () {
    alert('अस्वीकृति में त्रुटि!');
    $btn.prop("disabled", false).text("❌ अस्वीकृत करें");
  });
});


 /*   $(document).on('click', '.validate-other-btn', function () {
      const userId = $(this).data('user-id');
      $.post('/admin/validateOtherFee/' + userId, function () {
        alert('अन्य शुल्क सत्यापित हुआ');
        fetchFilteredUsers();
      });
    });
*/
   // Approve profile
$(document).on('click', '.validate-profile-btn', function () {
  const userId = $(this).data('user-id');
  $.post('/admin/approveProfile/' + userId, function () {
    alert('प्रोफाइल सत्यापित किया गया');
    fetchFilteredUsers();
  });
});

// Reject profile
$(document).on('click', '.reject-profile-btn', function () {
  const userId = $(this).data('user-id');
  if (confirm('क्या आप वाकई इस प्रोफाइल को अस्वीकृत करना चाहते हैं?')) {
    $.post('/admin/rejectProfile/' + userId, function () {
      alert('प्रोफाइल अस्वीकृत किया गया');
      fetchFilteredUsers();
    });
  }
});


    // Pagination click (memberListAdmin.jsp)
    $(document).on('click', '.page-link-btn', function (e) {
      e.preventDefault();
      const page = $(this).data("page");
      fetchFilteredUsers(page);
    });
  });

  function fetchFilteredUsers(page = 0) {
    const formData = $("#filterForm").serialize();
    const size = $("select[name='size']").val() || 10;
    $.ajax({
      url: '/admin/users/filter?' + formData + '&page=' + page + '&size=' + size,
      type: 'GET',
      success: function (html) {
        $('#userCardListContainer').html(html);
      },
      error: function () {
        alert("डेटा लाने में त्रुटि!");
      }
    });
  }
$(document).on('click', '#resetBtn', function () {
  $('#filterForm')[0].reset(); // Reset form fields
  fetchFilteredUsers();        // Reload default data
});
