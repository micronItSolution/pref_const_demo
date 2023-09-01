import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pills_reminder/database/helper/database_helper.dart';
import 'package:pills_reminder/database/helper/firestore_helper.dart';
import 'package:pills_reminder/database/tables/medicine_table.dart';
import 'package:pills_reminder/main.dart';
import 'package:pills_reminder/ui/add_medicine/controller/add_medicine_controller.dart';
import 'package:pills_reminder/utils/debug.dart';

import 'package:timezone/timezone.dart' as tz;

import '../database/tables/notification_table.dart';

class NotificationHelper {
  static final NotificationHelper instance = NotificationHelper.internal();

  factory NotificationHelper() => instance;

  NotificationHelper.internal();

  Future<void> scheduleDailyNotification(
      {List<NotificationTable>? notification,
      required MedicineTable medicineTable}) async {
    if (medicineTable.mFrequencyType == 'Every day') {
      final DateTime startDate = DateTime.parse(medicineTable.mStartDate!);
      final DateTime endDate = DateTime.parse(medicineTable.mEndDate!);
      List<TimeOfDay> timeList = parseTimeList(medicineTable.mTime!);

      for (TimeOfDay notificationTime in timeList) {
        final tz.TZDateTime initialNotificationDateTime = tz.TZDateTime(
          tz.local,
          startDate.year,
          startDate.month,
          startDate.day,
          notificationTime.hour,
          notificationTime.minute,
        );

        tz.TZDateTime currentNotificationDateTime = initialNotificationDateTime;
        while (currentNotificationDateTime.isBefore(endDate)) {
          print(
              'Scheduling notification for: weekday ${currentNotificationDateTime.toLocal().weekday}');
          print(
              'Scheduling notification for: ${currentNotificationDateTime.toLocal()}');
          Get.put<AddMedicineController>(AddMedicineController()).isEdit
              ? await updateAndScheduleNotification(
                  currentNotificationDateTime: currentNotificationDateTime,
                  medicineTable: medicineTable,
                  notificationData: notification)
              : await addAndScheduleNotification(
                  currentNotificationDateTime: currentNotificationDateTime,
                  medicineTable: medicineTable);
          currentNotificationDateTime =
              currentNotificationDateTime.add(const Duration(days: 1));
        }
        print(
            'Scheduling notification for: ${currentNotificationDateTime.toLocal()}');
        Get.put<AddMedicineController>(AddMedicineController()).isEdit
            ? await updateAndScheduleNotification(
                currentNotificationDateTime: currentNotificationDateTime,
                medicineTable: medicineTable,
                notificationData: notification)
            : await addAndScheduleNotification(
                currentNotificationDateTime: currentNotificationDateTime,
                medicineTable: medicineTable);
      }
    } else {
      final DateTime startDate = DateTime.parse(medicineTable.mStartDate!);
      final DateTime endDate = DateTime.parse(medicineTable.mEndDate!);
      List<TimeOfDay> timeList = parseTimeList(medicineTable.mTime!);
      for (TimeOfDay notificationTime in timeList) {
        final tz.TZDateTime initialNotificationDateTime = tz.TZDateTime(
          tz.local,
          startDate.year,
          startDate.month,
          startDate.day,
          notificationTime.hour,
          notificationTime.minute,
        );

        tz.TZDateTime currentNotificationDateTime = initialNotificationDateTime;
        while (currentNotificationDateTime.isBefore(endDate)) {
          List<int> intList =
              List<int>.from(json.decode(medicineTable.mDayOfWeek!));
          if (intList.contains(currentNotificationDateTime.toLocal().weekday)) {
            print(
                'Scheduling notification for: weekday ${currentNotificationDateTime.toLocal().weekday}');
            print(
                'Scheduling notification for: ${currentNotificationDateTime.toLocal()}');
            Get.put<AddMedicineController>(AddMedicineController()).isEdit
                ? await updateAndScheduleNotification(
                    currentNotificationDateTime: currentNotificationDateTime,
                    medicineTable: medicineTable,
                    notificationData: notification)
                : await addAndScheduleNotification(
                    currentNotificationDateTime: currentNotificationDateTime,
                    medicineTable: medicineTable);
          }
          currentNotificationDateTime =
              currentNotificationDateTime.add(const Duration(days: 1));
        }
        if (currentNotificationDateTime.day == endDate.day) {
          List<int> intList =
              List<int>.from(json.decode(medicineTable.mDayOfWeek!));
          if (intList.contains(currentNotificationDateTime.toLocal().weekday)) {
            Get.put<AddMedicineController>(AddMedicineController()).isEdit
                ? await updateAndScheduleNotification(
                    currentNotificationDateTime: currentNotificationDateTime,
                    medicineTable: medicineTable,
                    notificationData: notification)
                : await addAndScheduleNotification(
                    currentNotificationDateTime: currentNotificationDateTime,
                    medicineTable: medicineTable);
          }
        }
      }
    }
    _checkPendingNotificationRequests();
  }

