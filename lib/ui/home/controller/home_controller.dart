import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:pills_reminder/database/helper/database_helper.dart';
import 'package:pills_reminder/database/tables/medicine_table.dart';
import 'package:pills_reminder/dialog/sign_out/sign_out_dialog.dart';
import 'package:pills_reminder/dialog/theme/theme_dialog.dart';
import 'package:pills_reminder/main.dart';
import 'package:pills_reminder/routes/app_routes.dart';
import 'package:pills_reminder/ui/sign_in/controller/sign_in_controller.dart';
import 'package:pills_reminder/utils/constant.dart';
import 'package:pills_reminder/utils/enums.dart';
import 'package:pills_reminder/utils/preference.dart';
import 'package:pills_reminder/utils/utils.dart';

class HomeController extends GetxController {
  String theme = AppThemeMode.light.toString();
  bool _notificationsEnabled = false;

  List<MedicineTable>? medicineList = [];
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<void> onInit() async {
    if (isFullScreenNotification && selectedNotificationPayload != null) {
      Get.toNamed(AppRoutes.fullScreenNotification,
          arguments: [selectedNotificationPayload]);
    }
    getCurrentTheme();
    _isAndroidPermissionGranted();
    _requestPermissions();
    _configureDidReceiveLocalNotificationSubject();
    _configureSelectNotificationSubject();
    await DataBaseHelper().getUserData();
    await getDataFromDatabase();
    super.onInit();
  }

  Future<void> _isAndroidPermissionGranted() async {
    if (Platform.isAndroid) {
      final bool granted = await flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()
              ?.areNotificationsEnabled() ??
          false;
      _notificationsEnabled = granted;
    }
  }

  Future<void> _requestPermissions() async {
    if (Platform.isIOS || Platform.isMacOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      final bool? grantedNotificationPermission =
          await androidImplementation?.requestPermission();

      _notificationsEnabled = grantedNotificationPermission ?? false;
    }
  }

  void _configureDidReceiveLocalNotificationSubject() {
    didReceiveLocalNotificationStream.stream
        .listen((ReceivedNotification receivedNotification) async {
      print(
          'onDidReceiveNotificationResponse in Home: ${receivedNotification.id}');
      print(
          'onDidReceiveNotificationResponse in Home: ${receivedNotification.payload}');
      await showDialog(
        context: Get.context!,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: receivedNotification.title != null
              ? Text(receivedNotification.title!)
              : null,
          content: receivedNotification.body != null
              ? Text(receivedNotification.body!)
              : null,
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () async {
                Navigator.of(context, rootNavigator: true).pop();
              },
              child: const Text('Ok'),
            )
          ],
        ),
      );
    });
  }

  void _configureSelectNotificationSubject() {
    selectNotificationStream.stream.listen((String? payload) async {
      ///IN android Notification Tap will get here Second
      print('selectNotificationStream in home: $payload');
      Get.toNamed(AppRoutes.fullScreenNotification, arguments: [payload]);
    });
  }

  @override
  void dispose() {
    // didReceiveLocalNotificationStream.close();
    // selectNotificationStream.close();
    super.dispose();
  }

  onThemeChanged(value) {
    theme = value.toString();
    if (theme == AppThemeMode.light.toString()) {
      Get.changeThemeMode(ThemeMode.light);
      Preference.shared.setAppTheme(Constant.appThemeLight);
    } else {
      Get.changeThemeMode(ThemeMode.dark);
      Preference.shared.setAppTheme(Constant.appThemeDark);
    }
    print(":::::::::::$theme");

    Future.delayed(const Duration(milliseconds: 200), () {
      Get.back();
      update(
          [Constant.idSettingsTheme, Constant.idHome, Constant.idDrawerSheet]);
    });
  }

  openThemeDialog() {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return const ThemeDialog();
      },
    );
  }

  getCurrentTheme() {
    theme = Utils.isLightTheme()
        ? AppThemeMode.light.toString()
        : AppThemeMode.dark.toString();
    update([Constant.idSettingsTheme, Constant.idHome, Constant.idDrawerSheet]);
  }

  singOut(context) async {
    try {
      await _auth.signOut();
      await Get.put<SignInController>(SignInController()).logoutGoogle();
      Get.offAllNamed(AppRoutes.signIn);
      Preference.shared.setIsUserLogin(false);

      Utils.showToast(context, "toastLogOut".tr);
    } catch (e) {
      Utils.showToast(context, e.toString());
    }
  }

  onTapSingOut() {
    Get.dialog(const SignOutDialog(), useSafeArea: false);
  }

  getThemeString() {
    if (theme == AppThemeMode.dark.toString()) {
      return "txtDark".tr;
    } else {
      return "txtLight".tr;
    }
  }

  Future<void> getDataFromDatabase() async {
    medicineList = await DataBaseHelper().getMedicineData();
    print(":: ::: ::: $medicineList");
    update([Constant.idHome]);
  }
}
