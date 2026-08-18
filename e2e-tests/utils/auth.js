/**
 * Auth helpers — JWT cookie auth via the auth popup modal.
 * Auth is handled by src/main/webapp/js/auth.js which posts to /api/auth/login.
 */
const { test: base, expect } = require('@playwright/test');
const testData = require('./test-data');

/**
 * Log in via the auth popup modal (the modal lives in includes/auth-popup.jsp).
 * Form fields: input[name="mobile"], input[name="password"] in #loginForm.
 */
async function login(page, user) {
  // Open the auth popup — try header link/button first, fall back to direct
  const trigger = page.locator('a:has-text("Login"), button:has-text("Login"), #loginBtn, .login-trigger').first();
  if (await trigger.isVisible().catch(() => false)) {
    await trigger.click();
  } else {
    await page.goto('/login');
  }

  // Wait for the login form in the popup
  await page.waitForSelector('#loginForm', { timeout: 10_000 });
  await page.fill('#loginForm input[name="mobile"]', user.mobile);
  await page.fill('#loginForm input[name="password"]', user.password);
  await page.click('#loginForm button[type="submit"]');

  // Wait for popup to close or page navigation
  await page.waitForLoadState('networkidle', { timeout: 15_000 });
}

/**
 * Logout — clears authToken cookie via POST /logout.
 */
async function logout(page) {
  await page.context().clearCookies();
  await page.goto('/');
}

/**
 * Test fixtures: pre-authenticated page objects.
 */
const test = base.extend({
  adminPage: async ({ page }, use) => {
    await login(page, testData.users.admin);
    await use(page);
  },
  memberPage: async ({ page }, use) => {
    await login(page, testData.users.member);
    await use(page);
  },
});

module.exports = { test, expect, login, logout };
