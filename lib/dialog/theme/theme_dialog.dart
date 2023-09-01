import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pills_reminder/ui/home/controller/home_controller.dart';
import 'package:pills_reminder/utils/color.dart';
import 'package:pills_reminder/utils/constant.dart';
import 'package:pills_reminder/utils/font_style.dart';
import 'package:pills_reminder/utils/sizer_utils.dart';

import '../../utils/enums.dart';

class ThemeDialog extends StatelessWidget {
  const ThemeDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runAlignment: WrapAlignment.center,
      children: [
        Container(
          color: AppColor.transparent,
          margin: EdgeInsets.symmetric(horizontal: AppSizes.width_6),
          child: Material(
            borderRadius: BorderRadius.circular(25),
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: AppSizes.height_2, horizontal: AppSizes.width_6),
              decoration: BoxDecoration(
                  color: Get.theme.cardColor,
                  borderRadius: BorderRadius.circular(10)),
              child: GetBuilder<HomeController>(
                id: Constant.idSettingsTheme,
                builder: (logic) {
                  return Column(
                    children: [
                      Text(
                        "txtTheme".tr,
                        style: AppFontStyle.styleW600(
                            AppColor.colorTheme, AppFontSize.size_14),
                      ),
                      SizedBox(height: AppSizes.height_1),
                      _radioButton(
                        logic,
                        "txtLight".tr,
                        AppThemeMode.light.toString(),
                      ),
                      SizedBox(width: AppSizes.width_15),
                      _radioButton(
                        logic,
                        "txtDark".tr,
                        AppThemeMode.dark.toString(),
                      ),
                      SizedBox(height: AppSizes.height_1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Text(
                              "txtCancel".tr.toUpperCase(),
                              style: AppFontStyle.styleW600(
                                  AppColor.colorTheme, AppFontSize.size_12),
                            ),
                          )
                        ],
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        )
      ],
    );
  }

  _radioButton(HomeController logic, String text, String value) {
    return InkWell(
      onTap: () {
        logic.onThemeChanged(value.toString());
      },
      child: Row(
        children: [
          Radio(
            value: value,
            groupValue: logic.theme,
            onChanged: (value) {
              logic.onThemeChanged(value.toString());
            },
            activeColor: AppColor.colorTheme,
          ),
          Text(
            text,
            style: AppFontStyle.styleW500(
                Get.theme.primaryColor, AppFontSize.size_13),
          )
        ],
      ),
    );
  }
}
