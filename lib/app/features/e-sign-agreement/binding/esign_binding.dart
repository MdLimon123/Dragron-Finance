import 'package:demo_project/app/features/e-sign-agreement/controller/esign_controller.dart';
import 'package:get/get.dart';

class EsignBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<EsignController>(() => EsignController());
  }
}