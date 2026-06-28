import 'package:demo_project/app/features/Co-Applicant/binding/co-applicant_binding.dart';
import 'package:demo_project/app/features/Co-Applicant/view/co_application_page.dart';
import 'package:demo_project/app/features/KYC-Verify/binding/kyc_binding.dart';
import 'package:demo_project/app/features/KYC-Verify/view/identity_verification.dart';
import 'package:demo_project/app/features/appMain/binding/main_binding.dart';
import 'package:demo_project/app/features/appMain/view/app_main_page.dart';
import 'package:demo_project/app/features/book-a-call/binding/book_call_binding.dart';
import 'package:demo_project/app/features/book-a-call/view/book_call_page.dart';
import 'package:demo_project/app/features/e-sign-agreement/binding/esign_binding.dart';
import 'package:demo_project/app/features/e-sign-agreement/view/e_sign_agreement_page.dart';
import 'package:demo_project/app/features/emailVerification/binding/email_verification_binding.dart';
import 'package:demo_project/app/features/emailVerification/view/email_verification_page.dart';
import 'package:demo_project/app/features/forget/binding/forget_binding.dart';
import 'package:demo_project/app/features/forget/view/forget_page.dart';
import 'package:demo_project/app/features/onboarding/view/welcome_page.dart';
import 'package:demo_project/app/features/otpVerify/binding/otp_verify_binding.dart';
import 'package:demo_project/app/features/otpVerify/view/otp_verify_page.dart';
import 'package:demo_project/app/features/resetPassword/binding/reset_password_binding.dart';
import 'package:demo_project/app/features/resetPassword/view/reset_password_page.dart';
import 'package:demo_project/app/features/signup/binding/signup_binding.dart';
import 'package:demo_project/app/features/signup/view/signup_page.dart';
import 'package:demo_project/app/features/splash/binding/splash_binding.dart';
import 'package:demo_project/app/features/splash/view/splash_page.dart';
import 'package:get/get.dart';

import 'package:demo_project/app/features/login/binding/login_binding.dart';
import 'package:demo_project/app/features/login/view/login_page.dart';
import 'package:demo_project/app/features/onboarding/binding/onboarding_binding.dart';
import 'package:demo_project/app/features/onboarding/view/onboarding_page.dart';

import 'package:demo_project/app/routes/app_routes.dart';
import 'package:demo_project/app/features/liveChat/binding/live_chat_binding.dart';
import 'package:demo_project/app/features/liveChat/view/live_chat_page.dart';
import 'package:demo_project/app/features/refer/binding/refer_binding.dart';
import 'package:demo_project/app/features/refer/view/refer_friend_page.dart'; 

class AppPages {
  AppPages._();

  static const initial = AppRoutes.splash;

  static final pages = <GetPage>[
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingPage(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: AppRoutes.welcome,
      page: () => const WelcomePage(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: AppRoutes.emailVerification,
      page: () => EmailVerificationPage(
        email: Get.arguments?['email'] ?? '',
      ),
      binding: EmailVerificationBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.signup,
      page: () => const SignupPage(),
      binding: SignupBinding(),
    ),

    GetPage(
      name: AppRoutes.forget,
      page: () => const ForgetPage(),
      binding: ForgetBinding(),
    ),
    GetPage(
      name: AppRoutes.otpVerify,
      page: () =>  OtpVerifyPage(
        email: Get.arguments?['email'] ?? '',
      ),
      binding: OtpVerifyBinding(),
    ),
    GetPage(
      name: AppRoutes.resetPassword,
      page: () => const ResetPasswordPage(),
      binding: ResetPasswordBinding(),
    ),

    GetPage(
      name: AppRoutes.mainPage,
      page: () => const AppMainPage(),
      binding: MainBinding(),
    ),
       GetPage(
      name: AppRoutes.kycVerify,
      page: () => const IdentityVerification(),
      binding: KycBinding(),
    ),
       GetPage(
      name: AppRoutes.eSignAgreement,
      page: () => const ESignAgreementPage(),
      binding: EsignBinding(),
    ),
       GetPage(
      name: AppRoutes.coApplication,
      page: () => const CoApplicationPage(),
      binding: CoApplicantBinding(),
    ),
        GetPage(
      name: AppRoutes.bookCall,
      page: () => const BookCallPage(),
      binding: BookCallBinding(),
    ),

        GetPage(
      name: AppRoutes.liveChat,
      page: () => const LiveChatPage(),
      binding: LiveChatBinding(),
    ),

        GetPage(
      name: AppRoutes.referFriend,
      page: () => const ReferFriendPage(),
      binding: ReferBinding(),
    ),  
  ];
}
