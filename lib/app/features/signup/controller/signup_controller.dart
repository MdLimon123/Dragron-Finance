import 'package:get/get.dart';

class SignupController extends GetxController {
  final isAgreementAccepted = false.obs;

  void toggleAgreement(bool? value) {
    isAgreementAccepted.value = value ?? false;
  }
}