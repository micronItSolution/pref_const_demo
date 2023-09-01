import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pills_reminder/ui/add_medicine/controller/add_medicine_controller.dart';
import 'package:pills_reminder/ui/home/controller/home_controller.dart';

import '../../utils/asset.dart';
import '../../utils/color.dart';
import '../../utils/font_style.dart';
import '../../utils/sizer_utils.dart';

class SignOutDialog extends StatefulWidget {
  const SignOutDialog({Key? key}) : super(key: key);

  @override
  State<SignOutDialog> createState() => _SignOutDialogDialogState();
}

class _SignOutDialogDialogState extends State<SignOutDialog> {

  final HomeController homeController = Get.find<HomeController>();

  _dialogWidget() {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColor.colorTransparent,
          body: Center(
            child: Wrap(
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Container(
                  width: AppSizes.fullWidth,
                  margin: EdgeInsets.symmetric(horizontal: AppSizes.width_5),
                  padding: EdgeInsets.symmetric(vertical: AppSizes.height_2, horizontal: AppSizes.width_5),
                  decoration: BoxDecoration(
                    color: Get.theme.cardColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Material(
                    color: Get.theme.cardColor,
                    child: Column(
                      children: [
                        Text( "txtLogOut".tr , maxLines: 2, textAlign: TextAlign.center, style: AppFontStyle.styleW700(Get.theme.primaryColor, AppFontSize.size_16)),
                        SizedBox(height: AppSizes.height_3),
                        Text( "txtLogOutDesc".tr , maxLines: 2, textAlign: TextAlign.center, style: AppFontStyle.styleW500(Get.theme.primaryColor, AppFontSize.size_11)),
                        SizedBox(height: AppSizes.height_4),
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: Container(
                                  width: AppSizes.fullWidth,
                                  padding: EdgeInsets.symmetric(vertical: AppSizes.height_1),
                                  decoration: BoxDecoration(
                                    color: Get.theme.cardColor,
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(color: AppColor.colorTheme),
                                  ),
                                  child: Text(
                                    "txtCancel".tr.toUpperCase(),
                                    textAlign: TextAlign.center,
                                    style: AppFontStyle.styleW500(AppColor.colorTheme, AppFontSize.size_13),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: AppSizes.width_3),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  homeController.singOut(context);
                                },
                                child: Container(
                                  width: AppSizes.fullWidth,
                                  padding: EdgeInsets.symmetric(vertical: AppSizes.height_1),
                                  decoration: BoxDecoration(
                                    color: AppColor.colorTheme,
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(color: AppColor.colorTransparent),
                                  ),
                                  child: Text(
                                    "txtOk".tr.toUpperCase(),
                                    textAlign: TextAlign.center,
                                    style: AppFontStyle.styleW500(Get.theme.cardColor, AppFontSize.size_13),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _dialogWidget();
  }

  @override
  void initState() {
    super.initState();
  }
}