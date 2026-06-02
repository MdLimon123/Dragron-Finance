import 'package:get/get.dart';

class LoginController extends GetxController {
  final isRememberMe = false.obs;

  void toggleRememberMe(bool? value) {
    isRememberMe.value = value ?? false;
  }
}
