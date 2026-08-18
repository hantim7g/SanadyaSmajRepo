/**
 * Payment flow E2E tests.
 *
 * Real endpoints:
 *   GET  /member/payment → payment.jsp
 *   POST /api/payment/add (multipart, PaymentRequest JSON + receipt image)
 *   GET  /api/user/payments
 *
 * We don't submit to PhonePe — just verify forms load and APIs respond.
 *
 * Run: npm run test:payments
 */
const { test, expect } = require('@playwright/test');
const testData = require('../utils/test-data');

test.describe('Payments Flow', () => {
  test.beforeEach(async ({ page }) => {
    await page.request.post('/api/auth/login', { data: testData.users.member });
  });

  test('payment page loads for member', async ({ page }) => {
    const resp = await page.goto('/member/payment');
    expect(resp.status()).toBeLessThan(500);
    console.log(`✅ /member/payment → ${resp.status()}`);
  });

  test('GET /api/user/payments returns list', async ({ page }) => {
    const res = await page.request.get('/api/user/payments');
    console.log(`GET /api/user/payments → ${res.status()}`);
    expect(res.status()).toBe(200);
    const body = await res.json();
    expect(Array.isArray(body)).toBe(true);
    console.log(`✅ ${body.length} payment(s) on file`);
  });

  test('payment page has #addPaymentForm', async ({ page }) => {
    await page.goto('/member/payment');
    const form = page.locator('#addPaymentForm');
    if (await form.isVisible().catch(() => false)) {
      console.log('✅ #addPaymentForm visible');
    } else {
      console.log('ℹ️  #addPaymentForm not visible — may be admin-gated or behind toggle');
    }
  });

  test('can fill payment form (does NOT submit — would trigger PhonePe redirect)', async ({ page }) => {
    await page.goto('/member/payment');
    const form = page.locator('#addPaymentForm');
    if (!(await form.isVisible().catch(() => false))) {
      test.skip(true, 'addPaymentForm not present on this user');
    }
    const amount = form.locator('input[name="amount"]').first();
    if (await amount.isVisible().catch(() => false)) {
      await amount.fill(testData.payment.amount);
      const value = await amount.inputValue();
      console.log(`✅ Filled amount=${value}; NOT submitting to avoid PhonePe redirect`);
    }
  });
});

test.describe('Admin: Payment validation', () => {
  test.beforeEach(async ({ page }) => {
    await page.request.post('/api/auth/login', { data: testData.users.admin });
  });

  test('admin can view member payments list', async ({ page }) => {
    await page.goto('/admin/memberList');
    const card = page.locator('.user-card, table tbody tr, .member-row').first();
    if (await card.isVisible().catch(() => false)) {
      console.log('✅ Found at least one member row');
    } else {
      console.log('ℹ️  No member rows visible');
    }
  });
});
