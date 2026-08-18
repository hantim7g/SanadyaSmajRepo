package com.hst.e2e;

import io.github.bonigarcia.wdm.WebDriverManager;
import org.junit.jupiter.api.*;
import org.openqa.selenium.*;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.edge.EdgeDriver;
import org.openqa.selenium.edge.EdgeOptions;
import org.openqa.selenium.support.ui.ExpectedCondition;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import java.time.Duration;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;

/**
 * Base class for all Selenium E2E tests.
 * Manages WebDriver lifecycle, provides common helper methods.
 *
 * Usage: System property "browser" controls which browser to use.
 *        Defaults to Chrome. Pass -Dbrowser=edge for Edge.
 *
 * The app is expected to be running at {@code http://localhost:8080}.
 */
@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public abstract class BaseE2ETest {

    protected static final String BASE_URL = "http://localhost:8080";
    protected static final int IMPLICIT_WAIT_SECONDS = 10;
    protected static final int PAGE_LOAD_TIMEOUT_SECONDS = 30;

    protected WebDriver driver;
    protected WebDriverWait wait;

    // ───────────────────── Lifecycle ─────────────────────

    @BeforeAll
    static void setupClass() {
        String browser = System.getProperty("browser", "chrome").toLowerCase();
        switch (browser) {
            case "edge" -> WebDriverManager.edgedriver().setup();
            default -> WebDriverManager.chromedriver().setup();
        }
    }

    @BeforeEach
    void setUp() {
        String browser = System.getProperty("browser", "chrome").toLowerCase();
        driver = createDriver(browser);
        driver.manage().timeouts().pageLoadTimeout(Duration.ofSeconds(PAGE_LOAD_TIMEOUT_SECONDS));
        driver.manage().timeouts().implicitlyWait(Duration.ofSeconds(IMPLICIT_WAIT_SECONDS));
        wait = new WebDriverWait(driver, Duration.ofSeconds(10));
    }

    @AfterEach
    void tearDown() {
        if (driver != null) {
            driver.quit();
        }
    }

    private WebDriver createDriver(String browser) {
        switch (browser) {
            case "edge": {
                EdgeOptions options = new EdgeOptions();
                options.addArguments("--headless=new", "--disable-gpu", "--no-sandbox",
                        "--window-size=1920,1080", "--disable-dev-shm-usage");
                return new EdgeDriver(options);
            }
            default: { // chrome
                ChromeOptions options = new ChromeOptions();
                options.addArguments("--headless=new", "--disable-gpu", "--no-sandbox",
                        "--window-size=1920,1080", "--disable-dev-shm-usage",
                        "--disable-search-engine-choice-screen");
                return new ChromeDriver(options);
            }
        }
    }

    // ───────────────────── Navigation Helpers ─────────────────────

    protected void navigateTo(String path) {
        driver.get(BASE_URL + path);
    }

    protected String currentPath() {
        return new java.net.URL(driver.getCurrentUrl()).getPath();
    }

    // ───────────────────── Wait Helpers ─────────────────────

    protected WebElement waitForVisible(By locator) {
        return wait.until(ExpectedConditions.visibilityOfElementLocated(locator));
    }

    protected WebElement waitForClickable(By locator) {
        return wait.until(ExpectedConditions.elementToBeClickable(locator));
    }

    protected boolean waitForUrlContains(String text) {
        return wait.until(ExpectedConditions.urlContains(text));
    }

    protected void waitForPageLoad() {
        wait.until((ExpectedCondition<Boolean>) wd ->
                ((JavascriptExecutor) wd).executeScript("return document.readyState").equals("complete"));
    }

    protected List<WebElement> waitForAllVisible(By locator) {
        return wait.until(ExpectedConditions.visibilityOfAllElementsLocatedBy(locator));
    }

    // ───────────────────── Common Assertions ─────────────────────

    protected void assertPageTitleContains(String expected) {
        assertThat(driver.getTitle()).containsIgnoringCase(expected);
    }

    protected void assertCurrentPathIs(String expectedPath) {
        assertThat(currentPath()).isEqualTo(expectedPath);
    }

    protected void assertAlertVisible(String expectedText) {
        By alertLocator = By.cssSelector(".alert, [role='alert']");
        WebElement alert = waitForVisible(alertLocator);
        assertThat(alert.getText()).contains(expectedText);
    }

    // ───────────────────── JavaScript Helpers ─────────────────────

    protected void scrollToBottom() {
        ((JavascriptExecutor) driver).executeScript("window.scrollTo(0, document.body.scrollHeight);");
    }

    protected void scrollToElement(WebElement element) {
        ((JavascriptExecutor) driver).executeScript("arguments[0].scrollIntoView({behavior: 'smooth', block: 'center'});", element);
    }

    protected long countElements(By locator) {
        return driver.findElements(locator).size();
    }
}
