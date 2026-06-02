import 'package:demo_project/app/core/theme/app_colors.dart';
import 'package:demo_project/app/core/widget/custom_button.dart';
import 'package:demo_project/app/core/widget/custom_text_field.dart';
import 'package:demo_project/app/features/login/controller/login_controller.dart';
import 'package:demo_project/app/routes/app_routes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.arrow_back,
                  size: 20,
                  color: AppColors.textPrimary,
                ),
              ),

              SizedBox(height: 130),
              SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "Welcome Back",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF292F36),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Center(
                        child: Text(
                          "Sign in to continue your application",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textHint,
                          ),
                        ),
                      ),

                      SizedBox(height: 28),
                      _headingText("Email Address"),
                      SizedBox(height: 8),
                      CustomTextField(hintText: "Enter your email address"),

                      SizedBox(height: 20),
                      _headingText("Password"),
                      SizedBox(height: 8),
                      CustomTextField(
                        isPassword: true,
                        hintText: "Enter your password",
                      ),
                      SizedBox(height: 16),
                      _rememberMe(),
                      SizedBox(height: 20),
                      CustomButton(onTap: () {
                        Get.toNamed(AppRoutes.mainPage);
                      }, text: "Sign In"),
                      SizedBox(height: 37),
                      _orDivider(),
                      SizedBox(height: 26),
                      Center(child: _signInText()),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headingText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Color(0xFF292F36),
      ),
    );
  }

  Widget _orDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: Color(0xFFE5E7EB), thickness: 1)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "or",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xFF6B7280),
            ),
          ),
        ),
        Expanded(child: Divider(color: Color(0xFFE5E7EB), thickness: 1)),
      ],
    );
  }

  Widget _rememberMe() {
    return Obx(
      () => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              controller.toggleRememberMe(!controller.isRememberMe.value);
            },
            child: SizedBox(
              width: 16,
              height: 16,
              child: Checkbox(
                value: controller.isRememberMe.value,
                onChanged: controller.toggleRememberMe,
                side: BorderSide.none,
                fillColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return AppColors.error;
                  }

                  return Color(0xFFD9D9D9);
                }),
                checkColor: Colors.white,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
              ),
            ),
          ),

          SizedBox(width: 6),
          Text(
            "Remember me",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.textHint,
            ),
          ),

          Spacer(),
         InkWell(
          onTap: () {
            Get.toNamed(AppRoutes.forget);
          },
         child: Text(
            "Forgot Password?",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.error,
            ),
          ),
         )
        ],
      ),
    );
  }

  Widget _signInText() {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Color(0xFF6B7280),
        ),
        children: [
          TextSpan(text: "Don't have an account? "),
          TextSpan(
            text: "Sign Up",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.error,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Get.toNamed(AppRoutes.signup);
              },
          ),
        ],
      ),
    );
  }
}
