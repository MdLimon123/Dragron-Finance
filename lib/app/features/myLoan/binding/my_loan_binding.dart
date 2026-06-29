import 'package:demo_project/app/features/myLoan/controller/my_loan_controller.dart';
import 'package:get/get.dart';

class MyLoanBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<MyLoanController>(()=> MyLoanController());
  }
}