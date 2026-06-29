class ApiEndpoints {
  ApiEndpoints._();

  // Auth
  static const String login = '/auth/login/';
  static const String signup = '/auth/signup/';
  static const String emailVerify = "/auth/verify-email/";
  static const String resendEmailVerify = "/auth/resend-signup-otp/";
  static const String forgetPassword = "/auth/forgot-password/";
  static const String otpVerify = "/auth/verify-reset-otp/";
  static const String resentForgetOtp = "/auth/resend-forgot-password-otp/";
  static const String changePassword = "/auth/reset-password/";
  static const String logout = '/auth/logout';

  static const String customerLoadType = "/customer/loan-types/";
  
 static String updateLoanApplication(String id) => "/customer/loan-applications/$id/";

 static const  String  profile = "/auth/me/";
 static const String uploadKycDocs ="/kyc/upload-id/";

 static const String uploadSelfie = "/kyc/upload-selfie/";
 static const String getKycStatus = "/kyc/me/";
 static const String submitKyc = "/kyc/submit/";
 static const String updateProfile = "/auth/me/";

  // Products
  static const String products = '/products/';
  static String userById(int id) => '/users/$id';
}
