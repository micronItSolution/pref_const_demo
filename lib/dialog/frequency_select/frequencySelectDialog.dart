import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pills_reminder/ui/add_medicine/controller/add_medicine_controller.dart';
import 'package:pills_reminder/utils/color.dart';
import 'package:pills_reminder/utils/constant.dart';
import 'package:pills_reminder/utils/font_style.dart';
import 'package:pills_reminder/utils/sizer_utils.dart';

class FrequencySelectDialog extends StatelessWidget {
  const FrequencySelectDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return _dialogWidget();
  }

  _dialogWidget() {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColor.transparent,
          body: Center(
            child: Wrap(
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Container(
                  width: AppSizes.fullWidth,
                  margin: EdgeInsets.symmetric(horizontal: AppSizes.width_5),
                  padding: EdgeInsets.symmetric(
                      vertical: AppSizes.height_2,
                      horizontal: AppSizes.width_5),
                  decoration: BoxDecoration(
                    color: Get.theme.cardColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Material(
                    color: Get.theme.cardColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "txtAddFrequency".tr,
                          style: AppFontStyle.customizeStyle(
                            color: Get.context!.theme.primaryColor,
                            fontSize: AppFontSize.size_13,
                            fontFamily: Constant.fontFamilyPoppins,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: AppSizes.height_2,
                        ),
                        GetBuilder<AddMedicineController>(
                            id: Constant.idSelectEveryDay,
                            builder: (logic) {
                              return CheckboxListTile(
                                title: Text('Every Day',
                                    style: TextStyle(
                                        color: Get.context!.theme.primaryColor,
                                        fontFamily:
                                            Constant.fontFamilyPoppins)),
                                value: logic.selectedEverydayFrequency,
                                onChanged: (value) {
                                  logic.changeSelectEveryDay(value: value!);

                                  // Call a method or perform any action when a sound is selected
                                  // For example: update54SelectedSound(soundList[index]);
                                },
                              );
                            }),
                        SizedBox(
                          height: AppFontSize.size_8_5,
                        ),
                        Text(
                          "txtSelectSpecific".tr,
                          style: AppFontStyle.customizeStyle(
                              color: Get.context!.theme.primaryColor,
                              fontSize: AppFontSize.size_13,
                              fontFamily: Constant.fontFamilyPoppins,
                              fontWeight: FontWeight.bold),
                        ),
                        // _textTextField(),
                        buildWeekDaysList(),
                        SizedBox(
                          height: AppFontSize.size_8_5,
                        ),
                        InkWell(
                          onTap: () {
                            Get.find<AddMedicineController>().updateFrequency();
                            Get.back();
                            // addMedicineController.update([Constant.idDosageSelect]);
                          },
                          child: Container(
                              width: AppSizes.width_90,
                              height: AppSizes.height_6,
                              decoration: BoxDecoration(
                                  color: AppColor.colorTheme,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                  child: Text(
                                "txtDone",
                                style: AppFontStyle.customizeStyle(
                                    fontSize: AppFontSize.size_14,
                                    color: AppColor.white,
                                    fontWeight: FontWeight.bold),
                              ))),
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

  static Widget buildWeekDaysList() {
    return GetBuilder<AddMedicineController>(
        id: Constant.idSelectSpecificDay,
        builder: (logic) {
          return ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: Constant.weekDaysList.length,
            itemBuilder: (context, index) {
              return CheckboxListTile(
                title: Text(Constant.weekDaysList[index],
                    style: TextStyle(
                        fontFamily: Constant.fontFamilyPoppins,
                        color: Get.context!.theme.primaryColor)),
                value: logic.selectedWeekDaysList[index],
                onChanged: (value) {
                  logic.selectSpecificDay(index: index, value: value!);
                },
              );
            },
          );
        });
  }
}
