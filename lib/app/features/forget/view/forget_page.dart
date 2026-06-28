import 'package:demo_project/app/core/theme/app_colors.dart';
import 'package:demo_project/app/core/widget/custom_button.dart';
import 'package:demo_project/app/core/widget/custom_text_field.dart';
import 'package:demo_project/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../controller/forget_controller.dart';

class ForgetPage extends StatefulWidget {

  const ForgetPage({super.key,});

  @override
  State<ForgetPage> createState() => _ForgetPageState();
}

class _ForgetPageState extends State<ForgetPage> {
  final controller = Get.put(ForgetController());

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

              SizedBox(height: 194),

              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "Forgot Password",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF101828),
                        ),
                      ),
                    ),

                    SizedBox(height: 20),
                    Center(
                      child: Text(
                        "Enter your email address and we'll send you a link to reset your password",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF4A5565),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 21),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Color(0xFFE5E7EB), width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF000000).withValues(alpha: 0.10),
                            blurRadius: 3,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Form(
                        key: controller.formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _headingText("Email Address"),
                          SizedBox(height: 8),
                          CustomTextField(
                            controller: controller.emailController,
                            prefixIcon: SvgPicture.asset(
                              'assets/icon/email.svg',
                            ),
                            hintText: "Enter your email address",
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Email address is required";
                              }
                              if (!GetUtils.isEmail(value.trim())) {
                                return "Enter a valid email address";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 15),

                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFFF9FAFB),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "We'll send a reset OTP to this email address if it exists in our system.",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF4A5565),
                              ),
                            ),
                          ),

                          SizedBox(height: 15),
                          Obx(
                            () => CustomButton(
                              isLoading: controller.isLoading.value,
                              onTap: () {
                                if (controller.formKey.currentState!.validate()) {
                                  controller.sendResetOtp();
                                }
                              },
                              text: "Send Reset OTP",
                            ),
                          ),
                        ],
                        ),
                      ),
                    ),
                    SizedBox(height: 29),

                    Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,

                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Color(0xFFD1D5DC), width: 1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_back,
                            size: 20,
                            color: Color(0xFF364153),
                          ),
                          SizedBox(width: 7,),
                          Text(
                            "Back to Sign In",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF364153),
                            ),
                          ),
                        ],
                      ),
                    ),

               
                 
                  ],
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
        fontWeight: FontWeight.w400,
        color: Color(0xFF364153),
      ),
    );
  }
}
