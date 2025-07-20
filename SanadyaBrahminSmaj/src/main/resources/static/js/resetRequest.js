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
debugger;
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
