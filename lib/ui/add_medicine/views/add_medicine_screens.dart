import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart';
import 'package:pills_reminder/custom/top_bar/topbar.dart';
import 'package:pills_reminder/interfaces/top_bar_click_listener.dart';
import 'package:pills_reminder/ui/add_medicine/controller/add_medicine_controller.dart';
import 'package:pills_reminder/utils/asset.dart';
import 'package:pills_reminder/utils/color.dart';
import 'package:pills_reminder/utils/constant.dart';
import 'package:pills_reminder/utils/enums.dart';
import 'package:pills_reminder/utils/font_style.dart';
import 'package:pills_reminder/utils/sizer_utils.dart';

class AddMedicineScreen extends StatelessWidget implements TopBarClickListener {
  final AddMedicineController addMedicineController =
      Get.find<AddMedicineController>();

  AddMedicineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.colorTheme,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.colorTheme,
        automaticallyImplyLeading: false,
        flexibleSpace: TopBar(
          headerTitle: addMedicineController.isEdit
              ? "txtUpdateMedicine".tr.toUpperCase()
              : "txtAddMedicine".tr.toUpperCase(),
          isShowBack: true,
          clickListener: this,
          isShowSave: true,
        ),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: AppSizes.height_88,
              width: AppSizes.fullWidth,
              decoration: BoxDecoration(
                  color: Get.theme.colorScheme.background,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14.0, vertical: 16),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _textTextField(icon: AppAsset.icMedicineName),
                      SizedBox(
                        height: AppSizes.height_3,
                      ),
                      GetBuilder<AddMedicineController>(
                          id: Constant.idDosageSelect,
                          builder: (logic) {
                            return _settingItem(
                                icon: AppAsset.icDosage,
                                text: "txtDosage".tr,
                                defaultIcon: AppAsset.icRightBlack,
                                isShowDefault: true,
                                defaultText:
                                    "${logic.dosageController.text} ${logic.dosageChoose}",
                                onTap: () {
                                  logic.selectDosage();
                                },
                                isShowBack: true);
                          }),
                      _divider(),
                      GetBuilder<AddMedicineController>(
                          id: Constant.idSelectedColor,
                          builder: (logic) {
                            return _settingItem(
                                icon: AppAsset.icColor,
                                text: "txtColorOrPhoto".tr,
                                onTap: logic.gotoSelectColor,
                                defaultIcon: AppAsset.icRightBlack,
                                isShowBack: true,
                                defaultText: logic.isEdit ? "" : "none",
                                color: logic.shadeColor,
                                image: logic.image,
                                isShowDefault: logic.shadeColor == null &&
                                    logic.image == null);
                          }),
                      _divider(),
                      GetBuilder<AddMedicineController>(
                          id: Constant.idSelectAlertSound,
                          builder: (logic) {
                            return _settingItem(
                                icon: AppAsset.icAlertSound,
                                text: "txtAlertsSound".tr,
                                defaultIcon: AppAsset.icRightBlack,
                                onTap: logic.gotoSelectAlertSound,
                                isShowBack: true,
                                defaultText:
                                    logic.pickedSoundTitle ?? "txtDefault".tr,
                                isShowDefault: true);
                          }),
                      _divider(),
                      GetBuilder<AddMedicineController>(
                          id: Constant.idSelectStartDate,
                          builder: (logic) {
                            return _settingItem(
                                icon: AppAsset.icCalender,
                                text: "txtStartDate".tr,
                                onTap: logic.selectStartDate,
                                defaultText: DateFormat('d MMM, yyyy')
                                    .format(logic.startDate!),
                                isShowDefault: true);
                          }),
                      _divider(),
                      GetBuilder<AddMedicineController>(
                          id: Constant.idSelectEndDate,
                          builder: (logic) {
                            return _settingItem(
                                icon: AppAsset.icCalender,
                                text: "End Date",
                                onTap: logic.selectEndDateDate,
                                defaultText: DateFormat('d MMM, yyyy')
                                    .format(logic.endDate!),
                                isShowDefault: true);
                          }),
                      _divider(),
                      GetBuilder<AddMedicineController>(
                          id: Constant.idSelectFrequency,
                          builder: (logic) {
                            return _settingItem(
                                icon: AppAsset.icFrequency,
                                text: "Frequency",
                                onTap: logic.selectFrequency,
                                defaultText: logic.frequency,
                                isShowDefault: true);
                          }),
                      _divider(),
                      _settingItem(
                          icon: AppAsset.icTime,
                          text: "Add Time",
                          defaultIcon: AppAsset.icAdd,
                          onTap: () => Get.find<AddMedicineController>()
                              .selectTime(context),
                          isShowBack: true),
                      buildSelectedTimeList(),
                      _divider(),
                      Get.find<AddMedicineController>().isEdit
                          ? Column(
                              children: [
                                GetBuilder<AddMedicineController>(
                                    id: Constant.isUserActive,
                                    builder: (logic) {
                                      return _settingItem(
                                          icon: AppAsset.icUserActive,
                                          text: "txtUserActive".tr,
                                          defaultIcon: AppAsset.icDoneBlack,
                                          onTap: () => logic.onTapUserActive(),
                                          isShowBack: logic.isUserActive!);
                                    }),
                                _divider(),
                                GetBuilder<AddMedicineController>(
                                    id: Constant.isUserActive,
                                    builder: (logic) {
                                      return _settingItem(
                                          icon: AppAsset.icSuspend,
                                          text: "txtSuspend".tr,
                                          defaultIcon: AppAsset.icDoneBlack,
                                          onTap: () => logic.onTapSuspend(),
                                          isShowBack: logic.isSuspend!);
                                    }),
                                SizedBox(
                                  height: AppSizes.height_1,
                                ),
                                GetBuilder<AddMedicineController>(
                                    builder: (logic) {
                                  return InkWell(
                                    onTap: () {
                                      logic.deleteTap();
                                    },
                                    child: Container(
                                      width: AppSizes.width_72,
                                      height: AppSizes.height_5_5,
                                      decoration: BoxDecoration(
                                        color: AppColor.blue,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                          child: Text(
                                        "Delete",
                                        style: AppFontStyle.styleW500(
                                            AppColor.white,
                                            AppFontSize.size_12),
                                      )),
                                    ),
                                  );
                                })
                              ],
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void onTopBarClick(EnumTopBar name, {bool value = true}) {
    if (name == EnumTopBar.topBarBack) {
      Get.back();
    }
    if (name == EnumTopBar.topBarSave) {
      if (Get.find<AddMedicineController>().isEdit) {
        Get.find<AddMedicineController>().updateMedicineToDatabase(Get.context);
      } else {
        Get.find<AddMedicineController>().insertMedicineToDatabase(Get.context);
      }
    }
  }

  _settingItem(
      {String? icon,
      String? text,
      String? defaultText,
      String? defaultIcon,
      CroppedFile? image,
      Color? color,
      Function()? onTap,
      bool isShowBack = false,
      bool isShowDefault = false}) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          const SizedBox(
            width: 6,
          ),
          Image.asset(
            icon!,
            gaplessPlayback: true,
            height: AppSizes.height_4,
            color: AppColor.colorTheme,
          ),
          SizedBox(width: AppSizes.width_2),
          Expanded(
            child: Text(
              text!,
              style: AppFontStyle.styleW500(
                Get.context!.theme.primaryColor,
                AppFontSize.size_12,
              ),
            ),
          ),
          if (image != null) ...{
            Image.file(File(image.path),
                fit: BoxFit.cover,
                height: AppSizes.width_7,
                width: AppSizes.width_7)
          },
          if (color != null) ...{
            Container(
              color: color,
              width: AppSizes.width_6,
              height: AppSizes.width_6,
            )
          },
          if (isShowDefault) ...{
            Text(
              defaultText ?? "",
              style: AppFontStyle.styleW500(
                Get.context!.theme.primaryColor,
                AppFontSize.size_10,
              ),
            ),
          },
          if (isShowBack) ...{
            Image.asset(
              defaultIcon ?? "",
              width: AppSizes.height_3_5,
              color: AppColor.colorTheme,
            ),
          }
        ],
      ),
    );
  }

  _divider() {
    return Divider(
      color: AppColor.colorTheme.withOpacity(0.3),
      thickness: 1.3,
      height: AppSizes.height_4,
    );
  }

  _textTextField({required String icon}) {
    return TextFormField(
      // autofocus: false,
      // focusNode: FocusScope.of(context).requestFocus(FocusNode()),
      style: AppFontStyle.styleW500(
          Get.context!.theme.primaryColor, AppFontSize.size_11),
      textAlign: TextAlign.left,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.newline,
      onChanged: (value) {},
      cursorColor: AppColor.colorTheme,
      controller: addMedicineController.textController,
      // autofocus: true,
      maxLines: 1,

      decoration: InputDecoration(
        prefixIcon: Image.asset(
          icon,
          cacheWidth: 35,
          color: AppColor.colorTheme,
        ),
        filled: false,
        contentPadding: EdgeInsets.symmetric(
            horizontal: AppSizes.width_4, vertical: AppSizes.height_1),
        hintText: "txtMedicineName".tr,
        hintStyle: AppFontStyle.styleW500(
            Get.context!.theme.primaryColor.withOpacity(0.5),
            AppFontSize.size_12),
        border: const UnderlineInputBorder(
            borderSide: BorderSide(
          color: AppColor.colorTheme,
        )),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
          color: AppColor.colorTheme.withOpacity(0.3),
        )),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
          color: AppColor.colorTheme.withOpacity(0.3),
        )),
        disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
          color: AppColor.colorTheme.withOpacity(0.3),
        )),
        errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
          color: AppColor.colorTheme.withOpacity(0.3),
        )),
        focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
          color: AppColor.colorTheme.withOpacity(0.3),
        )),
      ),
    );
  }

  Widget buildSelectedTimeList() {
    return GetBuilder<AddMedicineController>(
        id: Constant.idSelectedTime,
        builder: (logic) {
          return ListView.builder(
            itemCount: logic.selectedTimeList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final time = logic.selectedTimeList[index];
              return Dismissible(
                key: Key(time.toString()),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 16.0),
                  color: Colors.red,
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                onDismissed: (direction) {
                  logic.deleteSelectedTime(index: index);
                },
                child: ListTile(
                  title: Text(time.format(context)),
                ),
              );
            },
          );
        });
  }
}
