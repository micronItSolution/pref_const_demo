
import 'package:get/get.dart';
import 'package:pills_reminder/ui/update_medicine/controller/update_medicine_controller.dart';

class UpdateMedicineBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateMedicineController>(
          () => UpdateMedicineController(),
    );
  }
}