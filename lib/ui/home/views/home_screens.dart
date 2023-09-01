import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pills_reminder/custom/top_bar/topbar.dart';
import 'package:pills_reminder/database/tables/medicine_table.dart';
import 'package:pills_reminder/interfaces/top_bar_click_listener.dart';
import 'package:pills_reminder/routes/app_routes.dart';
import 'package:pills_reminder/ui/home/controller/home_controller.dart';
import 'package:pills_reminder/utils/asset.dart';
import 'package:pills_reminder/utils/color.dart';
import 'package:pills_reminder/utils/constant.dart';
import 'package:pills_reminder/utils/enums.dart';
import 'package:pills_reminder/utils/font_style.dart';
import 'package:pills_reminder/utils/sizer_utils.dart';

class HomeScreen extends StatelessWidget implements TopBarClickListener {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        id: Constant.idHome,
        builder: (logic) {
          return Scaffold(
            backgroundColor: AppColor.colorTheme,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: AppColor.colorTheme,
              flexibleSpace: TopBar(
                headerTitle: "My Medicine".toUpperCase(),
                // isDrawer: true,
                // clickListener: this,
              ),
            ),
            drawer: const DrawerSheet(),
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
                      child: logic.medicineList!.isNotEmpty
                          ? ListView.builder(
                              padding: EdgeInsets.symmetric(
                                  vertical: AppFontSize.size_16,
                                  horizontal: AppFontSize.size_4),
                              itemCount: logic.medicineList?.length,
                              itemBuilder: (context, index) {
                                return _medicine(logic.medicineList![index]);
                              },
                            )
                          : Center(
                              child: Text(
                              "No Data",
                              style: AppFontStyle.styleW500(
                                  Get.theme.primaryColor, AppFontSize.size_14),
                            ))),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
                backgroundColor: AppColor.colorTheme,
                onPressed: () {
                  Get.toNamed(AppRoutes.add);
                },
                child: Image.asset(
                  AppAsset.icPlus,
                  height: 18,
                )),
          );
        });
  }

  @override
  void onTopBarClick(EnumTopBar name, {bool value = true}) {
    if (name == EnumTopBar.topBarBack) {
      Get.back();
    }
  }
}

_medicine(MedicineTable medicineList) {
  return GetBuilder<HomeController>(
      id: Constant.idMedicineList,
      builder: (logic) {
        Color? otherColor;
        if (medicineList.mColorPhotoType == "shadeColor") {
          Color color = Color(int.parse(medicineList.mColorPhoto!));
          String colorString = color.toString();
          String valueString = colorString.split('(0x')[1].split(')')[0];
          int value = int.parse(valueString, radix: 16);
          otherColor = Color(value);
        }
        return InkWell(
          onTap: () {
            Get.toNamed(AppRoutes.details, arguments: medicineList);
          },
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 10.0,
              right: 10,
              left: 10,
            ),
            child: Container(
              decoration: BoxDecoration(
                  color: Get.context!.theme.cardColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        color: Get.context!.theme.primaryColor.withOpacity(0.1),
                        spreadRadius: 1,
                        offset: const Offset(1.2, 0.5),
                        blurRadius: 4)
                  ]),
              child: Row(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      height: AppSizes.height_8,
                      width: AppSizes.height_8,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: medicineList.mColorPhotoType == "shadeColor"
                              ? Container(
                                  color: otherColor,
                                  width: AppSizes.width_6,
                                  height: AppSizes.width_6,
                                )
                              : Image.file(File(medicineList.mColorPhoto!),
                                  fit: BoxFit.cover,
                                  height: AppSizes.width_7,
                                  width: AppSizes.width_7))),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        medicineList.mName ?? "",
                        style: AppFontStyle.customizeStyle(
                            fontSize: AppFontSize.size_12,
                            fontWeight: FontWeight.w600,
                            color: Get.context!.theme.primaryColor,
                            fontFamily: Constant.fontFamilyPoppins),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      AutoSizeText(
                        medicineList.mDosage?.toUpperCase() ?? "",
                        style: AppFontStyle.customizeStyle(
                            fontSize: AppFontSize.size_10,
                            fontWeight: FontWeight.w400,
                            fontFamily: Constant.fontFamilyPoppins,
                            color: Get.context!.theme.primaryColor),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Image.asset(AppAsset.icRightBlack,
                    color: Get.context!.theme.primaryColor),
                const SizedBox(
                  width: 10,
                )
              ]),
            ),
          ),
        );
      });
}

settingItem({
  Function()? onTap,
  String? text,
  IconData? icon,
  Widget? trailing,
  double? margin,
  double? vPadding,
  double? hPadding,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      color: AppColor.transparent,
      // margin: EdgeInsets.symmetric(vertical: margin ?? AppSizes.height_1),
      padding: EdgeInsets.symmetric(
          vertical: vPadding ?? AppSizes.height_2_5,
          horizontal: hPadding ?? AppSizes.height_2),
      child: Row(
        children: [
          Icon(icon, color: Get.context!.theme.primaryColor),
          SizedBox(
            width: AppFontSize.size_10,
          ),
          Expanded(
              child: Text(
            text!,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: Constant.fontFamilyPoppins,
                color: Get.context!.theme.primaryColor),
          )),
          if (trailing != null) ...{
            trailing,
          }
        ],
      ),
    ),
  );
}

class DrawerSheet extends StatelessWidget {
  const DrawerSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        id: Constant.idDrawerSheet,
        builder: (logic) {
          return SafeArea(
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.only(topRight: Radius.circular(20)),
              child: Drawer(
                backgroundColor: Get.context!.theme.cardColor,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(22.0),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.lightBlue.withOpacity(0.2),
                        ),
                        child: Row(
                          children: [
                            Image.asset(AppAsset.icLogo,
                                width: AppSizes.height_10),
                            Text(
                              'txtAppName'.tr,
                              style: const TextStyle(
                                  color: Colors.blue,
                                  fontSize: 18,
                                  fontFamily: Constant.fontFamilyPoppins,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    settingItem(
                      icon: Icons.home,
                      text: "txtHomepage".tr,
                    ),
                    settingItem(
                      icon: Icons.translate_sharp,
                      text: "txtLanguage".tr,
                    ),
                    settingItem(
                      onTap: () => logic.openThemeDialog(),
                      icon: Icons.brightness_6,
                      text: "txtTheme".tr,
                      trailing: Text(
                        logic.getThemeString(),
                        style: AppFontStyle.styleW600(
                          AppColor.colorTheme,
                          AppFontSize.size_11,
                        ),
                      ),
                    ),
                    settingItem(
                      icon: Icons.feedback_rounded,
                      text: "txtSendFeedback".tr,
                    ),
                    settingItem(
                      icon: Icons.share,
                      text: "txtShare".tr,
                    ),
                    settingItem(
                      icon: Icons.star_border_outlined,
                      text: "txtRateUs".tr,
                    ),
                    Expanded(child: Container()),
                    Padding(
                      padding: const EdgeInsets.all(22.0),
                      child: InkWell(
                        onTap: (){logic.onTapSingOut();},
                        child: Row(
                          children: [
                            Icon(Icons.close,
                                color: Get.context!.theme.primaryColor),
                            Text("txtSingOut".tr,
                                style: TextStyle(
                                    fontSize: AppFontSize.size_12,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: Constant.fontFamilyPoppins,
                                    color: Get.context!.theme.primaryColor)),
                            const Spacer(),
                            Text("txtVersion".tr,
                                style: TextStyle(
                                    fontSize: AppFontSize.size_12,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.txtColor999,
                                    fontFamily: Constant.fontFamilyPoppins))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
