import 'package:demo_project/app/core/theme/app_colors.dart';
import 'package:demo_project/app/core/widget/custom_button.dart';
import 'package:demo_project/app/core/widget/custom_text_field.dart';
import 'package:demo_project/app/features/signup/controller/signup_controller.dart';
import 'package:demo_project/app/routes/app_routes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupPage extends GetView<SignupController> {
  const SignupPage({super.key});

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
              child: Icon(Icons.arrow_back, size: 20, color: AppColors.textPrimary),
             ),
             

              SizedBox(height: 18),

              Expanded(
                child: SingleChildScrollView(
                  child: Container(
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
                            "Create Account",
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
                            "Start your loan application journey",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF6B7280),
                            ),
                          ),
                        ),

                        SizedBox(height: 36),
                        _headingText("Full Name"),
                        SizedBox(height: 8),
                        CustomTextField(hintText: "Enter your full name"),
                        SizedBox(height: 24),
                        _headingText("Email Address"),
                        SizedBox(height: 8),

                        CustomTextField(hintText: "Enter your email address"),
                        SizedBox(height: 24),
                        _headingText("Phone Number"),
                        SizedBox(height: 8),
                        CustomTextField(
                          keyboardType: TextInputType.phone,
                          hintText: "Enter your phone number",
                        ),
                        SizedBox(height: 24),
                        _headingText("Password"),
                        SizedBox(height: 8),
                        CustomTextField(
                          isPassword: true,
                          hintText: "Enter your password",
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Must be at least 8 characters with numbers and symbols",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                        SizedBox(height: 24),
                        Obx(
                          () => Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 18,
                                height: 18,
                                child: Checkbox(
                                  value: controller.isAgreementAccepted.value,
                                  onChanged: controller.toggleAgreement,
                                  side: BorderSide.none,
                                  fillColor: WidgetStateProperty.resolveWith((
                                    states,
                                  ) {
                                    if (states.contains(WidgetState.selected)) {
                                      return AppColors.error;
                                    }

                                    return Color(0xFFD9D9D9);
                                  }),
                                  checkColor: Colors.white,
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  visualDensity: VisualDensity.compact,
                                ),
                              ),
                              SizedBox(width: 8),
                              Expanded(child: _agreementText()),
                            ],
                          ),
                        ),
                        SizedBox(height: 24),
                        CustomButton(
                          onTap: () {
                            Get.toNamed(AppRoutes.emailVerification);
                          },
                          text: "Create Account",
                        ),
                        SizedBox(height: 24),
                        _orDivider(),
                        SizedBox(height: 16),
                        Center(child: _signInText()),
                      ],
                    ),
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

  Widget _agreementText() {
    const linkStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.error,
      decoration: TextDecoration.underline,
      decorationColor: AppColors.error,
    );

    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: Color(0xFF6B7280),
          height: 1.35,
        ),
        children: [
          TextSpan(text: "I agree to the "),
          TextSpan(
            text: "Terms of Business - Dragon Finance",
            style: linkStyle,
          ),
          TextSpan(text: "\nand "),
          TextSpan(text: "Privacy Policy - Dragon Finance", style: linkStyle),
        ],
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



  Widget _signInText() {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Color(0xFF6B7280),
        ),
        children: [
          TextSpan(text: "Already have an account? "),
          TextSpan(
            text: "Sign In",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.error,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Get.toNamed(AppRoutes.login);
              },
          ),
        ],
      ),
    );
  }
}
