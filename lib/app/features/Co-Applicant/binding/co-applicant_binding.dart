import 'package:demo_project/app/features/Co-Applicant/controller/co-application_controller.dart';
import 'package:get/get.dart';

class CoApplicantBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<CoApplicationController>(() => CoApplicationController());
  }
}