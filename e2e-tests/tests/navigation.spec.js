/**
 * Smoke test: every known page returns 2xx and renders without crashing.
 * Adjust the URL list after inspecting the agent's route map.
 *
 * Run: npx playwright test tests/navigation.spec.js --headed
 */
const { test, expect } = require('@playwright/test');
const { login } = require('../utils/auth');
const testData = require('../utils/test-data');

// TODO: replace with real paths from route map
const PUBLIC_PAGES = ['/', '/login', '/register', '/about'];
const AUTH_PAGES = ['/home', '/dashboard', '/members', '/payments', '/profile'];

test.describe('Navigation smoke', () => {
  for (const path of PUBLIC_PAGES) {
    test(`public page loads: ${path}`, async ({ page }) => {
      const resp = await page.goto(path);
      expect(resp, `no response for ${path}`).not.toBeNull();
      expect(resp.status(), `${path} returned ${resp.status()}`).toBeLessThan(500);
      console.log(`✅ ${path} → ${resp.status()}`);
    });
  }

  for (const path of AUTH_PAGES) {
    test(`auth page loads: ${path}`, async ({ page }) => {
      await login(page, testData.users.admin);
      const resp = await page.goto(path);
      expect(resp, `no response for ${path}`).not.toBeNull();
      expect(resp.status(), `${path} returned ${resp.status()}`).toBeLessThan(500);
      console.log(`✅ ${path} → ${resp.status()}`);
    });
  }
});
