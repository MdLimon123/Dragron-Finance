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
  static const String logout = '/auth/logout/';

  static const String customerLoadType = "/customer/loan-types/";
  
 static String updateLoanApplication(String id) => "/customer/loan-applications/$id/";

 static const  String  profile = "/auth/me/";
 static const String uploadKycDocs ="/kyc/upload-id/";

 static const String uploadSelfie = "/kyc/upload-selfie/";
 static const String getKycStatus = "/kyc/me/";
 static const String submitKyc = "/kyc/submit/";
 static const String updateProfile = "/auth/me/";

 static const String getMyLoanEndPoint = "/customer/my-loans/";
 static const String notification = '/notifications/';

 static const String referralDashboard = "/referrals/dashboard/";
 static const String getBookApiEndPoint = "/support/book-call/";
 static const String submitBookingEndPoint = "/support/book-call/";

 static const String createRoomIdEndPoint = "/chat/conversations/";

 static  String getOldAllMessage(String id ) => "/chat/conversations/$id/messages/";
 static const String createLoanEndPoint = "/customer/loan-applications/";
 static  String updateLoanApplicationStep2(String id )=> "/customer/loan-applications/$id/";
 static String updateLoanAppllicationSetp3(String id) => "/customer/loan-applications/$id/";
 static String updateLoanApplicationSetp4(String id) => "/customer/loan-applications/$id/";
 static String updateLoanApplicationSetp5(String id) => "/customer/loan-applications/$id/";
 static String submitedApplicationEndPoint(String id) => "/customer/loan-applications/$id/submit/";
 static String updateLoanApplicationStep6(String id) =>"/customer/loan-applications/$id/documents/";
 static String submitDocument(String id ) => "/customer/loan-applications/$id/documents/upload/";
 static String completeDocument(String id) => "/customer/loan-applications/$id/documents/complete/";

 static const String allGetMyLoanEndPoint = "/customer/my-loans/";

 static  String previewGetAgreement(String id) => "/agreements/$id/";

 static String submitSignutare(String id) => "/agreements/$id/sign/";



  // Products
  static const String products = '/products/';
  static String userById(int id) => '/users/$id';
}
