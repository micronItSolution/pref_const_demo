import 'package:get/get.dart';
import 'package:pills_reminder/ui/sign_up/sign_up_logic.dart';


class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpLogic());
  }
}
