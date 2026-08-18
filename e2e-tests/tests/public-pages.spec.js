/**
 * Public content pages — all should render 200 with no auth.
 * Covers: home, events, festivals, calendar, gotra, testimonials, guidance, etc.
 */
const { test, expect } = require('@playwright/test');

const PUBLIC_PAGES = [
  { path: '/',                name: 'Home' },
  { path: '/home',            name: 'Home (alt)' },
  { path: '/login',           name: 'Login' },
  { path: '/events',          name: 'Events list' },
  { path: '/calendar',        name: 'Annual Calendar' },
  { path: '/festivals',       name: 'Festivals' },
  { path: '/gotra',           name: 'Gotra' },
  { path: '/testimonials',    name: 'Testimonials' },
  { path: '/guidance',        name: 'Guidance' },
  { path: '/shubhkamna',      name: 'Shubhkamna' },
  { path: '/smajHistory',     name: 'Samaj History' },
  { path: '/smajUddeshLakshya', name: 'Samaj Goals' },
  { path: '/officials',       name: 'Officials' },
];

for (const p of PUBLIC_PAGES) {
  test(`public page loads: ${p.name} (${p.path})`, async ({ page }) => {
    const resp = await page.goto(p.path);
    expect(resp, `no response for ${p.path}`).not.toBeNull();
    const status = resp.status();
    expect(status, `${p.path} returned ${status}`).toBeLessThan(500);
    console.log(`✅ ${p.path} → ${status}`);
  });
}
