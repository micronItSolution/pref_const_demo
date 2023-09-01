import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pills_reminder/custom/top_bar/topbar.dart';
import 'package:pills_reminder/interfaces/top_bar_click_listener.dart';
import 'package:pills_reminder/routes/app_routes.dart';
import 'package:pills_reminder/ui/medicine_detailes/controller/medicine_details_controller.dart';
import 'package:pills_reminder/utils/asset.dart';
import 'package:pills_reminder/utils/color.dart';
import 'package:pills_reminder/utils/constant.dart';
import 'package:pills_reminder/utils/enums.dart';
import 'package:pills_reminder/utils/font_style.dart';
import 'package:pills_reminder/utils/sizer_utils.dart';

class MedicineDetailsScreens extends StatelessWidget
    implements TopBarClickListener {
  final MedicineDetailsController medicineDetailsController =
      Get.find<MedicineDetailsController>();

  MedicineDetailsScreens({super.key});

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
          headerTitle: "txtMedicineDetails".tr.toUpperCase(),
          isShowBack: true,
          isEdit: true,
          clickListener: this,
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
                  child: GetBuilder<MedicineDetailsController>(
                      id: Constant.isMedicineDetails,
                      builder: (logic) {
                        String startDate = DateFormat("dd-MM-yyyy").format(
                            (DateTime.parse(logic.medicines.mStartDate!)));
                        String endDate = DateFormat("dd-MM-yyyy").format(
                            (DateTime.parse(logic.medicines.mEndDate!)));
                        logic.parseTimeList(logic.medicines.mTime!);

                        return Column(
                          children: [
                            _settingItem(
                                icon: AppAsset.icMedicineName,
                                text: "txtMedicineName".tr,
                                defaultIcon: AppAsset.icRightBlack,
                                defaultText: logic.medicines.mName,
                                isShowDefault: true),
                            _divider(),
                            _settingItem(
                                icon: AppAsset.icDosage,
                                text: "txtDosage".tr,
                                defaultIcon: AppAsset.icRightBlack,
                                defaultText: logic.medicines.mDosage,
                                isShowDefault: true),
                            _divider(),
                            _settingItem(
                                icon: AppAsset.icColor,
                                text: "txtColorOrPhoto".tr,
                                defaultIcon: AppAsset.icNone,
                                isShowBack: true),
                            _divider(),
                            _settingItem(
                                icon: AppAsset.icAlertSound,
                                text: "txtAlertsSound".tr,
                                defaultIcon: AppAsset.icRightBlack,
                                defaultText: logic.medicines.mSoundTitle,
                                isShowDefault: true),
                            _divider(),
                            _settingItem(
                                icon: AppAsset.icCalender,
                                text: "txtStartDate".tr,
                                defaultText: startDate,
                                isShowDefault: true),
                            _divider(),
                            _settingItem(
                                icon: AppAsset.icCalender,
                                text: "txtEndDate".tr,
                                defaultText: endDate,
                                isShowDefault: true),
                            _divider(),
                            _settingItem(
                                icon: AppAsset.icFrequency,
                                text: "txtFrequency".tr,
                                defaultText: logic.medicines.mFrequencyType,
                                isShowDefault: true),
                            _divider(),
                            _settingItem(
                                icon: AppAsset.icTime,
                                text: "txtAddTime".tr,
                                isShowTime: true),
                            _divider(),
                            _settingItem(
                                icon: AppAsset.icSuspend,
                                text: "txtActive/txtSuspend".tr,
                                isShowDefault: true,
                                defaultText: logic.medicines.mIsActive == 1
                                    ? "txtActive".tr
                                    : "txtSuspend".tr),
                          ],
                        );
                      }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSelectedTimeList() {
    return GetBuilder<MedicineDetailsController>(builder: (logic) {
      return Expanded(
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: logic.timeList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final time = logic.timeList[index];
            return Text(time.format(context));
          },
        ),
      );
    });
  }

  _settingItem(
      {String? icon,
      String? text,
      String? defaultText,
      String? defaultIcon,
      Function()? onTap,
      bool isShowBack = false,
      bool isShowTime = false,
      bool isShowDefault = false}) {
    return GetBuilder<MedicineDetailsController>(builder: (logic) {
      Color? otherColor;
      if (logic.medicines.mColorPhotoType == "shadeColor") {
        Color color = Color(int.parse(logic.medicines.mColorPhoto!));
        String colorString = color.toString();
        String valueString = colorString.split('(0x')[1].split(')')[0];
        int value = int.parse(valueString, radix: 16);
        otherColor = Color(value);
      }
      return InkWell(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  AppFontSize.size_11,
                ),
              ),
            ),
            SizedBox(
              width: AppFontSize.size_12,
            ),
            if (isShowDefault) ...{
              Text(
                defaultText ?? "",
                style: AppFontStyle.styleW500(
                  Get.context!.theme.primaryColor,
                  AppFontSize.size_10,
                ),
              ),
              const Spacer(),
            },
            if (isShowTime) ...{buildSelectedTimeList()},
            if (isShowBack) ...{
              ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: logic.medicines.mColorPhotoType == "shadeColor"
                      ? Container(
                          color: otherColor,
                          width: AppSizes.width_6,
                          height: AppSizes.width_6,
                        )
                      : Image.file(File(logic.medicines.mColorPhoto!),
                          fit: BoxFit.cover,
                          height: AppSizes.width_7,
                          width: AppSizes.width_7)),
              const Spacer(),
            }
          ],
        ),
      );
    });
  }

  @override
  void onTopBarClick(EnumTopBar name, {bool value = true}) {
    if (name == EnumTopBar.topBarBack) {
      Get.back();
    }
    if (name == EnumTopBar.topBarEdit) {
      Get.toNamed(AppRoutes.add,
          arguments: [true, medicineDetailsController.medicines]);
    }
  }
}

_divider() {
  return Divider(
    color: AppColor.colorTheme.withOpacity(0.3),
    thickness: 1.3,
    height: AppSizes.height_4,
  );
}
