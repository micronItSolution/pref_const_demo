
import 'package:get/get.dart';
import 'package:pills_reminder/ui/home/controller/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    // Get.lazyPut<HomeController>(
    //       () => HomeController(),
    // );
  }
}