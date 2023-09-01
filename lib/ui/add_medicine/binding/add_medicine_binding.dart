
import 'package:get/get.dart';
import 'package:pills_reminder/ui/add_medicine/controller/add_medicine_controller.dart';
import 'package:pills_reminder/ui/home/controller/home_controller.dart';

class AddMedicineBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddMedicineController>(
          () => AddMedicineController(),
    );
  }
}