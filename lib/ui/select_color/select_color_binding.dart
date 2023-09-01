import 'package:get/get.dart';

import 'select_color_logic.dart';

class SelectColorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SelectColorLogic());
  }
}
