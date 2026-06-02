import 'package:demo_project/app/features/liveChat/controller/live_chat_controller.dart';
import 'package:get/get.dart';

class LiveChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LiveChatController());
  }
}