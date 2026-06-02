import 'package:demo_project/app/features/book-a-call/controller/bookcall_controller.dart';
import 'package:get/get.dart';

class BookCallBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookCallController>(() => BookCallController());
  }
}
