/**
 * Page Object: Login page
 */
class LoginPage {
  constructor(page) {
    this.page = page;
    this.usernameInput = page.locator('input[name="username"]');
    this.passwordInput = page.locator('input[name="password"]');
    this.submitButton = page.locator('button[type="submit"], input[type="submit"]');
    this.errorMessage = page.locator('.error, .alert-danger, .login-error, [role="alert"]');
  }

  async goto() {
    await this.page.goto('/login');
  }

  async login(username, password) {
    await this.goto();
    await this.usernameInput.fill(username);
    await this.passwordInput.fill(password);
    await this.submitButton.click();
  }
}

module.exports = LoginPage;
