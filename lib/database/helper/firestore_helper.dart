import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pills_reminder/database/helper/database_helper.dart';
import 'package:pills_reminder/database/tables/medicine_table.dart';
import 'package:pills_reminder/database/tables/notification_table.dart';
import 'package:pills_reminder/main.dart';
import 'package:pills_reminder/utils/constant.dart';
import 'package:pills_reminder/utils/debug.dart';
import 'package:pills_reminder/utils/utils.dart';

class FireStoreHelper {
  /// USER TABLE
  String usersTable = "Users";
  String userId = "UserId";
  String userName = "UserName";
  String userEmail = "UserEmail";
  String userToken = "userToken";

  CollectionReference _getDataBaseTable(String tableName) {
    return MyApp.firebaseFirestore.collection(tableName);
  }

  Future onSync() {
    return _getDataBaseTable(usersTable)
        .doc(Utils.getFirebaseUid())
        .get()
        .then((value) {
      if (!value.exists) {
        Debug.printLog("NOT EXIST");
      } else {
        syncNotificationData();
        syncMedicineData();
        Debug.printLog("--------------<><><> ALL DATA SYNC SUCCESSFULLY ON SERVER <><><>--------------");

      }
    });
  }
  syncNotificationData() async {
    var data = await _getDataBaseTable(usersTable)
        .doc(Utils.getFirebaseUid())
        .collection(DataBaseHelper().notificationTable)
        .get();

    final allData = data.docs.map((doc) => doc.data()).toList();
    for (var element in allData) {
      await DataBaseHelper().insertOrUpdateNotificationData(NotificationTable.fromMap(element));
    }
  }
  syncMedicineData() async {
    var data = await _getDataBaseTable(usersTable)
        .doc(Utils.getFirebaseUid())
        .collection(DataBaseHelper().medicineTable)
        .get();

    final allData = data.docs.map((doc) => doc.data()).toList();
    for (var element in allData) {
      await DataBaseHelper().insertOrUpdateMedicineData(MedicineTable.fromMap(element));
    }
  }

  addUser(User? user) {
    return _getDataBaseTable(usersTable).doc(user!.uid).get().then((value) {
      if (!value.exists) {
        _getDataBaseTable(usersTable).doc(user.uid).set({
          userId: user.uid,
          userName: user.displayName ?? user.email?.split("@").first,
          userEmail: user.email,
          userToken: Utils.getFcmToken()
        }).then((value) {
          Debug.printLog("User Added Success");
        }).catchError((error) => Debug.printLog("Failed to add user: $error"));
      } else {
        _getDataBaseTable(usersTable).doc(user.uid).update({
          userId: user.uid,
          userName: user.displayName ??user.email?.split("@").first,
          userEmail: user.email,
          userToken: Utils.getFcmToken()
        }).then((value) {
          Debug.printLog("Update User Success");
        }).catchError(
            (error) => Debug.printLog("Failed to Update user: $error"));
      }
    });
  }

  addAndUpdateMedicine(String id, MedicineTable medicineData) async {
    var doc = _getDataBaseTable(usersTable)
        .doc(Utils.getFirebaseUid())
        .collection(DataBaseHelper().medicineTable)
        .doc(id);
    var value = await doc.get();

    if (!value.exists) {
      await doc.set(medicineData.toJson());
      Debug.printLog("Add MedicineTable Success");
    } else {
      await doc.update(medicineData.toJson());
      Debug.printLog("Update MedicineTable Success");
    }

    /*return _getDataBaseTable(usersTable)
        .doc(Utils.getFirebaseUid())
        .collection(DataBaseHelper().medicineTable)
        .doc(id)
        .get()
        .then((value) async {
      if (!value.exists) {
        var doc = _getDataBaseTable(usersTable)
            .doc(Utils.getFirebaseUid())
            .collection(DataBaseHelper().medicineTable)
            .doc();

        await doc.set(medicineData.toJson()).then((value) {
          return Debug.printLog("Add MedicineTable Success");
        }).catchError(
            (error) => Debug.printLog("Failed to Add MedicineTable: $error"));
      } else {
        var doc = _getDataBaseTable(usersTable)
            .doc(Utils.getFirebaseUid())
            .collection(DataBaseHelper().medicineTable)
            .doc(id);

        await doc
            .update(medicineData.toJson())
            .then((value) => Debug.printLog("Update MedicineTable Success"))
            .catchError((error) =>
                Debug.printLog("Failed to Update MedicineTable: $error"));
      }
    });*/
  }
  deleteMedicine(int id) async {
    var doc = _getDataBaseTable(usersTable)
        .doc(Utils.getFirebaseUid())
        .collection(DataBaseHelper().medicineTable)
        .doc(id.toString());

    await doc
        .delete()
        .then((value) => Debug.printLog("Delete MedicineTable Success"))
        .catchError((error) => Debug.printLog("Failed to Delete MedicineTable: $error"));
  }
  Future<void> deleteNotificationsByMid(int id) async {
    try {
      var collectionReference = FirebaseFirestore.instance
          .collection(usersTable)
          .doc(Utils.getFirebaseUid())
          .collection(DataBaseHelper().notificationTable);

      var querySnapshot = await collectionReference
          .where('notificationMid', isEqualTo: id)
          .get();

      for (var docSnapshot in querySnapshot.docs) {
        await docSnapshot.reference.delete();
      }

      Debug.printLog("Deleted Notifications with notificationMid: $id");
    } catch (error) {
      Debug.printLog("Failed to delete notifications: $error");
    }
  }

  addAndUpdateNotification(int id,NotificationTable notificationData) async {

    var doc = _getDataBaseTable(usersTable)
        .doc(Utils.getFirebaseUid())
        .collection(DataBaseHelper().notificationTable)
        .doc(id.toString());
    var value = await doc.get();

    if (!value.exists) {
      await doc.set(notificationData.toJson());
      Debug.printLog("Add NotificationTable Success");
    } else {
      await doc.update(notificationData.toJson());
      Debug.printLog("Update NotificationTable Success");
    }


  //   var doc = _getDataBaseTable(usersTable)
  //       .doc(Utils.getFirebaseUid())
  //       .collection(DataBaseHelper().notificationTable)
  //       .doc();
  //   await doc
  //       .set(notificationData.toJson())
  //       .then((value) => Debug.printLog("Add NotificationTable Success"))
  //       .catchError((error) =>
  //           Debug.printLog("Failed to add NotificationTable: $error"));
  }
}
