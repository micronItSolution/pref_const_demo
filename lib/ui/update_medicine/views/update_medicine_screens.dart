import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pills_reminder/custom/top_bar/topbar.dart';
import 'package:pills_reminder/interfaces/top_bar_click_listener.dart';
import 'package:pills_reminder/ui/update_medicine/controller/update_medicine_controller.dart';
import 'package:pills_reminder/utils/asset.dart';
import 'package:pills_reminder/utils/color.dart';
import 'package:pills_reminder/utils/enums.dart';
import 'package:pills_reminder/utils/font_style.dart';
import 'package:pills_reminder/utils/sizer_utils.dart';

class UpdateMedicineScreens extends StatelessWidget
    implements TopBarClickListener {
  UpdateMedicineScreens({super.key});
  final UpdateMedicineController updateMedicineController =
      Get.find<UpdateMedicineController>();
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
          headerTitle: "txtUpdateMedicine".tr.toUpperCase(),
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
                      _settingItem(
                          icon: AppAsset.icDosage,
                          text: "txtDosage".tr,
                          isShowDefault: true,
                          defaultText: "1 Tablet",
                          defaultIcon: AppAsset.icRightBlack,
                          onTap: () {},
                          isShowBack: true),
                      _divider(),
                      _settingItem(
                          icon: AppAsset.icColor,
                          text: "txtColorOrPhoto".tr,
                          onTap: () {},
                          defaultIcon: AppAsset.icRightBlack,
                          isShowBack: true,
                          defaultText: "txtNone".tr,
                          isShowDefault: true),
                      _divider(),
                      _settingItem(
                          icon: AppAsset.icAlertSound,
                          text: "txtAlertsSound".tr,
                          defaultIcon: AppAsset.icRightBlack,
                          onTap: () {},
                          isShowBack: true,
                          defaultText: "txtDefault".tr,
                          isShowDefault: true),
                      _divider(),
                      _settingItem(
                          icon: AppAsset.icCalender,
                          text: "txtStartDate".tr,
                          onTap: () {},
                          defaultText: "27 Jul,2023",
                          isShowDefault: true),
                      _divider(),
                      _settingItem(
                          icon: AppAsset.icCalender,
                          text: "txtEndDate".tr,
                          onTap: () {},
                          defaultText: "1 Aug ,2023",
                          isShowDefault: true),
                      _divider(),
                      _settingItem(
                          icon: AppAsset.icFrequency,
                          text: "txtFrequency".tr,
                          onTap: () {},
                          defaultText: "txtEveryDay",
                          isShowDefault: true),
                      _divider(),
                      _settingItem(
                          icon: AppAsset.icTime,
                          text: "txtAddTime".tr,
                          defaultIcon: AppAsset.icAdd,
                          onTap: () {},
                          isShowBack: true),
                      _divider(),
                      _settingItem(
                        text: "10:00",
                        isShowBack: true,
                        defaultIcon: AppAsset.icCancelBlack,
                        onTap: () {},
                      ),
                      _settingItem(
                        text: "8:00",
                        isShowBack: true,
                        defaultIcon: AppAsset.icCancelBlack,
                        onTap: () {},
                      ),
                      _divider(),
                      _settingItem(
                          icon: AppAsset.icUserActive,
                          text: "txtUserActive".tr,
                          defaultIcon: AppAsset.icDoneBlack,
                          onTap: () {},
                          isShowBack: true),
                      _divider(),
                      _settingItem(
                          icon: AppAsset.icSuspend,
                          text: "txtSuspend".tr,
                          defaultIcon: AppAsset.icDoneBlack,
                          onTap: () {},
                          isShowBack: false),
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

  _settingItem(
      {String? icon,
      String? text,
      String? defaultText,
      String? defaultIcon,
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
          icon != null
              ? Image.asset(
                  icon,
                  gaplessPlayback: true,
                  height: AppSizes.height_4,
                  color: AppColor.colorTheme,
                )
              : SizedBox(
                  height: AppSizes.height_4,
                  width: AppSizes.height_4,
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
      style: AppFontStyle.styleW500(
          Get.context!.theme.primaryColor, AppFontSize.size_11),
      textAlign: TextAlign.left,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.newline,
      onChanged: (value) {},
      cursorColor: AppColor.colorTheme,
      controller: updateMedicineController.textController,
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
        hintText: "MedicineName".tr,
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

  @override
  void onTopBarClick(EnumTopBar name, {bool value = true}) {
    if (name == EnumTopBar.topBarBack) {
      Get.back();
    }
  }
}
