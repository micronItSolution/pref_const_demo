import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pills_reminder/custom/top_bar/topbar.dart';
import 'package:pills_reminder/interfaces/top_bar_click_listener.dart';
import 'package:pills_reminder/utils/color.dart';
import 'package:pills_reminder/utils/enums.dart';
import 'package:pills_reminder/utils/sizer_utils.dart';

import '../controller/full_screen_notification_logic.dart';

class FullScreenNotificationPage extends StatelessWidget
    implements TopBarClickListener {
  const FullScreenNotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<FullScreenNotificationLogic>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.colorTheme,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.colorTheme,
        automaticallyImplyLeading: false,
        flexibleSpace: TopBar(
          headerTitle: "txtTakeYourMedicine".tr,
          isShowBack: true,
          isShowSave: false,
          clickListener: this,
        ),
      ),
      body: Center(
        child: GetBuilder<FullScreenNotificationLogic>(builder: (logic) {
          return Container(
            height: AppSizes.height_88,
            width: AppSizes.fullWidth,
            padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 16),
            decoration: BoxDecoration(
                color: Get.theme.colorScheme.background,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('payload ${logic.payload ?? ''}'),
                ElevatedButton(
                  onPressed: () {},
                  child:  Text("txtTaken".tr),
                ),
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
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.blue, // background (button) color
                    foregroundColor: Colors.white, // foreground (text) color
                  ),
                  onPressed: () {
                    logic.scheduleNotification();
                  },
                  child:  Text("txtSnoozeFiveMinutes".tr),
                ),
              ],
            ),
          );
        }),
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
