
import 'package:demo_project/app/features/loan/controller/loan_controller.dart';
import 'package:get/get.dart';

class LoanBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<LoanController>(()=> LoanController());
  }
}