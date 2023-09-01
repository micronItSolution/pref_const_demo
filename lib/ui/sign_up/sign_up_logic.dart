import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pills_reminder/database/helper/database_helper.dart';
import 'package:pills_reminder/database/helper/firestore_helper.dart';
import 'package:pills_reminder/database/tables/user_table.dart';
import 'package:pills_reminder/routes/app_routes.dart';
import 'package:pills_reminder/utils/constant.dart';
import 'package:pills_reminder/utils/preference.dart';
import 'package:pills_reminder/utils/utils.dart';

class SignUpLogic extends GetxController {
  final formKey = GlobalKey<FormState>();
  bool isShowProgress = false;
  String? fcmToken;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isEmailValid(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }
  @override
  void onInit() {
    FirebaseMessaging _firebaseMessaging =
        FirebaseMessaging.instance; // Change here
    _firebaseMessaging.getToken().then((token) {
      fcmToken =token;
      print("token is $token");
    });
    super.onInit();
  }


  void singUp( context) async {

    if (formKey.currentState!.validate()) {
      isShowProgress = true;
      update([Constant.idProVersionProgress]);

      try {
      var auth = await _auth.createUserWithEmailAndPassword(
          email: emailController.text.trim(), password: confirmPasswordController.text.trim());
      Preference.shared
          .setString(Preference.firebaseAuthUid,auth.user!.uid );
      FireStoreHelper().addUser(auth.user);

      isShowProgress = false;
      update([Constant.idProVersionProgress]);
      Utils.showToast(context, "You are successfully logged in");
      Preference.shared.setIsUserLogin(true);
      Get.toNamed(AppRoutes.home);

      DataBaseHelper().insertUser(UserTable(
          uId: null,
          email:emailController.text.trim(),
          name: emailController.text.trim().split("@").first,
          fcmToken:fcmToken
      ));

    } catch (firebaseAuthException) {
        isShowProgress = false;
        update([Constant.idProVersionProgress]);
        Utils.showToast(context, firebaseAuthException.toString());


      }
  }}
}

