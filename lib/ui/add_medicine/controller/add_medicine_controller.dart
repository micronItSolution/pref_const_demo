import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:pills_reminder/database/helper/database_helper.dart';
import 'package:pills_reminder/database/helper/firestore_helper.dart';
import 'package:pills_reminder/database/tables/medicine_table.dart';
import 'package:pills_reminder/database/tables/notification_table.dart';
import 'package:pills_reminder/dialog/delete_confirmation/delete_confirmation_dialog.dart';
import 'package:pills_reminder/dialog/dosage_select/dosage_select_dialog.dart';
import 'package:pills_reminder/dialog/frequency_select/frequencySelectDialog.dart';
import 'package:pills_reminder/notification/notification_helper.dart';
import 'package:pills_reminder/routes/app_routes.dart';
import 'package:pills_reminder/ui/home/controller/home_controller.dart';
import 'package:pills_reminder/utils/constant.dart';
import 'package:pills_reminder/utils/debug.dart';
import 'package:pills_reminder/utils/preference.dart';
import 'package:pills_reminder/utils/utils.dart';

class AddMedicineController extends GetxController {
  TextEditingController textController = TextEditingController();
  TextEditingController dosageController = TextEditingController();
  bool isEdit = false;
  MedicineTable? medicines;
  dynamic args = Get.arguments;
  String? dosage;
  bool? isUserActive = true;
  bool? isSuspend = false;

  @override
  void onInit() {
    getDataFromArgs();
    if (isEdit) {
      splitDosage();
      splitColor();
      pickedSoundTitle = medicines?.mSoundTitle;
      frequency = medicines!.mFrequencyType!;
      parseTimeList(medicines!.mTime!);
      startDate = DateTime.parse(medicines!.mStartDate!);
      pickedSoundType = medicines!.mSoundType!;
      endDate = DateTime.parse(medicines!.mEndDate!);
      pickedSoundUri = medicines!.mDeviceSoundUri!;
      isSuspend = medicines?.mIsActive == 0 ? true : false;
      isUserActive = medicines?.mIsActive == 0 ? false : true;
    }
    textController.text = (isEdit ? medicines?.mName : "")!;
    dosageController.text = (isEdit ? dosage : "")!;

    super.onInit();
  }

  splitDosage() {
    List<String>? mDosage = medicines?.mDosage?.split(" ");
    dosage = mDosage?[0];
    dosageChoose = mDosage![1];
  }

  splitColor() {
    if (medicines?.mColorPhotoType == "shadeColor") {
      Color color = Color(int.parse(medicines!.mColorPhoto!));
      String colorString = color.toString();
      String valueString = colorString.split('(0x')[1].split(')')[0];
      int value = int.parse(valueString, radix: 16);
      shadeColor = Color(value);
    } else {
      image = CroppedFile(medicines!.mColorPhoto!);
    }
  }

  getDataFromArgs() {
    if (args != null) {
      if (args[0] != null) {
        isEdit = args[0];
      }
      if (args[1] != null) {
        medicines = args[1];
      }
    }
  }

  String dosageChoose = Constant.dosageDataList.first;
  String? pickedSoundTitle;
  String? pickedSoundType;
  String? pickedSoundUri;
  CroppedFile? image;
  Color? shadeColor;
  DateTime? startDate = DateTime.now(), endDate = DateTime.now();
  List<int> selectedDayInt = [];

  String frequency = 'Every day'; //'Specific day';

  bool selectedEverydayFrequency = true;
  List<TimeOfDay> selectedTimeList = [];
  int id = 1;
  List<bool> selectedWeekDaysList =
      List<bool>.filled(Constant.weekDaysList.length, false);

  selectDosage() {
    Utils.unFocusKeyboard();
    Get.dialog(const DosageSelectDialog(), useSafeArea: false);
  }

  void onDropDownItemSelected(String newSelectedBank) {
    dosageChoose = newSelectedBank;
    update([Constant.idSelectedDosage]);
  }

  List<TimeOfDay> parseTimeList(String data) {
    // Extract time strings from the data string
    final regex = RegExp(r"TimeOfDay\((\d{2}:\d{2})\)");
    final matches = regex.allMatches(data);

    for (Match match in matches) {
      String timeString = match.group(1)!;
      List<String> parts = timeString.split(':');
      int hour = int.parse(parts[0]);
      int minute = int.parse(parts[1]);
      selectedTimeList.add(TimeOfDay(hour: hour, minute: minute));
    }

    return selectedTimeList;
  }

  gotoSelectColor() async {
    Utils.unFocusKeyboard();

    image = null;
    shadeColor = null;
    Map<String, dynamic> map = await Get.toNamed(AppRoutes.selectColor);

    if (map[Constant.idImageArg] != null) {
      image = map[Constant.idImageArg];
    } else if (map[Constant.idColorArg] != null) {
      shadeColor = map[Constant.idColorArg];
    }
    update([Constant.idSelectedColor]);
  }

