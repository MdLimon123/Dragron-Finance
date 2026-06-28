import 'package:demo_project/app/core/network/api_endpoints.dart';
import 'package:demo_project/app/core/network/base_api_service.dart';
import 'package:demo_project/app/core/storage/storage_service.dart';
import 'package:demo_project/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  final isAgreementAccepted = false.obs;
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();

  final BaseApiService baseApiService = BaseApiService();

  final isLoading = false.obs;

  void toggleAgreement(bool? value) {
    isAgreementAccepted.value = value ?? false;
  }


  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> signupUser() async {
    isLoading(true);

    final body = {
      "full_name": nameController.text,
      "email_address": emailController.text,
      "phone_number": phoneNumberController.text,
      "password": passwordController.text,
      "agreed_terms_business": isAgreementAccepted.value
    };

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    try {
      // Clear any old/expired token from previous tests so it doesn't cause a 401
      await StorageService().removeToken();
      
      print("===== SIGNUP REQUEST =====");
      print("URL: ${ApiEndpoints.signup}");
      print("Body: $body");
      print("==========================");

      final response = await baseApiService.post(
        ApiEndpoints.signup,
        body: body,
        extraHeaders: headers,
      );

      print("===== SIGNUP RESPONSE =====");
      print(response);
      print("===========================");

      Get.snackbar(
        "Success",
          response['message'] ?? "Signup successful. OTP sent to email.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      Get.toNamed(AppRoutes.emailVerification, arguments: {'email': emailController.text});
    } catch (e) {
      print("===== SIGNUP ERROR =====");
      print(e.toString());
      print("========================");
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