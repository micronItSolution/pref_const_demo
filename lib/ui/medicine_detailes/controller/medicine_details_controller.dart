import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pills_reminder/database/tables/medicine_table.dart';

class MedicineDetailsController extends GetxController{
  MedicineTable medicines = Get.arguments;

  List<TimeOfDay> timeList = [];


  List<TimeOfDay> parseTimeList(String data) {
    // Extract time strings from the data string
    final regex = RegExp(r"TimeOfDay\((\d{2}:\d{2})\)");
    final matches = regex.allMatches(data);

    for (Match match in matches) {
      String timeString = match.group(1)!;
      List<String> parts = timeString.split(':');
      int hour = int.parse(parts[0]);
      int minute = int.parse(parts[1]);
      timeList.add(TimeOfDay(hour: hour, minute: minute));
    }

    return timeList;
  }

}