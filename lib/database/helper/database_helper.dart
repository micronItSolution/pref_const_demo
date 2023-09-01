import 'package:flutter/services.dart';

import 'package:path/path.dart' as path;
import 'package:pills_reminder/database/tables/medicine_table.dart';
import 'package:pills_reminder/database/tables/notification_table.dart';
import 'package:pills_reminder/database/tables/user_table.dart';
import 'package:pills_reminder/utils/debug.dart';
import 'dart:io' as io;

import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  static final DataBaseHelper instance = DataBaseHelper.internal();

  factory DataBaseHelper() => instance;

  Database? _db;

  DataBaseHelper.internal();

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await init();
    return _db!;
  }

  init() async {
    var dbPath = await getDatabasesPath();

    String dbPathPillReminder = path.join(dbPath, "PillReminder.db");

    bool dbExistsEnliven = await io.File(dbPathPillReminder).exists();

    if (!dbExistsEnliven) {
      ByteData data = await rootBundle
          .load(path.join("assets/database", "PillReminder.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await io.File(dbPathPillReminder).writeAsBytes(bytes, flush: true);
    }

    return _db = await openDatabase(dbPathPillReminder);
  }

  String medicineTable = "MedicineTable";
  String notificationTable = "NotificationTable";
  String userTable = "UserTable";
  String mId = "mId";
  String notificationMid = "notificationMid";
  String nId = "nId";

  Future<int> insertUser(UserTable userData) async {
    var dbClient = await db;

    var result = await dbClient.insert(userTable, userData.toJson());

    Debug.printLog("insert UserData res: $result");
    return result;
  }

  Future<List<UserTable>> getUserData() async {
    var dbClient = await db;
    List<UserTable> userDataList = [];
    List<Map<String, dynamic>> maps =
        await dbClient.rawQuery("SELECT * FROM $notificationTable");
    if (maps.isNotEmpty) {
      for (var answer in maps) {
        var userData = UserTable.fromJson(answer);
        userDataList.add(userData);
      }
    }
    return userDataList;
  }

  Future<int> insertMedicineData(MedicineTable medicineData) async {
    var dbClient = await db;

    var result = await dbClient.insert(medicineTable, medicineData.toJson());

    Debug.printLog("insert MedicineData res: $result");
    return result;
  }

  Future<int> insertOrUpdateMedicineData(MedicineTable medicineData) async {
    var dbClient = await db;

    var result = await dbClient.insert(
      medicineTable,
      medicineData.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    if (result == 0) {
      // The row already exists, so we need to update it.
      var updateResult = await dbClient.update(
        medicineTable,
        medicineData.toJson(),
        where: "$mId = ?",
        whereArgs: [medicineData.mId],
      );
      return updateResult;
    } else {
      return result;
    }
  }
  Future<int> insertOrUpdateNotificationData(NotificationTable notificationData) async {
    var dbClient = await db;

    var result = await dbClient.insert(
      notificationTable,
      notificationData.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    if (result == 0) {
      // The row already exists, so we need to update it.
      var updateResult = await dbClient.update(
        medicineTable,
        notificationData.toJson(),
        where: "$nId = ?",
        whereArgs: [notificationData.nId],
      );
      return updateResult;
    } else {
      return result;
    }
  }

  Future<List<MedicineTable>> getMedicineData({int? result}) async {
    var dbClient = await db;
    List<MedicineTable> medicineDataList = [];
    List<Map<String, dynamic>> maps = result != null
        ? await dbClient.query(medicineTable,
            where: "$mId = ?", whereArgs: [result], limit: 1)
        : await dbClient.query(medicineTable);
    if (maps.isNotEmpty) {
      for (var answer in maps) {
        var medicineData = MedicineTable.fromJson(answer);
        medicineDataList.add(medicineData);
      }
    }
    return medicineDataList;
  }

  Future<int?> updateMedicineData(int id, MedicineTable medicineData) async {
    var dbClient = await db;
    var result = await dbClient.update(
      medicineTable,
      medicineData.toJson(),
      where: "$mId = ?",
      whereArgs: [id],
    );
    Debug.printLog("updateMedicineData result: $result");
    return result;
  }
  Future<int?> updateNotificationData(
      int id, NotificationTable notificationData) async {
    var dbClient = await db;
    var result = await dbClient.update(
      notificationTable,
      notificationData.toJson(),
      where: "$nId = ?",
      whereArgs: [id],
    );

    Debug.printLog("updateMedicineData result: $result");
    return result;
  }

  Future<int?> deleteMedicineData(int id) async {
    var dbClient = await db;
    var result = await dbClient
        .delete(medicineTable, where: "$mId = ?", whereArgs: [id]);

    Debug.printLog("deleteReminder -->>$result");
    return result;
  }

  Future<int?> deleteNotificationData(int id) async {
    var dbClient = await db;
    var result = await dbClient.delete(notificationTable,
        where: "$notificationMid = ?", whereArgs: [id]);

    Debug.printLog("deleteReminder -->>$result");
    return result;
  }

  Future<List<NotificationTable>> getNotificationData({int? result}) async {
    var dbClient = await db;
    List<NotificationTable> notificationDataList = [];
    List<Map<String, dynamic>> maps = result != null
        ? await dbClient.query(notificationTable,
            where: "$notificationMid = ?", whereArgs: [result])
        : await dbClient.query(notificationTable);
    if (maps.isNotEmpty) {
      for (var answer in maps) {
        var notificationData = NotificationTable.fromJson(answer);
        notificationDataList.add(notificationData);
      }
    }
    return notificationDataList;
  }
}
