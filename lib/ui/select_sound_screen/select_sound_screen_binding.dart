import 'package:get/get.dart';

import 'select_sound_screen_logic.dart';

class SelectSoundScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SelectSoundScreenLogic());
  }
}
