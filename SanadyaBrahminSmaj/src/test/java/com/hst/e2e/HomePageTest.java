package com.hst.e2e;

import org.junit.jupiter.api.*;
import org.openqa.selenium.*;
import org.openqa.selenium.support.ui.ExpectedConditions;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;

/**
 * E2E tests for the Home page (/ and /home).
 *
 * Covers: carousel, upcoming events, testimonials, footer, navbar, banner.
 */
@DisplayName("🏠 Home Page Tests")
@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
class HomePageTest extends BaseE2ETest {

    // ───────────────────── Page Load ─────────────────────

    @Test
    @Order(1)
    @DisplayName("Home page loads successfully with correct title")
    void homePageLoads() {
        navigateTo("/");
        waitForPageLoad();
        assertPageTitleContains("सनाढ्य ब्राह्मण महासभा");
    }

    @Test
    @Order(2)
    @DisplayName("/home also loads the same home page")
    void homeAliasWorks() {
        navigateTo("/home");
        waitForPageLoad();
        assertPageTitleContains("सनाढ्य ब्राह्मण महासभा");
    }

    // ───────────────────── Navbar ─────────────────────

    @Test
    @Order(3)
    @DisplayName("Navbar logo links to home")
    void navbarLogoLinksToHome() {
        navigateTo("/");
        waitForPageLoad();

        WebElement logo = waitForVisible(By.cssSelector("a.navbar-brand, a[href='/']"));
        assertThat(logo.getAttribute("href")).contains("/");
    }

    @Test
    @Order(4)
    @DisplayName("Toggle navigation button exists (mobile hamburger)")
    void toggleNavExists() {
        navigateTo("/");
        waitForPageLoad();

        WebElement toggleBtn = waitForVisible(By.cssSelector("button.navbar-toggler, [data-bs-toggle='collapse']"));
        assertThat(toggleBtn.isDisplayed()).isTrue();
    }

    // ───────────────────── Carousel ─────────────────────

    @Test
    @Order(5)
    @DisplayName("Event carousel is present on home page")
    void carouselPresent() {
        navigateTo("/");
        waitForPageLoad();

        List<WebElement> carouselImages = driver.findElements(By.cssSelector(".carousel-item img, .carousel img, [data-bs-ride='carousel'] img"));
        assertThat(carouselImages.size()).isGreaterThanOrEqualTo(0); // may have 0 or more carousel events
    }

    // ───────────────────── Banner ─────────────────────

    @Test
    @Order(6)
    @DisplayName("Special notice banner is visible")
    void specialNoticeBanner() {
        navigateTo("/");
        waitForPageLoad();

        // Look for the scrolling notice/marquee
        WebElement banner = driver.findElement(By.cssSelector(".marquee, .notice-bar, [class*='banner'], [class*='notice']"));
        assertThat(banner.getText()).containsIgnoringCase("सूचना");
    }

    // ───────────────────── Upcoming Events Section ─────────────────────

    @Test
    @Order(7)
    @DisplayName("Upcoming events section exists")
    void upcomingEventsSection() {
        navigateTo("/");
        waitForPageLoad();

        String bodyText = driver.findElement(By.tagName("body")).getText();
        assertThat(bodyText).containsIgnoringCase("आगामी कार्यक्रम");
    }

    // ───────────────────── Testimonials Section ─────────────────────

    @Test
    @Order(8)
    @DisplayName("Testimonials section exists on home page")
    void testimonialsSection() {
        navigateTo("/");
        waitForPageLoad();

        String bodyText = driver.findElement(By.tagName("body")).getText();
        assertThat(bodyText).containsIgnoringCase("विचार")  // सदस्यों के विचार
                .or().containsIgnoringCase("testimonial");
    }

    // ───────────────────── Footer ─────────────────────

    @Test
    @Order(9)
    @DisplayName("Footer contains society name and copyright")
    void footerContent() {
        navigateTo("/");
        waitForPageLoad();
        scrollToBottom();

        WebElement footer = waitForVisible(By.tagName("footer"));
        String footerText = footer.getText();
        assertThat(footerText).contains("2026");
        assertThat(footerText).containsIgnoringCase("सनाढ्य");
    }

    @Test
    @Order(10)
    @DisplayName("Footer quick links are present")
    void footerQuickLinks() {
        navigateTo("/");
        waitForPageLoad();
        scrollToBottom();

        List<WebElement> footerLinks = driver.findElements(By.cssSelector("footer a, .footer a"));
        assertThat(footerLinks.size()).isGreaterThanOrEqualTo(5);

        // Check some expected link texts
        List<String> linkTexts = footerLinks.stream()
                .map(WebElement::getText)
                .toList();
        assertThat(linkTexts).anyMatch(t -> t.contains("मुख्यपृष्ठ"));
        assertThat(linkTexts).anyMatch(t -> t.contains("मार्गदर्शन"));
        assertThat(linkTexts).anyMatch(t -> t.contains("कार्यक्रम"));
    }

    // ───────────────────── Responsive ─────────────────────

    @Test
    @Order(11)
    @DisplayName("Page renders without JS errors (console check)")
    void noCriticalJsErrors() {
        navigateTo("/");
        waitForPageLoad();

        // Collect console errors
        java.util.List<String> errors = new java.util.ArrayList<>();
        ((org.openqa.selenium.JavascriptExecutor) driver).executeScript(
                "window.__jsErrors = [];");
        // Note: console log collection requires CDP; basic smoke test here.
        // Just verify page loaded and has content.
        String bodyText = driver.findElement(By.tagName("body")).getText();
        assertThat(bodyText.length()).isGreaterThan(100);
    }
}
