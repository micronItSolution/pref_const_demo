import 'package:get/get.dart';
import 'package:pills_reminder/database/tables/notification_table.dart';
import 'package:pills_reminder/main.dart';
import 'package:pills_reminder/notification/notification_helper.dart';
import 'package:timezone/timezone.dart' as tz;

class FullScreenNotificationLogic extends GetxController {
  var data = Get.arguments;

  String payload = '';
  NotificationTable? notificationTable;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (data != null) {
      payload = data[0];
      notificationTable = NotificationTable.fromRawJson(payload);
      // print('notificationTable: ${notificationTable?.toJson().toString()}');
      update();
    }
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  Future<void> scheduleNotification() async {
    if (notificationTable == null) {
      return;
    }
    print('notificationTable: ${notificationTable?.toJson().toString()}');
    int notificationId = notificationTable!.nId!;
    await flutterLocalNotificationsPlugin.cancel(--notificationId);

    final DateTime nNotificationTime =
        DateTime.parse(notificationTable!.nNotificationTime!);
    print('nNotificationTime: ${nNotificationTime.toString()}');
    tz.TZDateTime scheduledDate = tz.TZDateTime(
        tz.local,
        nNotificationTime.year,
        nNotificationTime.month,
        nNotificationTime.day,
        nNotificationTime.hour,
        nNotificationTime.minute + 5);
    print('scheduledDate: ${scheduledDate.toString()}');
    DateTime notificationTime = NotificationHelper().getDateTimeFromTZDateTime(scheduledDate);
    notificationTable!.nNotificationTime = notificationTime.toIso8601String();

    await NotificationHelper().scheduleNotification(
        result: notificationTable!.nId!,
        currentNotificationDateTime: scheduledDate,
        notificationPayload: notificationTable!.toRawJson(),
        notificationTable: notificationTable!);
  }
}
