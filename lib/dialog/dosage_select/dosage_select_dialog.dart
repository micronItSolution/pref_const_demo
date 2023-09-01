import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pills_reminder/ui/add_medicine/controller/add_medicine_controller.dart';
import 'package:pills_reminder/utils/color.dart';
import 'package:pills_reminder/utils/constant.dart';
import 'package:pills_reminder/utils/font_style.dart';
import 'package:pills_reminder/utils/sizer_utils.dart';
import 'package:pills_reminder/utils/utils.dart';

class DosageSelectDialog extends StatefulWidget {
  const DosageSelectDialog({Key? key}) : super(key: key);

  @override
  State<DosageSelectDialog> createState() => _DosageSelectDialogState();
}

class _DosageSelectDialogState extends State<DosageSelectDialog> {
  final AddMedicineController addMedicineController =
  Get.find<AddMedicineController>();

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
                          "Add Dosage".toUpperCase(),
                          style: AppFontStyle.customizeStyle(
                              color: Get.theme.primaryColor,
                              fontSize: AppFontSize.size_13,
                              fontFamily: Constant.fontFamilyPoppins,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: AppSizes.height_2,
                        ),
                        Text("Dosage",
                            style: AppFontStyle.styleW500(
                                Get.theme.primaryColor, AppFontSize.size_11_5)),
                        SizedBox(
                          height: AppFontSize.size_8_5,
                        ),
                        _textTextField(),
                        SizedBox(
                          height: AppSizes.height_2,
                        ),
                        Text("Units",
                            style: AppFontStyle.styleW500(
                                Get.theme.primaryColor, AppFontSize.size_11_5)),
                        SizedBox(
                          height: AppFontSize.size_8_5,
                        ),
                        _textUntilField(),
                        SizedBox(
                          height: AppFontSize.size_14,
                        ),
                        InkWell(
                          onTap: (){
                            Get.back();
                            addMedicineController.update([Constant.idDosageSelect]);

                          },
                          child: Container(
                              width: AppSizes.width_90,
                              height: AppSizes.height_6,
                              decoration: BoxDecoration(
                                  color: AppColor.colorTheme,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                  child: Text(
                                    "Done",
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

  @override
  Widget build(BuildContext context) {
    return _dialogWidget();
  }


  _textTextField() {
    return TextFormField(
      style: AppFontStyle.styleW500(
          Get.context!.theme.primaryColor, AppFontSize.size_11),
      textAlign: TextAlign.left,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.newline,
      onChanged: (value) {},
      cursorColor: AppColor.colorTheme,
      controller: addMedicineController.dosageController,
      maxLines: 1,
      decoration: InputDecoration(
        filled: false,
        contentPadding: EdgeInsets.symmetric(
            horizontal: AppSizes.width_4, vertical: AppSizes.height_1),
        hintText: "Dosage".tr,
        hintStyle:
        AppFontStyle.styleW500(Get.theme.primaryColor.withOpacity(0.5), AppFontSize.size_12),
        border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColor.colorTheme,
            )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColor.colorTheme.withOpacity(0.3),
            )),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColor.colorTheme.withOpacity(0.3),
            )),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColor.colorTheme.withOpacity(0.3),
            )),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColor.colorTheme.withOpacity(0.3),
            )),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColor.colorTheme.withOpacity(0.3),
            )),
      ),
    );
  }

  _textUntilField() {
    return GetBuilder<AddMedicineController>(
      id : Constant.idSelectedDosage,
        builder: (logic) {
      return FormField<String>(
        builder: (FormFieldState<String> state) {
          return InputDecorator(
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(8),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0))),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                hint:  Text(
                  logic.isEdit ? logic.dosageChoose : Constant.dosageDataList.first,
                  style: TextStyle(
                    color: Get.theme.primaryColor.withOpacity(0.7
                    ),
                    fontSize: 16,

                  ),
                ),
                items: Constant.dosageDataList
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value,style:TextStyle( color: Get.theme.primaryColor.withOpacity(0.7
                    ),) ),
                  );
                }).toList(),
                borderRadius: BorderRadius.circular(12),
                menuMaxHeight: AppSizes.height_40,
                onChanged: (String? newSelectedBank) {
                  logic.onDropDownItemSelected(newSelectedBank!);
                },
                value: logic.dosageChoose,
              ),
            ),
          );
        },
      );
    });
  }


}
