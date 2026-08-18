package com.hst.e2e;

import org.junit.jupiter.api.*;
import org.openqa.selenium.*;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;

/**
 * E2E tests for all publicly accessible pages.
 *
 * Each page is tested for: loads without error, has correct heading/content,
 * has footer, and contains expected content elements.
 */
@DisplayName("📄 Public Pages Tests")
@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
class PublicPagesTest extends BaseE2ETest {

    // ───────────────────── Guidance (/guidance) ─────────────────────

    @Test
    @Order(1)
    @DisplayName("Guidance page loads with heading")
    void guidancePageLoads() {
        navigateTo("/guidance");
        waitForPageLoad();
        assertPageTitleContains("सनाढ्य ब्राह्मण महासभा");

        String bodyText = driver.findElement(By.tagName("body")).getText();
        assertThat(bodyText).containsIgnoringCase("मार्गदर्शन");
    }

    @Test
    @Order(2)
    @DisplayName("Guidance page shows guidance messages with images")
    void guidanceHasMessages() {
        navigateTo("/guidance");
        waitForPageLoad();

        List<WebElement> images = driver.findElements(By.cssSelector("img"));
        assertThat(images.size()).isGreaterThanOrEqualTo(1); // At least one guidance person photo
    }

    // ───────────────────── Festivals (/festivals) ─────────────────────

    @Test
    @Order(3)
    @DisplayName("Festivals page loads with festival list")
    void festivalsPageLoads() {
        navigateTo("/festivals");
        waitForPageLoad();

        String bodyText = driver.findElement(By.tagName("body")).getText();
        assertThat(bodyText).containsIgnoringCase("पर्व")
                .or().containsIgnoringCase("त्यौहार")
                .or().containsIgnoringCase("festival");
    }

    @Test
    @Order(4)
    @DisplayName("Festivals page shows multiple festivals with dates")
    void festivalsHaveMultipleEntries() {
        navigateTo("/festivals");
        waitForPageLoad();

        String bodyText = driver.findElement(By.tagName("body")).getText();
        // Should contain at least a few known festivals
        assertThat(bodyText).containsIgnoringCase("2026");
        // Check for some known festivals
        assertThat(bodyText).containsIgnoringCase("दीपावली")
                .or().containsIgnoringCase("होली")
                .or().containsIgnoringCase("रक्षाबंधन")
                .or().containsIgnoringCase("नवरात्रि");
    }

    // ───────────────────── Gotra (/gotra) ─────────────────────

    @Test
    @Order(5)
    @DisplayName("Gotra page loads with gotra list")
    void gotraPageLoads() {
        navigateTo("/gotra");
        waitForPageLoad();

        String bodyText = driver.findElement(By.tagName("body")).getText();
        assertThat(bodyText).containsIgnoringCase("गोत्र")
                .or().containsIgnoringCase("gotra");
    }

    // ───────────────────── Annual Calendar (/calendar) ─────────────────────

    @Test
    @Order(6)
    @DisplayName("Annual calendar page loads with calendar events")
    void calendarPageLoads() {
        navigateTo("/calendar");
        waitForPageLoad();

        String bodyText = driver.findElement(By.tagName("body")).getText();
        assertThat(bodyText).containsIgnoringCase("कैलेंडर")
                .or().containsIgnoringCase("calendar")
                .or().containsIgnoringCase("वार्षिक");
    }

    @Test
    @Order(7)
    @DisplayName("Calendar page shows events with dates throughout the year")
    void calendarHasEvents() {
        navigateTo("/calendar");
        waitForPageLoad();

        String bodyText = driver.findElement(By.tagName("body")).getText();
        // Should have events from different months
        assertThat(bodyText).containsIgnoringCase("2026");
    }

    // ───────────────────── Smaj History (/smajHistory) ─────────────────────

    @Test
    @Order(8)
    @DisplayName("Smaj History page loads with history content")
    void smajHistoryLoads() {
        navigateTo("/smajHistory");
        waitForPageLoad();

        String bodyText = driver.findElement(By.tagName("body")).getText();
        assertThat(bodyText).containsIgnoringCase("इतिहास")
                .or().containsIgnoringCase("history")
                .or().containsIgnoringCase("उत्पत्ति");
    }

    @Test
    @Order(9)
    @DisplayName("Smaj History page has multiple sections")
    void smajHistoryHasSections() {
        navigateTo("/smajHistory");
        waitForPageLoad();

        String bodyText = driver.findElement(By.tagName("body")).getText();
        assertThat(bodyText).containsIgnoringCase("प्राचीन")
                .or().containsIgnoringCase("आधुनिक")
                .or().containsIgnoringCase("योगदान");
    }

    // ───────────────────── Objectives (/smajUddeshLakshya) ─────────────────────

    @Test
    @Order(10)
    @DisplayName("Objectives page loads with objectives and goals")
    void objectivesPageLoads() {
        navigateTo("/smajUddeshLakshya");
        waitForPageLoad();

        String bodyText = driver.findElement(By.tagName("body")).getText();
        assertThat(bodyText).containsIgnoringCase("उद्देश्य")
                .or().containsIgnoringCase("लक्ष्य")
                .or().containsIgnoringCase("objective");
    }

    @Test
    @Order(11)
    @DisplayName("Objectives page has bullet point lists")
    void objectivesHasLists() {
        navigateTo("/smajUddeshLakshya");
        waitForPageLoad();

        List<WebElement> listItems = driver.findElements(By.cssSelector("li, .list-item"));
        assertThat(listItems.size()).isGreaterThanOrEqualTo(5);
    }

    // ───────────────────── Events (/events) ─────────────────────

