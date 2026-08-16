<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>

<style>
    /* Clean backdrop — the popup is the ONLY login UI */
    .auth-landing {
        min-height: 62vh;
        background: linear-gradient(135deg, #fff3e0 0%, #ffe8cc 100%);
        display: flex;
        align-items: center;
        justify-content: center;
        text-align: center;
    }
    .auth-landing .auth-landing-inner {
        color: #91402c;
    }
    .auth-landing h2 { font-weight: 700; }
    .auth-landing p { color: #6c757d; }
</style>

<div class="container-fluid auth-landing">
    <div class="auth-landing-inner">
        <h2>लॉगिन / पंजीकरण</h2>
        <p>लॉगिन विंडो खुल रही है...</p>
    </div>
</div>

<script>
    $(document).ready(function () {
        // Open the same popup used by the menu button — popup-based login only
        const authModalEl = document.getElementById('authModal');
        if (authModalEl) {
            const authModal = new bootstrap.Modal(authModalEl);
            authModal.show();

            // If user arrived via ?register=true, switch to the पंजीकरण tab
            const params = new URLSearchParams(window.location.search);
            if (params.get('register') === 'true') {
                const registerTab = document.querySelector('#register-tab');
                if (registerTab) bootstrap.Tab.getOrCreateInstance(registerTab).show();
            }
        }
    });
</script>

<%@ include file="/WEB-INF/views/includes/footer.jsp" %>