  gotoSelectAlertSound() async {
    Utils.unFocusKeyboard();

    Map<String, dynamic> map = await Get.toNamed(AppRoutes.selectRingtone);
    if (map[Constant.idSoundUriArgs] != null) {
      pickedSoundUri = map[Constant.idSoundUriArgs];
    }
    if (map[Constant.idSoundTitleArgs] != null) {
      pickedSoundTitle = map[Constant.idSoundTitleArgs];
    }
    if (map[Constant.idSoundTypeArgs] != null) {
      pickedSoundType = map[Constant.idSoundTypeArgs];
    }
    update([Constant.idSelectAlertSound]);
  }

  Future<void> selectStartDate() async {
    Utils.unFocusKeyboard();
    final DateTime currentDate = DateTime.now();

// Ensure startDate is not before the current date
    if (startDate == null || startDate!.isBefore(currentDate)) {
      startDate = currentDate;
    }

    final DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: startDate!,
      firstDate: currentDate,
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != startDate) {
      startDate = picked;
      update([Constant.idSelectStartDate]);
    }
/* final DateTime? picked = await showDatePicker(
        context: Get.context!,
        initialDate: startDate!,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != startDate) {
      startDate = picked;
      update([Constant.idSelectStartDate]);
    }*/
  }

  Future<void> selectEndDateDate() async {
    Utils.unFocusKeyboard();
    final DateTime currentDate = DateTime.now();

    if (startDate == null || startDate!.isBefore(currentDate)) {
      startDate = currentDate;
    }
    final DateTime? picked = await showDatePicker(
        context: Get.context!,
        initialDate: endDate!,
        firstDate: currentDate,
        lastDate: DateTime(2101));
    if (picked != null && picked != endDate) {
      endDate = picked;
      update([Constant.idSelectEndDate]);
    }
  }

  selectFrequency() {
    Utils.unFocusKeyboard();

    Get.dialog(const FrequencySelectDialog(), useSafeArea: false);
  }

  List<String> getSelectedWeekDays() {
    List<String> selectedDays = [];
    for (int i = 0; i < selectedWeekDaysList.length; i++) {
      if (selectedWeekDaysList[i]) {
        selectedDays.add('${i + 1} - ${Constant.weekDaysList[i]}');
      }
      print("::::selectedDays::$selectedDays");
    }
    return selectedDays;
  }

  insertMedicineToDatabase(context) async {
    int mId = Preference.shared.getMId();
    if (textController.text.trim().isEmpty) {
      Utils.showToast(context, 'toastMedicineName'.tr);
      return false;
    }
    if (dosageController.text.trim().isEmpty) {
      Utils.showToast(context, 'toastDosageName'.tr);
      return false;
    }
    if (image == null && shadeColor == null) {
      Utils.showToast(context, 'toastSelectImageAndColor'.tr);
      return false;
    }
    if (pickedSoundUri == null) {
      Utils.showToast(context, 'toastSelectSound'.tr);
      return false;
    }
    if (startDate == null) {
      Utils.showToast(context, 'toastSelectStartDate'.tr);
      return false;
    }
    if (endDate == null) {
      Utils.showToast(context, 'toastSelectEndDate'.tr);
      return false;
    }
    if (selectedTimeList.isEmpty) {
      Utils.showToast(context, 'toastSelectTime'.tr);
      return false;
    }

    // Construct the mDosage string using dosageController and dosageChoose
    String dosage = "${dosageController.text.trim()} $dosageChoose";

    // Determine mColorPhoto based on whether image is available
    String? colorPhoto =
        image != null ? image?.path.toString() : shadeColor?.value.toString();

    // Determine mFrequencyType based on selectedEverydayFrequency
    String frequencyType =
        selectedEverydayFrequency ? "Every day" : "Specific day";

    // Construct mDayOfWeek string using selectedDayInt
    String dayOfWeek = selectedDayInt.toString();

    // Construct mTime string using selectedTimeList
    String time = selectedTimeList.toString();

    // Determine mIsFromDevice based on pickedSoundType
    int isFromDevice = pickedSoundType == "Sound" ? 0 : 1;

    // Insert medicine data into database
    Utils.unFocusKeyboard();

    var result = await DataBaseHelper().insertOrUpdateMedicineData(
      MedicineTable(
          mId: null,
          mName: textController.text.trim(),
          mDosage: dosage,
          mColorPhoto: colorPhoto,
          mDeviceSoundUri: pickedSoundUri,
          mStartDate: startDate.toString(),
          mEndDate: endDate.toString(),
          mCurrentTime: DateTime.now().toString(),
          mColorPhotoType: image != null ? "image" : "shadeColor",
          mFrequencyType: frequencyType,
          mSoundType: pickedSoundType,
          mDayOfWeek: dayOfWeek,
          mTime: time,
          mIsFromDevice: isFromDevice,
          mIsActive: 1,
          mSoundTitle: pickedSoundTitle),
    );

    FireStoreHelper().addAndUpdateMedicine(
      mId.toString(),
      MedicineTable(
          mId: mId,
          mName: textController.text.trim(),
          mDosage: dosage,
          mColorPhoto: colorPhoto,
          mDeviceSoundUri: pickedSoundUri,
          mStartDate: startDate.toString(),
          mEndDate: endDate.toString(),
          mCurrentTime: DateTime.now().toString(),
          mColorPhotoType: image != null ? "image" : "shadeColor",
          mFrequencyType: frequencyType,
          mSoundType: pickedSoundType,
          mDayOfWeek: dayOfWeek,
          mTime: time,
          mIsFromDevice: isFromDevice,
          mIsActive: 1,
          mSoundTitle: pickedSoundTitle),
    );
    List<MedicineTable> medicineDataList =
        await DataBaseHelper().getMedicineData(result: result);
    Debug.printLog("insert MedicineData res: $result");

    for (MedicineTable medicineTable in medicineDataList) {
      Debug.printLog("insert MedicineData res: ${medicineTable.toJson()}");
    }

    NotificationHelper()
        .scheduleDailyNotification(medicineTable: medicineDataList[0]);
    Get.find<HomeController>().getDataFromDatabase();
    id++;
    Preference.shared.setMId(id);
    Get.back();
    update([Constant.idHome, Constant.idMedicineList]);
  }

  updateMedicineToDatabase(context) async {
    if (textController.text.trim().isEmpty) {
      Utils.showToast(context, 'toastMedicineName'.tr);
      return false;
    }
    if (dosageController.text.trim().isEmpty) {
      Utils.showToast(context, 'toastDosageName'.tr);
      return false;
    }
    if (image == null && shadeColor == null) {
      Utils.showToast(context, 'toastSelectImageAndColor'.tr);
      return false;
    }
    if (pickedSoundUri == null) {
      Utils.showToast(context, 'toastSelectSound'.tr);
      return false;
    }
    if (startDate == null) {
      Utils.showToast(context, 'toastSelectStartDate'.tr);
      return false;
    }
    if (endDate == null) {
      Utils.showToast(context, 'toastSelectEndDate'.tr);
      return false;
    }
    if (selectedTimeList.isEmpty) {
      Utils.showToast(context, 'toastSelectTime'.tr);
      return false;
    }

    // Construct the mDosage string using dosageController and dosageChoose
    String dosage = "${dosageController.text.trim()} $dosageChoose";

    // Determine mColorPhoto based on whether image is available
    String? colorPhoto =
        image != null ? image?.path.toString() : shadeColor?.value.toString();

    // Determine mFrequencyType based on selectedEverydayFrequency
    String frequencyType =
        selectedEverydayFrequency ? "Every day" : "Specific day";

    // Construct mDayOfWeek string using selectedDayInt
    String dayOfWeek = selectedDayInt.toString();

    // Construct mTime string using selectedTimeList
    String time = selectedTimeList.toString();

    // Determine mIsFromDevice based on pickedSoundType
    int isFromDevice = pickedSoundType == "Sound" ? 0 : 1;

    // Insert medicine data into database
    Utils.unFocusKeyboard();
    var result = await DataBaseHelper().updateMedicineData(
      medicines!.mId!,
      MedicineTable(
          mId: medicines?.mId,
          mName: textController.text.trim(),
          mDosage: dosage,
          mColorPhoto: colorPhoto,
          mDeviceSoundUri: pickedSoundUri,
          mStartDate: startDate.toString(),
          mEndDate: endDate.toString(),
          mCurrentTime: DateTime.now().toString(),
          mColorPhotoType: image != null ? "image" : "shadeColor",
          mFrequencyType: frequencyType,
          mSoundType: pickedSoundType,
          mDayOfWeek: dayOfWeek,
          mTime: time,
          mIsFromDevice: isFromDevice,
          mIsActive: isUserActive! ? 1 : 0,
          mSoundTitle: pickedSoundTitle),
    );
    FireStoreHelper().addAndUpdateMedicine(
      medicines!.mId!.toString(),
      MedicineTable(
          mId: medicines?.mId,
          mName: textController.text.trim(),
          mDosage: dosage,
          mColorPhoto: colorPhoto,
          mDeviceSoundUri: pickedSoundUri,
          mStartDate: startDate.toString(),
          mEndDate: endDate.toString(),
          mCurrentTime: DateTime.now().toString(),
          mColorPhotoType: image != null ? "image" : "shadeColor",
          mFrequencyType: frequencyType,
          mSoundType: pickedSoundType,
          mDayOfWeek: dayOfWeek,
          mTime: time,
          mIsFromDevice: isFromDevice,
          mIsActive: isUserActive! ? 1 : 0,
          mSoundTitle: pickedSoundTitle),
    );

    /// medicine

    List<MedicineTable> medicineDataList =
        await DataBaseHelper().getMedicineData(result: medicines!.mId!);
    Debug.printLog("insert MedicineData res: $result");

    for (MedicineTable medicineTable in medicineDataList) {
      Debug.printLog("insert MedicineData res: ${medicineTable.toJson()}");
    }

    /// Notification
    List<NotificationTable> notificationDataList =
        await DataBaseHelper().getNotificationData(result: medicines!.mId);
    Debug.printLog("----<>-<>--Get NotificationData res: $result----<>-<>--");

    for (NotificationTable notificationTable in notificationDataList) {
      Debug.printLog(
          "----<>-<>--Get NotificationData res: ${notificationTable.toJson()}----<>-<>--");
    }

    NotificationHelper().scheduleDailyNotification(
        medicineTable: medicineDataList[0], notification: notificationDataList);
    Get.find<HomeController>().getDataFromDatabase();
    Get.close(2);
    update(
        [Constant.idHome, Constant.idMedicineList, Constant.isMedicineDetails]);
  }

  onTapOkDeleteBtn() {
    DataBaseHelper().deleteMedicineData(medicines!.mId!);
    FireStoreHelper().deleteMedicine(medicines!.mId!);
    FireStoreHelper().deleteNotificationsByMid(medicines!.mId!);
    DataBaseHelper().deleteNotificationData(medicines!.mId!);
    Get.find<HomeController>().getDataFromDatabase();
    Get.close(3);
  }

  deleteTap() {
    Get.dialog(const DeleteConfirmationDialog(), useSafeArea: false);
  }

  void selectSpecificDay({required int index, required bool value}) {
    selectedEverydayFrequency = false;
    selectedWeekDaysList[index] = value;
    int lengthOfSelectedWeekDaysList =
        selectedWeekDaysList.where((element) => element == true).length;
    print("selectedEverydayFrequency::::::$selectedEverydayFrequency");
    print("selectedWeekDaysList::::::$selectedWeekDaysList");

    if (lengthOfSelectedWeekDaysList == 0) {
      selectedEverydayFrequency = true;
    }

    update([Constant.idSelectEveryDay, Constant.idSelectSpecificDay]);
  }

  onTapUserActive() {
    isUserActive = !isUserActive!;
    isSuspend = false;
    update([Constant.isUserActive]);
  }

  onTapSuspend() {
    isUserActive = !isUserActive!;
    isSuspend = true;
    update([Constant.isUserActive]);
  }

  void changeSelectEveryDay({required bool value}) {
    if (value) {
      selectedEverydayFrequency = value;
      selectedWeekDaysList =
          List.generate(selectedWeekDaysList.length, (index) => false);
      print(selectedWeekDaysList);
    } else {
      selectedEverydayFrequency = value;
      selectedWeekDaysList = List.generate(
          selectedWeekDaysList.length, (index) => index == 0 ? true : false);
    }
    update([Constant.idSelectEveryDay, Constant.idSelectSpecificDay]);
  }

  void updateFrequency() {
    frequency = selectedEverydayFrequency ? 'Every day' : 'Specific day';

    selectedDayInt.clear();

    if (selectedEverydayFrequency) {
      print('selectedEverydayFrequency :$selectedEverydayFrequency');
      for (var i = 1; i < 8; i++) {
        selectedDayInt.add(i);
        print(i);
        print('selectedDayInt : ${selectedDayInt.toString()}');
      }
    } else {
      for (var i = 0; i < selectedWeekDaysList.length; i++) {
        if (selectedWeekDaysList[i]) {
          selectedDayInt.add(i + 1);
          print(i);
          print(selectedDayInt);
        }
      }
    }

    update([Constant.idSelectFrequency]);
  }

  Future<void> selectTime(BuildContext context) async {
    Utils.unFocusKeyboard();

    TimeOfDay selectedTime = TimeOfDay.now();
    final TimeOfDay? pickedS = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        builder: (BuildContext? context, Widget? child) {
          return MediaQuery(
            data:
                MediaQuery.of(context!).copyWith(alwaysUse24HourFormat: false),
            child: child!,
          );
        });

    if (pickedS != null && pickedS != selectedTime) {
      selectedTime = pickedS;
      selectedTimeList.add(selectedTime);
      update([Constant.idSelectedTime]);

      Debug.printLog(selectedTimeList.toString());
    }
  }

  void deleteSelectedTime({required int index}) {
    selectedTimeList.removeAt(index);
    update([Constant.idSelectedTime]);
  }
}
