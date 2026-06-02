import 'package:demo_project/app/features/KYC-Verify/controller/kyc_verify_controller.dart';
import 'package:get/get.dart';

class KycBinding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut<KycVerifyController>(() => KycVerifyController());
  }
}