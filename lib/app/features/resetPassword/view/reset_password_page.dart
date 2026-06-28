import 'package:demo_project/app/core/theme/app_colors.dart';
import 'package:demo_project/app/core/widget/custom_button.dart';
import 'package:demo_project/app/core/widget/custom_text_field.dart';
import 'package:demo_project/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/reset_password_controller.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final controller = Get.put(ResetPasswordController());

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

              Expanded(
                child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 194),
                    Center(
                      child: Text(
                        "Reset Password",
                        style: TextStyle(
                          fontSize: 32,
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
                        horizontal: 25,
                        vertical: 25,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Color(0xFFD1D5DC), width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.10),
                            blurRadius: 2,
                            spreadRadius: -1,
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
                          Text(
                            "New Password",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF292F36),
                            ),
                          ),
                          SizedBox(height: 8),
                          CustomTextField(
                            controller: controller.newPasswordController,
                            isPassword: true,
                            hintText: "Enter your new password",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "New password is required";
                              }
                              if (value.length < 8) {
                                return "Password must be at least 8 characters long";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16),
                          Text(
                            "Confirm Password",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF292F36),
                            ),
                          ),
                          SizedBox(height: 8), 
                          CustomTextField(
                            controller: controller.confirmPasswordController,
                            isPassword: true,
                            hintText: "Enter your confirm password",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Confirm password is required";
                              }
                              if (value != controller.newPasswordController.text) {
                                return "Passwords do not match";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 24),
                          Obx(
                            () => CustomButton(
                              isLoading: controller.isLoading.value,
                              onTap: () {
                                if (controller.formKey.currentState!.validate()) {
                                  controller.resetPassword();
                                }
                              },
                              text: "Reset Password",
                            ),
                          ),
                        ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          )],
          ),
        ),
      ),
    );
  }
}