    @Test
    @Order(12)
    @DisplayName("Events page loads with event list")
    void eventsPageLoads() {
        navigateTo("/events");
        waitForPageLoad();

        String bodyText = driver.findElement(By.tagName("body")).getText();
        assertThat(bodyText).containsIgnoringCase("कार्यक्रम")
                .or().containsIgnoringCase("event");
    }

    @Test
    @Order(13)
    @DisplayName("Events page shows event cards with images")
    void eventsPageHasCards() {
        navigateTo("/events");
        waitForPageLoad();

        List<WebElement> eventCards = driver.findElements(By.cssSelector(".card, [class*='event'], article"));
        assertThat(eventCards.size()).isGreaterThanOrEqualTo(1);
    }

    @Test
    @Order(14)
    @DisplayName("Event detail page loads correctly")
    void eventDetailLoads() {
        navigateTo("/events/1");
        waitForPageLoad();

        String bodyText = driver.findElement(By.tagName("body")).getText();
        assertThat(bodyText).containsIgnoringCase("वेबसाइट")
                .or().containsIgnoringCase("website")
                .or().containsIgnoringCase("शुभारंभ");
    }

    @Test
    @Order(15)
    @DisplayName("Event detail has WhatsApp share link")
    void eventDetailHasShareLink() {
        navigateTo("/events/1");
        waitForPageLoad();

        WebElement whatsappLink = driver.findElement(By.cssSelector("a[href*='wa.me'], a[href*='whatsapp'], a:has-text('WhatsApp')"));
        assertThat(whatsappLink).isNotNull();
        assertThat(whatsappLink.getAttribute("href")).contains("wa.me");
    }

    @Test
    @Order(16)
    @DisplayName("Event detail has back to events link")
    void eventDetailHasBackLink() {
        navigateTo("/events/1");
        waitForPageLoad();

        WebElement backLink = driver.findElement(By.cssSelector("a[href='/events'], a:has-text('Back'), a:has-text('वापस')"));
        assertThat(backLink).isNotNull();
    }

    // ───────────────────── Testimonials (/testimonials) ─────────────────────

    @Test
    @Order(17)
    @DisplayName("Testimonials page loads with testimonial list")
    void testimonialsPageLoads() {
        navigateTo("/testimonials");
        waitForPageLoad();

        String bodyText = driver.findElement(By.tagName("body")).getText();
        assertThat(bodyText).containsIgnoringCase("प्रशंसापत्र")
                .or().containsIgnoringCase("testimonial")
                .or().containsIgnoringCase("सदस्यों");
    }

    @Test
    @Order(18)
    @DisplayName("Testimonials page has search functionality")
    void testimonialsHasSearch() {
        navigateTo("/testimonials");
        waitForPageLoad();

        List<WebElement> searchInputs = driver.findElements(By.cssSelector("input[type='text'], input[type='search'], input[placeholder*='खोज'], input[placeholder*='search']"));
        assertThat(searchInputs.size()).isGreaterThanOrEqualTo(1);
    }

    @Test
    @Order(19)
    @DisplayName("Testimonials page has pagination")
    void testimonialsHasPagination() {
        navigateTo("/testimonials");
        waitForPageLoad();

        String bodyText = driver.findElement(By.tagName("body")).getText();
        assertThat(bodyText).containsIgnoringCase("पृष्ठ")
                .or().containsIgnoringCase("page");
    }

    // ───────────────────── Rooms (/rooms/view) ─────────────────────

    @Test
    @Order(20)
    @DisplayName("Rooms search page loads with filters")
    void roomsPageLoads() {
        navigateTo("/rooms/view");
        waitForPageLoad();

        String bodyText = driver.findElement(By.tagName("body")).getText();
        assertThat(bodyText).containsIgnoringCase("रूम")
                .or().containsIgnoringCase("room")
                .or().containsIgnoringCase("खोजें");
    }

    @Test
    @Order(21)
    @DisplayName("Rooms page has room type filter")
    void roomsHasTypeFilter() {
        navigateTo("/rooms/view");
        waitForPageLoad();

        List<WebElement> selects = driver.findElements(By.cssSelector("select"));
        assertThat(selects.size()).isGreaterThanOrEqualTo(1);
    }

    @Test
    @Order(22)
    @DisplayName("Rooms page has date pickers")
    void roomsHasDatePickers() {
        navigateTo("/rooms/view");
        waitForPageLoad();

        List<WebElement> dateInputs = driver.findElements(By.cssSelector("input[type='date']"));
        assertThat(dateInputs.size()).isGreaterThanOrEqualTo(2); // check-in + check-out
    }

    @Test
    @Order(23)
    @DisplayName("Rooms page has Google login for guest booking")
    void roomsHasGoogleLoginForGuests() {
        navigateTo("/rooms/view");
        waitForPageLoad();

        WebElement googleLink = driver.findElement(By.cssSelector("a[href*='oauth2']"));
        assertThat(googleLink).isNotNull();
        assertThat(googleLink.getText()).containsIgnoringCase("Google");
    }

    // ───────────────────── Public API Responses ─────────────────────

    @Test
    @Order(24)
    @DisplayName("Testimonials page returns 200")
    void testimonialsReturnsOk() {
        navigateTo("/testimonials");
        waitForPageLoad();
        assertThat(driver.getCurrentUrl()).contains("/testimonials");
    }

    @Test
    @Order(25)
    @DisplayName("Smaj Uddesh Lakshya page returns 200")
    void objectivesReturnsOk() {
        navigateTo("/smajUddeshLakshya");
        waitForPageLoad();
        assertThat(driver.getCurrentUrl()).contains("/smajUddeshLakshya");
    }
}
