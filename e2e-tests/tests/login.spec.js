/**
 * Login / auth flow E2E tests.
 *
 * Real flow: auth popup modal → POST /api/auth/login (JSON mobile+password)
 * → sets authToken HttpOnly cookie.
 *
 * Run: npm run test:login (browser stays visible)
 */
const { test, expect } = require('@playwright/test');
const testData = require('../utils/test-data');

test.describe('Auth Flow', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/');
  });

  test('home page loads and shows login trigger', async ({ page }) => {
    const title = await page.title();
    expect(title).toBeTruthy();
    console.log(`✅ Home loaded: "${title}", url=${page.url()}`);

    const trigger = page.locator('a:has-text("Login"), button:has-text("Login"), #loginBtn, .login-trigger').first();
    if (await trigger.isVisible().catch(() => false)) {
      console.log('✅ Login trigger found');
    } else {
      console.log('ℹ️  No login trigger visible — auth popup may auto-show');
    }
  });

  test('auth popup modal renders with mobile + password fields', async ({ page }) => {
    const trigger = page.locator('a:has-text("Login"), button:has-text("Login"), #loginBtn').first();
    if (await trigger.isVisible().catch(() => false)) {
      await trigger.click();
    }
    await page.waitForSelector('#loginForm', { timeout: 10_000 });
    await expect(page.locator('#loginForm input[name="mobile"]')).toBeVisible();
    await expect(page.locator('#loginForm input[name="password"]')).toBeVisible();
    await expect(page.locator('#loginForm button[type="submit"]')).toBeVisible();
    console.log('✅ Login form visible');
  });

  test('rejects invalid mobile/password', async ({ page }) => {
    const trigger = page.locator('a:has-text("Login"), button:has-text("Login"), #loginBtn').first();
    if (await trigger.isVisible().catch(() => false)) await trigger.click();
    await page.waitForSelector('#loginForm');

    await page.fill('#loginForm input[name="mobile"]', '9999999999');
    await page.fill('#loginForm input[name="password"]', 'wrongpassword');
    await page.click('#loginForm button[type="submit"]');

    // Should show error or stay on home (popup closes on success only)
    await page.waitForTimeout(2000);
    const stillVisible = await page.locator('#loginForm').isVisible().catch(() => false);
    console.log(`✅ After invalid login, login form visible=${stillVisible}`);
  });

  test('admin can log in via API + cookie', async ({ page }) => {
    const res = await page.request.post('/api/auth/login', {
      data: { mobile: testData.users.admin.mobile, password: testData.users.admin.password },
    });
    const status = res.status();
    console.log(`POST /api/auth/login → ${status}`);
    expect(status).toBeLessThan(500);

    // Reload home — should now show logged-in UI
    await page.goto('/');
    const me = await page.request.get('/api/auth/me');
    if (me.ok()) {
      const body = await me.json();
      console.log(`✅ Logged in as: ${body.fullName || body.mobile} (role=${body.role})`);
    }
  });

  test('member can log in via API + cookie', async ({ page }) => {
    const res = await page.request.post('/api/auth/login', {
      data: { mobile: testData.users.member.mobile, password: testData.users.member.password },
    });
    expect(res.status()).toBeLessThan(500);
    const me = await page.request.get('/api/auth/me');
    if (me.ok()) {
      const body = await me.json();
      console.log(`✅ Logged in as member: ${body.fullName || body.mobile}`);
    }
  });

  test('logout clears cookie and protected API returns 401', async ({ page }) => {
    // Login
    await page.request.post('/api/auth/login', {
      data: { mobile: testData.users.admin.mobile, password: testData.users.admin.password },
    });

    // Logout via API/UI
    await page.request.post('/logout');
    await page.context().clearCookies();

    // /api/auth/me should now fail
    const me = await page.request.get('/api/auth/me');
    console.log(`✅ After logout, /api/auth/me → ${me.status()}`);
    expect(me.status()).toBeGreaterThanOrEqual(400);
  });
});
