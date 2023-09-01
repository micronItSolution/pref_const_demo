import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pills_reminder/custom/top_bar/topbar.dart';
import 'package:pills_reminder/interfaces/top_bar_click_listener.dart';
import 'package:pills_reminder/utils/color.dart';
import 'package:pills_reminder/utils/constant.dart';
import 'package:pills_reminder/utils/debug.dart';
import 'package:pills_reminder/utils/enums.dart';
import 'package:pills_reminder/utils/sizer_utils.dart';

import 'select_color_logic.dart';

class SelectColorPage extends StatelessWidget implements TopBarClickListener {
  const SelectColorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<SelectColorLogic>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.colorTheme,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.colorTheme,
        automaticallyImplyLeading: false,
        flexibleSpace: TopBar(
          headerTitle: "txtSelectImageOrColor".tr,
          isShowBack: true,
          isShowSave: true,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      GetBuilder<SelectColorLogic>(
                          id: Constant.idSelectedImage,
                          builder: (logic) {
                        return InkWell(
                          onTap: () async {
                            // Debug.printLog("getLocale Updated");
                            logic.pickImageFromGallery();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            margin: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                border:
                                Border.all(width: AppFontSize.size_1,color: Get.context!.theme.primaryColor),
                                borderRadius: BorderRadius.circular(12)),
                            child: logic.croppedFile == null
                                ? Row(children: [
                              const Icon(Icons.camera_alt),
                              const SizedBox(
                                width: 10,
                              ),
                              Text("txtTakeImage".tr),
                            ])
                                : logic.croppedFile == null
                                ? Container()
                                : Image.file(File(logic.croppedFile!.path)),
                          ),
                        );
                      }),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: AppSizes.fullWidth / 3,
                            height: AppSizes.height_0_3,
                            color: AppColor.darkGreen,
                            margin:
                            EdgeInsets.only(right: AppSizes.width_1),
                          ),
                          Text("txtOr".tr),
                          Container(
                              height: AppSizes.height_0_3,
                              width: AppSizes.fullWidth / 3,
                              color: AppColor.darkGreen,
                              margin: EdgeInsets.only(
                                  left: AppSizes.width_1)),
                        ],
                      ),
                      InkWell(
                        onTap: () async {
                          // Debug.printLog("getLocale Updated");
                          // logic.pickImageFromGallery();
                          openColorPicker();
                        },
                        child: Container(
                            padding: const EdgeInsets.all(12),
                            margin: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                border:
                                Border.all(width: AppFontSize.size_1,color:Get.context!.theme.primaryColor),
                                borderRadius: BorderRadius.circular(12)),
                            child: Row(children: [
                              GetBuilder<SelectColorLogic>(
                                  id: Constant.idSelectedColor,
                                  builder: (logic) {
                                    return Container(
                                      color: logic.shadeColor,
                                      width: AppSizes.width_6,
                                      height: AppSizes.width_6,
                                    );
                                  }),
                              const SizedBox(
                                width: 10,
                              ),
                              Text("txtSelectColour".tr),
                            ])),
                      ),
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

  void _openDialog(String title, Widget content) {
    showDialog(
      context: Get.context!,
      builder: (_) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(18.0),
          title: Text(title),
          content: content,
          actions: [
            TextButton(
              onPressed:() => Get.back(),
              child: Text('txtCANCEL'.tr),
            ),
            TextButton(
              onPressed: () {
                Get.back();
                Get.find<SelectColorLogic>().updateColor();
              },
              child: Text('txtSUBMIT'.tr),
            ),
          ],
        );
      },
    );
  }

  void openColorPicker() async {
    _openDialog(
      "txtColorPicker".tr,
      MaterialColorPicker(
        selectedColor: Get.find<SelectColorLogic>().shadeColor,
        onColorChange: (color) =>
            Get.find<SelectColorLogic>().tempShadeColor = color,
        onMainColorChange: (color) =>
            Get.find<SelectColorLogic>().tempMainColor = color,
        onBack: () => print("BackButtonPressed"),
      ),
    );
  }

  @override
  void onTopBarClick(EnumTopBar name, {bool value = true}) {
    if (name == EnumTopBar.topBarSave) {
      Map<String, dynamic> map = {
        Constant.idImageArg: Get
            .find<SelectColorLogic>()
            .croppedFile,
        Constant.idColorArg: Get
            .find<SelectColorLogic>()
            .shadeColor,
      };
      Get.back(result: map);
    }
  }
}
