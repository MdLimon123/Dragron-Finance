import 'package:demo_project/app/core/network/api_endpoints.dart';
import 'package:demo_project/app/core/network/base_api_service.dart';
import 'package:demo_project/app/core/storage/storage_service.dart';
import 'package:demo_project/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final BaseApiService _baseApiService = BaseApiService();

  final isLoading = false.obs;

  final isRememberMe = false.obs;

  void toggleRememberMe(bool? value) {
    isRememberMe.value = value ?? false;
  }

  @override
  void onInit() {
    super.onInit();
    final savedEmail = StorageService().getSavedEmail();
    final savedPassword = StorageService().getSavedPassword();
    
    if (savedEmail != null && savedPassword != null) {
      emailController.text = savedEmail;
      passwordController.text = savedPassword;
      isRememberMe(true);
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> loginUser() async {
    isLoading(true);

    final body = {
      "email_address": emailController.text.trim(),
      "password": passwordController.text,
    };

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    try {
      print("===== LOGIN REQUEST =====");
      print("URL: ${ApiEndpoints.login}");
      print("Body: $body");
      print("=========================");

      final response = await _baseApiService.post(
        ApiEndpoints.login,
        body: body,
        extraHeaders: headers,
      );

      print("===== LOGIN RESPONSE =====");
      print(response);
      print("==========================");

      final token = response?['data']?['tokens']?['accessToken'];
      if (token != null) {
        await StorageService().saveToken(token);
      }

      if (isRememberMe.value) {
        await StorageService().saveCredentials(
          emailController.text.trim(),
          passwordController.text,
        );
      } else {
        await StorageService().clearCredentials();
      }

      Get.snackbar(
        "Success",
        response?['message'] ?? "Login successful",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      Get.offAllNamed(AppRoutes.mainPage);
    } catch (e) {
      print("===== LOGIN ERROR =====");
      print(e.toString());
      print("=======================");
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      if (!isClosed) {
        isLoading(false);
      }
    }
  }
}
