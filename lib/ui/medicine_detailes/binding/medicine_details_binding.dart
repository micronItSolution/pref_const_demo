
import 'package:get/get.dart';
import 'package:pills_reminder/ui/medicine_detailes/controller/medicine_details_controller.dart';

class MedicineDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MedicineDetailsController>(
          () => MedicineDetailsController(),
    );

  }
}