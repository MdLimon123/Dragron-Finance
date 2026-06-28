import 'package:demo_project/app/core/network/api_endpoints.dart';
import 'package:demo_project/app/core/network/base_api_service.dart';
import 'package:demo_project/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final isLoading = false.obs;
  final BaseApiService _baseApiService = BaseApiService();

  @override
  void onClose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  Future<void> resetPassword() async {
    isLoading(true);

    final body = {
      "new_password": newPasswordController.text,
      "confirm_password": confirmPasswordController.text,
    };

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    try {
      print("===== RESET PASSWORD REQUEST =====");
      print("URL: ${ApiEndpoints.changePassword}");
      print("Body: $body");
      print("==================================");

      final response = await _baseApiService.post(
        ApiEndpoints.changePassword,
        body: body,
        extraHeaders: headers,
      );

      print("===== RESET PASSWORD RESPONSE =====");
      print(response);
      print("===================================");

      Get.snackbar(
        "Success",
        response['message'] ?? "Password reset successfully",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      Get.offAllNamed(AppRoutes.login);
    } catch (e) {
      print("===== RESET PASSWORD ERROR =====");
      print(e.toString());
      print("================================");
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
