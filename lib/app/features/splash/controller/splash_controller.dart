import 'package:get/get.dart';

import 'package:demo_project/app/routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateToNextPage();
  }

  Future<void> _navigateToNextPage() async {
    await Future<void>.delayed(const Duration(seconds: 2));

    Get.offAllNamed(AppRoutes.onboarding);
  }
}
