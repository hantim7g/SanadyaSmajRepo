$(document).ready(function () {
    // DataTable Initialization
    $('#paymentTable').DataTable({
        responsive: true,
        language: { search: "🔍 खोजें:" }
    });

    // Toggle FY Section
    $('select[name="description"]').on('change', function() {
        if (this.value === "वार्षिक शुल्क") {
            $('#fySection').show();
            $('.date-range-group').hide();
        } else {
            $('#fySection').hide();
            $('.date-range-group').show();
        }
    });

    // Profile Save
    let latestImagePath = null;
    $('#profileForm').submit(function (e) {
        e.preventDefault();
        const formData = {};
        $(this).serializeArray().forEach(field => { formData[field.name] = field.value; });
        if (latestImagePath) formData["profileImagePath"] = latestImagePath;

        $.ajax({
            url: '/api/user/update',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(formData),
            success: function () { showSuccessAlert("✅ प्रोफ़ाइल अपडेट हो गई!"); location.reload(); },
            error: function () { showErrorAlert("❌ अपडेट में त्रुटि!"); }
        });
    });

    // Image Upload
    $('#uploadImageBtn').click(function () {
        const fileInput = $('#profileImageInput')[0];
        if (!fileInput.files.length) return showWarningAlert("कृपया छवि चुनें.");
        const fd = new FormData();
        fd.append("image", fileInput.files[0]);

        $.ajax({
            url: '/api/user/upload-image',
            method: 'POST',
            data: fd,
            processData: false,
            contentType: false,
            success: function (res) {
                latestImagePath = res.imagePath;
                $('#profilePic').attr("src", latestImagePath);
                showSuccessAlert("✅ फोटो अपलोड सफल!");
                $('#profileForm').submit();
            }
        });
    });

    // Add Payment Logic (Blob Sync)
    $('#addPaymentForm').submit(function (e) {
        e.preventDefault();
        const formData = new FormData(this);
        const selectedYears = [];
        $('input[name="financialYears"]:checked').each(function() { selectedYears.push($(this).val()); });

        const paymentData = {
            transactionId: formData.get('transactionId'),
            amount: parseFloat(formData.get('amount')),
            paymentMode: formData.get('paymentMode'),
            status: "सफल",
            description: formData.get('description'),
            paymentDate: formData.get('paymentDate'),
            feeFrom: formData.get('feeFrom'),
            feeTo: formData.get('feeTo'),
            reason: formData.get('reason'),
            financialYears: selectedYears
        };

        const finalFd = new FormData();
        finalFd.append('payment', new Blob([JSON.stringify(paymentData)], { type: "application/json" }));
        if (formData.get('receiptImage')) finalFd.append('receiptImage', formData.get('receiptImage'));

        fetch('/api/payment/add', { method: 'POST', body: finalFd })
        .then(() => { showSuccessAlert("✅ भुगतान सहेजा गया!"); location.reload(); });
    });

    // Edit Payment Trigger
    $(document).on('click', '.edit-payment-btn', function () {
        const d = $(this).data();
        $('#editPaymentId').val(d.id);
        $('#editTransactionId').val(d.txn);
        $('#editAmount').val(d.amount);
        $('#editPaymentMode').val(d.mode);
        $('#editDescription').val(d.desc);
        $('#editStatus').val(d.status);
        $('#editreason').val(d.reason);
        
        if(d.date) $('#editPaymentDate').val(new Date(d.date).toISOString().split('T')[0]);
        if(d.feefrom) $('#editFeeFrom').val(new Date(d.feefrom).toISOString().split('T')[0]);
        if(d.feeto) $('#editFeeTo').val(new Date(d.feeto).toISOString().split('T')[0]);

        new bootstrap.Modal(document.getElementById('editPaymentModal')).show();
    });

    // Edit Payment Submit
	// Edit Payment Submit
	$('#editPaymentForm').submit(function (e) {
	    e.preventDefault();
	    
	    // UI Feedback
	    const submitBtn = $(this).find('button[type="submit"]');
	    const originalText = submitBtn.text();
	    submitBtn.prop('disabled', true).text("अपडेट हो रहा है...");

	    $.ajax({
	        url: '/api/payment/member/payment/update', // Controller URL
	        method: 'POST',
	        data: new FormData(this), // 'this' refers to #editPaymentForm
	        processData: false,
	        contentType: false,
	        success: function (response) {
	            showSuccessAlert("✅ " + response);
	            location.reload();
	        },
	        error: function (xhr) {
	            submitBtn.prop('disabled', false).text(originalText);
	            let errorMsg = "❌ अपडेट विफल!";
            if(xhr.responseText) errorMsg += " कारण: " + xhr.responseText;
            showErrorAlert(errorMsg);
	        }
	    });
	});
});