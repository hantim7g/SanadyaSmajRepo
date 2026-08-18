# Sanadya Brahmin Smaj - E2E Tests

End-to-end browser automation tests using **Playwright**. Runs in a real browser so you can see every click, type, and page load on screen.

## Quick start

```bash
cd e2e-tests
npm install
npx playwright install chromium      # one-time, downloads Chrome
# Start your Spring Boot app first (mvn spring-boot:run or run from IDE) on http://localhost:8080

npm run test                          # run all tests, headed (browser visible)
npm run test:login                    # run only login flow
npm run test:members                  # run only member flow
npm run test:payments                 # run only payment flow
npm run test:ui                       # open Playwright UI mode
npm run test:report                   # open HTML report after a run
```

Config: edit `playwright.config.js` to change `baseURL` (defaults to `http://localhost:8080`) or `slowMo` (currently 300ms per action so you can follow along).

## Layout

- `tests/`         – spec files (*.spec.js), one per flow
- `pages/`         – Page Object Models (selectors + actions grouped per page)
- `utils/`         – shared helpers (auth, test data)
- `playwright.config.js`
- `package.json`

## Test data

`utils/test-data.js` holds credentials & sample inputs. Adjust to match your seed data / local DB.
