/**
 * Bootstrap Alert Utility Functions
 * Replaces browser alerts with Bootstrap-based alerts
 */

// Success Alert
function showSuccessAlert(message) {
    bootbox.alert({
        title: "<h5 class='text-success text-center'>✅ सफलता</h5>",
        message: `<div class='text-center'>${message}</div>`,
        centerVertical: true,
        buttons: {
            ok: {
                label: 'ठीक है',
                className: 'btn btn-success'
            }
        }
    });
}

// Error Alert
function showErrorAlert(message) {
    bootbox.alert({
        title: "<h5 class='text-danger text-center'>❌ त्रुटि</h5>",
        message: `<div class='text-center'>${message}</div>`,
        centerVertical: true,
        buttons: {
            ok: {
                label: 'ठीक है',
                className: 'btn btn-danger'
            }
        }
    });
}

// Warning Alert
function showWarningAlert(message) {
    bootbox.alert({
        title: "<h5 class='text-warning text-center'>⚠️ चेतावनी</h5>",
        message: `<div class='text-center'>${message}</div>`,
        centerVertical: true,
        buttons: {
            ok: {
                label: 'ठीक है',
                className: 'btn btn-warning'
            }
        }
    });
}

// Info Alert
function showInfoAlert(message) {
    bootbox.alert({
        title: "<h5 class='text-info text-center'>ℹ️ जानकारी</h5>",
        message: `<div class='text-center'>${message}</div>`,
        centerVertical: true,
        buttons: {
            ok: {
                label: 'ठीक है',
                className: 'btn btn-info'
            }
        }
    });
}

// Generic Alert
function showAlert(message) {
    bootbox.alert({
        message: `<div class='text-center'>${message}</div>`,
        centerVertical: true,
        buttons: {
            ok: {
                label: 'ठीक है',
                className: 'btn btn-primary'
            }
        }
    });
}
