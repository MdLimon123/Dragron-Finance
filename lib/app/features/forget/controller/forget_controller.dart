import 'package:demo_project/app/core/network/api_endpoints.dart';
import 'package:demo_project/app/core/network/base_api_service.dart';
import 'package:demo_project/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  final isLoading = false.obs;
  final BaseApiService _baseApiService = BaseApiService();

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  Future<void> sendResetOtp() async {
    isLoading(true);

    final email = emailController.text.trim();
    final body = {
      "email_address": email
    };

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    try {
      print("===== FORGET PASSWORD REQUEST =====");
      print("URL: ${ApiEndpoints.forgetPassword}");
      print("Body: $body");
      print("===================================");

      final response = await _baseApiService.post(
        ApiEndpoints.forgetPassword,
        body: body,
        extraHeaders: headers,
      );

      print("===== FORGET PASSWORD RESPONSE =====");
      print(response);
      print("====================================");

      Get.snackbar(
        "Success",
        response['message'] ?? "OTP sent successfully to $email",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      Get.toNamed(
        AppRoutes.otpVerify,
        arguments: {'email': email},
      );
    } catch (e) {
      print("===== FORGET PASSWORD ERROR =====");
      print(e.toString());
      print("=================================");
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading(false);
    }
  }



}