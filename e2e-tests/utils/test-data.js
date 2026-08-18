/**
 * Test data for E2E tests.
 * Real app uses mobile + password (JWT cookie auth), not username.
 */
module.exports = {
  baseUrl: process.env.BASE_URL || 'http://localhost:8080',

  users: {
    // Bootstrap admin (one-shot /api/auth/makeAdmin makes mobile 8089101719 ADMIN)
    admin: {
      mobile: process.env.ADMIN_MOBILE || '8089101719',
      password: process.env.ADMIN_PASS || 'admin123',
    },
    member: {
      mobile: process.env.MEMBER_MOBILE || '9876543210',
      password: process.env.MEMBER_PASS || 'user123',
    },
  },

  newMember: {
    mobile: '9000000001',
    password: 'Test@1234',
    fullName: 'Test User',
    fatherName: 'Test Father',
    gotra: 'Kashyap',
    dateOfBirth: '1990-01-01',
    gender: 'Male',
    address: '123 Test Street',
    city: 'Test City',
    homeDistrict: 'Test District',
    email: 'test.user@example.com',
    education: 'Graduate',
    occupation: 'Engineer',
    aadharNumber: '123412341234',
    bloodGroup: 'O+',
    maritalStatus: 'Unmarried',
  },

  payment: {
    amount: '500',
    description: 'Test annual fee',
    paymentMode: 'ONLINE',
  },
};