  Future<void> _checkPendingNotificationRequests() async {
    final List<PendingNotificationRequest> pendingNotificationRequests =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    for (var element in pendingNotificationRequests) {
      Debug.printLog(
          "_getPendingNotification===>> ${element.id} ${element.body} ${element.title} NotificationDateTime : ${element.payload}");
    }

    return showDialog<void>(
      context: Get.context!,
      builder: (BuildContext context) => AlertDialog(
        content:
            Text('${pendingNotificationRequests.length} pending notification '
                'requests'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  tz.TZDateTime nextInstanceOfTime() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
        tz.local, now.year, now.month, now.day, now.hour, now.minute + 1, 30);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  TimeOfDay stringToTimeOfDay(String tod) {
    final format = DateFormat.jm(); //"6:00 AM"
    return TimeOfDay.fromDateTime(format.parse(tod));
  }

  List<TimeOfDay> parseTimeList(String data) {
    // Extract time strings from the data string
    final regex = RegExp(r"TimeOfDay\((\d{2}:\d{2})\)");
    final matches = regex.allMatches(data);

    List<TimeOfDay> timeList = [];
    for (Match match in matches) {
      String timeString = match.group(1)!; // Extract matched time string
      List<String> parts = timeString.split(':');
      int hour = int.parse(parts[0]);
      int minute = int.parse(parts[1]);
      timeList.add(TimeOfDay(hour: hour, minute: minute));
    }

    return timeList;
  }

  Future<void> addAndScheduleNotification(
      {required tz.TZDateTime currentNotificationDateTime,
      required MedicineTable medicineTable}) async {
    DateTime notificationTime =
        getDateTimeFromTZDateTime(currentNotificationDateTime);
    NotificationTable notificationTable = NotificationTable(
        nId: null,
        notificationMid: medicineTable.mId,
        nCurrentTime: DateTime.now().toIso8601String(),
        nName: medicineTable.mName,
        nDosage: medicineTable.mDosage,
        nColorPhotoType: medicineTable.mColorPhotoType,
        nColorPhoto: medicineTable.mColorPhoto.toString(),
        nSoundType: medicineTable.mSoundType.toString(),
        nStartDate: medicineTable.mStartDate != null ? "image" : "shadeColor",
        nEndDate: medicineTable.mEndDate,
        nFrequencyType: medicineTable.mFrequencyType,
        nDayOfWeek: medicineTable.mDayOfWeek,
        nTime: medicineTable.mTime,
        nIsActive: medicineTable.mIsActive,
        nNotificationTime: notificationTime.toIso8601String(),
        nDeviceSoundUri: medicineTable.mDeviceSoundUri,
        nIsFromDevice: medicineTable.mIsFromDevice);
    var result =
        await DataBaseHelper().insertOrUpdateNotificationData(notificationTable);
    notificationTable.nId = result;

    /// for Firebase
    FireStoreHelper().addAndUpdateNotification(result, notificationTable);
    String notificationPayload = notificationTable.toRawJson();
    print('notificationPayload: $notificationPayload');
    await scheduleNotification(
        result: result,
        currentNotificationDateTime: currentNotificationDateTime,
        medicineTable: medicineTable,
        notificationPayload: notificationPayload);
  }

  Future<void> updateAndScheduleNotification(
      {required tz.TZDateTime currentNotificationDateTime,
      required MedicineTable medicineTable,
      List<NotificationTable>? notificationData}) async {
    DateTime notificationTime =
        getDateTimeFromTZDateTime(currentNotificationDateTime);

    for (var notificationTables in notificationData!) {
      NotificationTable notificationTable = NotificationTable(
          nId: notificationTables.nId,
          notificationMid: medicineTable.mId,
          nCurrentTime: DateTime.now().toIso8601String(),
          nName: medicineTable.mName,
          nDosage: medicineTable.mDosage,
          nColorPhotoType: medicineTable.mColorPhotoType,
          nColorPhoto: medicineTable.mColorPhoto.toString(),
          nSoundType: medicineTable.mSoundType.toString(),
          nStartDate: medicineTable.mStartDate != null ? "image" : "shadeColor",
          nEndDate: medicineTable.mEndDate,
          nFrequencyType: medicineTable.mFrequencyType,
          nDayOfWeek: medicineTable.mDayOfWeek,
          nTime: medicineTable.mTime,
          nIsActive: medicineTable.mIsActive,
          nNotificationTime: notificationTime.toIso8601String(),
          nDeviceSoundUri: medicineTable.mDeviceSoundUri,
          nIsFromDevice: medicineTable.mIsFromDevice);

      await DataBaseHelper()
          .updateNotificationData(notificationTables.nId!, notificationTable);

      FireStoreHelper()
          .addAndUpdateNotification(notificationTables.nId!, notificationTable);
      String notificationPayload = notificationTable.toRawJson();
      print('notificationPayload: $notificationPayload');
      await scheduleNotification(
          result: notificationTables.nId!,
          currentNotificationDateTime: currentNotificationDateTime,
          medicineTable: medicineTable,
          notificationPayload: notificationPayload);
    }
  }

  Future<void> scheduleNotification({
    required int result,
    required tz.TZDateTime currentNotificationDateTime,
    MedicineTable? medicineTable,
    NotificationTable? notificationTable,
    required String notificationPayload,
  }) async {
    print('notificationPayload scheduleNotification: $notificationPayload');
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'daily_notification_channel_id',
      'Daily Notification Channel',
      channelDescription: 'Daily Notification Description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      fullScreenIntent: true,
      actions: <AndroidNotificationAction>[
        AndroidNotificationAction(
          urlLaunchActionId,
          'Action 1',
          icon: DrawableResourceAndroidBitmap('food'),
          contextual: true,
        ),
        AndroidNotificationAction(
          'id_2',
          'Action 2',
          titleColor: Color.fromARGB(255, 255, 0, 0),
          // icon: DrawableResourceAndroidBitmap('secondary_icon'),
        ),
        AndroidNotificationAction(
          navigationActionId,
          'Action 3',
          icon: DrawableResourceAndroidBitmap('secondary_icon'),
          showsUserInterface: true,
          // By default, Android plugin will dismiss the notification when the
          // user tapped on a action (this mimics the behavior on iOS).
          cancelNotification: false,
        ),
      ],
    );

    const DarwinNotificationDetails iosNotificationDetails =
        DarwinNotificationDetails(
      categoryIdentifier: darwinNotificationCategoryPlain,
    );
    await flutterLocalNotificationsPlugin.zonedSchedule(
      result,
      medicineTable != null
          ? medicineTable.mName
          : notificationTable?.nName ?? '',
      medicineTable != null
          ? medicineTable.mDosage
          : notificationTable?.nDosage ?? '',
      currentNotificationDateTime,
      const NotificationDetails(
          android: androidNotificationDetails, iOS: iosNotificationDetails),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: notificationPayload,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );
  }

  DateTime getDateTimeFromTZDateTime(
      [tz.TZDateTime? currentNotificationDateTime]) {
    DateTime dateTime = DateTime(
      currentNotificationDateTime!.year,
      currentNotificationDateTime.month,
      currentNotificationDateTime.day,
      currentNotificationDateTime.hour,
      currentNotificationDateTime.minute,
    );
    return dateTime;
  }
}
