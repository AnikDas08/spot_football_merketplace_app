class ApiEndPoint {
  static const baseUrl = 'http://10.10.7.55:5005/api/v1';
  static const imageUrl = 'http://103.145.138.74:3000';
  static const socketUrl = 'http://103.145.138.74:3001';

  static const signUp = '/user/';
  static const playerProfile = '/user/player';
  static const verifyEmail = '/auth/verify-email';
  static const signIn = '/auth/login';
  static const profile = '/user/profile';
  static const forgotPassword = '/auth/forgot-password';
  static const verifyOtp = '/auth/verify-email';
  static const resetPassword = '/auth/reset-password';
  static const resendOtp = '/auth/resend-otp';
  static const changePassword = 'users/change-password';
  static const user = 'users';
  static const notifications = 'notifications';
  static const privacyPolicies = 'privacy-policies';
  static const termsOfServices = 'terms-and-conditions';
  static const chats = 'chats';
  static const messages = 'messages';
}
