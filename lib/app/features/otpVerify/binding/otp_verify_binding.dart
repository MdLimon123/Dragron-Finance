import 'package:demo_project/app/features/otpVerify/controller/verify_controller.dart';
import 'package:get/get.dart';

class OtpVerifyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerifyController>(() => VerifyController());
  }
}