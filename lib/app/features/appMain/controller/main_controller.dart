import 'package:get/get.dart';

class MainController extends GetxController {
  final RxInt currentIndex = 0.obs;
  final RxInt notificationCount = 3.obs;

  void onTabTapped(int index) {
    currentIndex.value = index;
  }
}
