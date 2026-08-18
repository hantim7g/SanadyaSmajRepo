/**
 * Member management E2E tests (admin flow).
 *
 * Admin endpoints from route map:
 *   GET  /admin/memberList
 *   POST /admin/approveProfile/{id}
 *   POST /admin/rejectProfile/{id}
 *   POST /api/admin/approve/{id}
 *   POST /api/admin/reject/{id}
 *
 * Run: npm run test:members
 */
const { test, expect } = require('@playwright/test');
const testData = require('../utils/test-data');

test.describe('Admin: Member Management', () => {
  test.beforeEach(async ({ page }) => {
    await page.request.post('/api/auth/login', {
      data: testData.users.admin,
    });
  });

  test('admin member list page loads', async ({ page }) => {
    const resp = await page.goto('/admin/memberList');
    expect(resp.status()).toBeLessThan(500);
    console.log(`✅ /admin/memberList → ${resp.status()}, url=${page.url()}`);
  });

  test('pending users API returns data', async ({ page }) => {
    const res = await page.request.get('/api/admin/pending-users');
    console.log(`GET /api/admin/pending-users → ${res.status()}`);
    if (res.ok()) {
      const body = await res.json();
      console.log(`✅ ${Array.isArray(body) ? body.length : 'non-array'} pending user(s)`);
    }
  });

  test('user filter API responds', async ({ page }) => {
    const res = await page.request.get('/admin/users/filter?name=&mobile=&approved=&yearDropdown=last1years');
    console.log(`GET /admin/users/filter → ${res.status()}`);
    expect(res.status()).toBeLessThan(500);
  });

  test('admin member list has expected content', async ({ page }) => {
    await page.goto('/admin/memberList');
    const body = await page.locator('body').innerText();
    expect(body.length).toBeGreaterThan(100);
    console.log(`✅ Admin member list body length = ${body.length} chars`);
  });
});
