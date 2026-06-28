import 'dart:async';
import 'package:demo_project/app/core/network/api_endpoints.dart';
import 'package:demo_project/app/core/network/base_api_service.dart';
import 'package:demo_project/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailVerificationController extends GetxController {
  final List<TextEditingController> otpControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> otpFocusNodes = List.generate(6, (_) => FocusNode());

  final BaseApiService _baseApiService = BaseApiService();

  final isLoading = false.obs;
  final isResending = false.obs;

  final RxInt remainingSeconds = 180.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    remainingSeconds.value = 180;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> resendCode() async {
    if (remainingSeconds.value == 0) {
      final email = Get.arguments?['email'] ?? '';
      if (email.isEmpty) {
        Get.snackbar("Error", "Email address not found");
        return;
      }

      isResending(true);
      
      final body = {
        "email_address": email
      };

      try {
        print("===== RESEND OTP REQUEST =====");
        print("URL: ${ApiEndpoints.resendEmailVerify}");
        print("Body: $body");
        print("==============================");

        final response = await _baseApiService.post(
          ApiEndpoints.resendEmailVerify,
          body: body,
        );

        print("===== RESEND OTP RESPONSE =====");
        print(response);
        print("===============================");

        Get.snackbar(
          "Success",
          response?['message'] ?? "OTP resent successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        startTimer();
      } catch (e) {
        print("===== RESEND OTP ERROR =====");
        print(e.toString());
        print("============================");
        Get.snackbar(
          "Error",
          e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } finally {
        isResending(false);
      }
    }
  }

  String get formattedTime {
    int minutes = remainingSeconds.value ~/ 60;
    int seconds = remainingSeconds.value % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void onClose() {
    _timer?.cancel();
    for (final controller in otpControllers) {
      controller.dispose();
    }

    for (final focusNode in otpFocusNodes) {
      focusNode.dispose();
    }

    super.onClose();
  }


  Future<void> emailVerify() async {
    final otpCode = otpControllers.map((c) => c.text).join();
    if (otpCode.length < 6) {
      Get.snackbar(
        "Error",
        "Please enter the complete 6-digit OTP",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    final email = Get.arguments?['email'] ?? '';
    if (email.isEmpty) {
      Get.snackbar(
        "Error",
        "Email address not found",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isLoading(true);

    final body = {
      "email_address": email,
      "otp_code": otpCode,
    };

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    try {
      print("===== EMAIL VERIFY REQUEST =====");
      print("URL: ${ApiEndpoints.emailVerify}");
      print("Body: $body");
      print("================================");

      final response = await _baseApiService.post(
        ApiEndpoints.emailVerify,
        body: body,
        extraHeaders: headers,
      );

      print("===== EMAIL VERIFY RESPONSE =====");
      print(response);
      print("=================================");

      Get.snackbar(
        "Success",
         response['message'] ??"Email verified successfully",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      Get.toNamed(AppRoutes.login);
    } catch (e) {
      print("===== EMAIL VERIFY ERROR =====");
      print(e.toString());
      print("==============================");
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

  void onOtpChanged(String value, int index) {
    if (value.isNotEmpty && index < otpFocusNodes.length - 1) {
      otpFocusNodes[index + 1].requestFocus();
      return;
    }

    if (value.isEmpty && index > 0) {
      otpFocusNodes[index - 1].requestFocus();
    }
  }
}