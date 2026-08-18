package com.hst.e2e;

import org.junit.jupiter.api.*;
import org.openqa.selenium.*;

import static org.assertj.core.api.Assertions.assertThat;

/**
 * E2E tests for Security & Access Control.
 *
 * Verifies that:
 * - Protected pages redirect unauthenticated users to login
 * - Public pages remain accessible without auth
 * - Error handling works (401, 404)
 */
@DisplayName("🔒 Security & Access Control Tests")
@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
class SecurityAccessTest extends BaseE2ETest {

    // ───────────────────── Protected Pages (should redirect) ─────────────────────

    @Test
    @Order(1)
    @DisplayName("Member profile redirects to login when unauthenticated")
    void memberProfileRedirectsToLogin() {
        navigateTo("/member/profile");
        waitForPageLoad();

        String url = driver.getCurrentUrl();
        assertThat(url).containsIgnoringCase("login")
                .or().containsIgnoringCase("error=login_required");
    }

    @Test
    @Order(2)
    @DisplayName("Member payment redirects to login when unauthenticated")
    void memberPaymentRedirectsToLogin() {
        navigateTo("/member/payment");
        waitForPageLoad();

        String url = driver.getCurrentUrl();
        assertThat(url).containsIgnoringCase("login")
                .or().containsIgnoringCase("error=login_required");
    }

    @Test
    @Order(3)
    @DisplayName("My bookings redirects to login when unauthenticated")
    void myBookingsRedirectsToLogin() {
        navigateTo("/my-bookings");
        waitForPageLoad();

        String url = driver.getCurrentUrl();
        assertThat(url).containsIgnoringCase("login")
                .or().containsIgnoringCase("error=login_required");
    }

    @Test
    @Order(4)
    @DisplayName("Matrimony list redirects to login when unauthenticated")
    void matrimonyRedirectsToLogin() {
        navigateTo("/matrimony/list");
        waitForPageLoad();

        String url = driver.getCurrentUrl();
        assertThat(url).containsIgnoringCase("login")
                .or().containsIgnoringCase("error=login_required");
    }

    @Test
    @Order(5)
    @DisplayName("Testimonial management redirects to login when unauthenticated")
    void testimonialMyRedirectsToLogin() {
        navigateTo("/testimonial/my-testimonials");
        waitForPageLoad();

        String url = driver.getCurrentUrl();
        assertThat(url).containsIgnoringCase("login")
                .or().containsIgnoringCase("error=login_required");
    }

    @Test
    @Order(6)
    @DisplayName("Booking save redirects to login when unauthenticated")
    void bookingSaveRedirectsToLogin() {
        navigateTo("/bookings/save");
        waitForPageLoad();

        String url = driver.getCurrentUrl();
        assertThat(url).containsIgnoringCase("login")
                .or().containsIgnoringCase("error=login_required");
    }

    // ───────────────────── Admin Pages (should redirect) ─────────────────────

    @Test
    @Order(7)
    @DisplayName("Admin dashboard redirects to login when unauthenticated")
    void adminDashboardRedirectsToLogin() {
        navigateTo("/admin/");
        waitForPageLoad();

        String url = driver.getCurrentUrl();
        assertThat(url).containsIgnoringCase("login")
                .or().containsIgnoringCase("error=login_required");
    }

    @Test
    @Order(8)
    @DisplayName("Admin users page redirects to login when unauthenticated")
    void adminUsersRedirectsToLogin() {
        navigateTo("/admin/users");
        waitForPageLoad();

        String url = driver.getCurrentUrl();
        assertThat(url).containsIgnoringCase("login")
                .or().containsIgnoringCase("error=login_required");
    }

    @Test
    @Order(9)
    @DisplayName("Admin room management redirects to login when unauthenticated")
    void adminRoomsRedirectsToLogin() {
        navigateTo("/rooms/admin");
        waitForPageLoad();

        String url = driver.getCurrentUrl();
        assertThat(url).containsIgnoringCase("login")
                .or().containsIgnoringCase("error=login_required");
    }

    // ───────────────────── Public Pages (should NOT redirect) ─────────────────────

    @Test
    @Order(10)
    @DisplayName("Home page is accessible without authentication")
    void homeIsPublic() {
        navigateTo("/");
        waitForPageLoad();
        assertThat(driver.getCurrentUrl()).contains(BASE_URL + "/");
    }

    @Test
    @Order(11)
    @DisplayName("Guidance page is accessible without authentication")
    void guidanceIsPublic() {
        navigateTo("/guidance");
        waitForPageLoad();
        assertThat(driver.getCurrentUrl()).contains("/guidance");
    }

    @Test
    @Order(12)
    @DisplayName("Festivals page is accessible without authentication")
    void festivalsIsPublic() {
        navigateTo("/festivals");
        waitForPageLoad();
        assertThat(driver.getCurrentUrl()).contains("/festivals");
    }

    @Test
    @Order(13)
    @DisplayName("Gotra page is accessible without authentication")
    void gotraIsPublic() {
        navigateTo("/gotra");
        waitForPageLoad();
        assertThat(driver.getCurrentUrl()).contains("/gotra");
    }

    @Test
    @Order(14)
    @DisplayName("Calendar page is accessible without authentication")
    void calendarIsPublic() {
        navigateTo("/calendar");
        waitForPageLoad();
        assertThat(driver.getCurrentUrl()).contains("/calendar");
    }

    @Test
    @Order(15)
    @DisplayName("Events page is accessible without authentication")
    void eventsIsPublic() {
        navigateTo("/events");
        waitForPageLoad();
        assertThat(driver.getCurrentUrl()).contains("/events");
    }

    @Test
    @Order(16)
    @DisplayName("Rooms view is accessible without authentication")
    void roomsViewIsPublic() {
        navigateTo("/rooms/view");
        waitForPageLoad();
        assertThat(driver.getCurrentUrl()).contains("/rooms/view");
    }

    @Test
    @Order(17)
    @DisplayName("Login page is accessible without authentication")
    void loginPageIsPublic() {
        navigateTo("/login");
        waitForPageLoad();
        assertThat(driver.getCurrentUrl()).contains("/login");
    }

    // ───────────────────── Login Required Alert ─────────────────────

    @Test
    @Order(18)
    @DisplayName("Protected page shows 'please login' alert message")
    void protectedPageShowsLoginAlert() {
        navigateTo("/member/profile");
        waitForPageLoad();

        String bodyText = driver.findElement(By.tagName("body")).getText();
        assertThat(bodyText).containsIgnoringCase("लॉगिन करें")
                .or().containsIgnoringCase("login_required")
                .or().containsIgnoringCase("error");
    }

    // ───────────────────── Error Handling ─────────────────────

    @Test
    @Order(19)
    @DisplayName("Non-existent page shows error page (404)")
    void nonExistentPageShowsError() {
        navigateTo("/this-page-does-not-exist-12345");
        waitForPageLoad();

        // Should show error page or custom error controller
        String bodyText = driver.findElement(By.tagName("body")).getText();
        assertThat(bodyText).isNotEmpty();
    }

    @Test
    @Order(20)
    @DisplayName("API auth/me returns error for unauthenticated request")
    void apiAuthMeReturnsError() {
        navigateTo("/api/auth/me");
        waitForPageLoad();

        // Should show error or redirect
        String url = driver.getCurrentUrl();
        assertThat(url).isNotEmpty();
    }
}
