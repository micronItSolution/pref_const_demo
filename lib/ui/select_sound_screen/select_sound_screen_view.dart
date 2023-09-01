import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pills_reminder/custom/top_bar/topbar.dart';
import 'package:pills_reminder/interfaces/top_bar_click_listener.dart';
import 'package:pills_reminder/utils/color.dart';
import 'package:pills_reminder/utils/constant.dart';
import 'package:pills_reminder/utils/enums.dart';
import 'package:pills_reminder/utils/sizer_utils.dart';

import 'select_sound_screen_logic.dart';

class SelectSoundScreenPage extends StatelessWidget
    implements TopBarClickListener {
  const SelectSoundScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<SelectSoundScreenLogic>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.colorTheme,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.colorTheme,
        automaticallyImplyLeading: false,
        flexibleSpace: TopBar(
          headerTitle: "txtSelectRingtone".tr,
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
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14.0, vertical: 16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      GetBuilder<SelectSoundScreenLogic>(
                          id: Constant.idSelectAlertSound,
                          builder: (logic) {
                            return InkWell(
                              onTap: () async {
                                // Debug.printLog("getLocale Updated");
                                logic.stopRingTone();
                                logic.getRingtones();
                              },
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                margin: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: AppFontSize.size_1,
                                        color: Get.context!.theme.primaryColor
                                            .withOpacity(0.5)),
                                    borderRadius: BorderRadius.circular(12)),
                                child: Row(children: [
                                  if (logic.pickedRingtoneUri != null &&
                                      !logic.isRingPlaying)
                                    InkWell(
                                        onTap: logic.playRingtone,
                                        child: Icon(
                                          Icons.play_arrow,
                                          color:
                                              Get.context!.theme.primaryColor,
                                        )),
                                  if (logic.pickedRingtoneUri != null &&
                                      logic.isRingPlaying)
                                    InkWell(
                                        onTap: logic.stopRingTone,
                                        child: Icon(
                                          Icons.pause,
                                          color:
                                              Get.context!.theme.primaryColor,
                                        )),
                                  if (logic.pickedRingtoneUri == null &&
                                      !logic.isRingPlaying)
                                    Icon(
                                      Icons.file_open,
                                      color: Get.context!.theme.primaryColor,
                                    ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(logic.pickedRingtoneTitle),
                                ]),
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
                            margin: EdgeInsets.only(right: AppSizes.width_1),
                          ),
                          Text("txtOr".tr),
                          Container(
                              height: AppSizes.height_0_3,
                              width: AppSizes.fullWidth / 3,
                              color: AppColor.darkGreen,
                              margin: EdgeInsets.only(left: AppSizes.width_1)),
                        ],
                      ),
                      buildSoundList()
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
    if (name == EnumTopBar.topBarSave) {
      Get.find<SelectSoundScreenLogic>().saveSound();
    }
    if (name == EnumTopBar.topBarBack) {
      Get.back();
    }
  }

  static Widget buildSoundList() {
    return GetBuilder<SelectSoundScreenLogic>(
        id: Constant.idListOfSounds,
        builder: (logic) {
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: Constant.soundList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return CheckboxListTile(
                title: Text(Constant.soundList[index]),
                value: logic.selectedSoundList[index],
                onChanged: (value) {
                  logic.changeSelectedRing(index: index, value: value!);
                  // Call a method or perform any action when a sound is selected
                  // For example: updateSelectedSound(soundList[index]);
                },
              );
            },
          );
        });
  }
}
