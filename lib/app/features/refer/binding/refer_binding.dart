import 'package:get/get.dart';
import 'package:demo_project/app/features/refer/controller/refer_controller.dart';  

class ReferBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReferController());
  }
}   