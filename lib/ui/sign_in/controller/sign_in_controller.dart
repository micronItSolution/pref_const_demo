import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pills_reminder/database/helper/database_helper.dart';
import 'package:pills_reminder/database/helper/firestore_helper.dart';
import 'package:pills_reminder/database/tables/user_table.dart';
import 'package:pills_reminder/routes/app_routes.dart';
import 'package:pills_reminder/utils/constant.dart';
import 'package:pills_reminder/utils/preference.dart';
import 'package:pills_reminder/utils/utils.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SignInController extends GetxController {
  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isShowProgress = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? fcmToken;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
    ],
  );

  @override
  void onInit() {
    FirebaseMessaging _firebaseMessaging =
        FirebaseMessaging.instance; // Change here
    _firebaseMessaging.getToken().then((token) {
      fcmToken = token;
      Preference.shared.setString(Preference.fcmToken, fcmToken!);

      print("token is $token");
    });
    super.onInit();
  }

  login(context) async {
    if (formKey.currentState!.validate()) {
      try {
        isShowProgress = true;
        update([Constant.idProVersionProgress]);
        var auth = await _auth.signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim());
        FireStoreHelper().addUser(auth.user);

        Preference.shared.setString(Preference.firebaseAuthUid, auth.user!.uid);
        DataBaseHelper().insertUser(UserTable(
            uId: null,
            email: emailController.text.trim(),
            name:  emailController.text.trim().split("@").first,
            fcmToken: fcmToken));

        Utils.showToast(context, "toastLogin".tr);
        isShowProgress = false;
        update([Constant.idProVersionProgress]);
        Preference.shared.setIsUserLogin(true);
        await FireStoreHelper().onSync();

        Get.toNamed(AppRoutes.home);
      } catch (firebaseAuthException) {
        isShowProgress = false;
        update([Constant.idProVersionProgress]);
        Utils.showToast(context, firebaseAuthException.toString());
        print(":::::${firebaseAuthException.toString()}");
      }
    }
  }

  bool isEmailValid(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  loginWithGoogle(context) async {
    try {
      isShowProgress = true;
      update([Constant.idProVersionProgress]);

      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        UserCredential? userCredential =
            await _auth.signInWithCredential(credential).catchError((onErr) {
          isShowProgress = false;

          return Utils.showToast(context, onErr.toString());
        });
        if (userCredential.user != null) {
          DataBaseHelper().insertUser(UserTable(
              uId: null,
              email: userCredential.user?.email,
              name: userCredential.user?.displayName,
              fcmToken: fcmToken));
          FireStoreHelper().addUser(userCredential.user);
          Preference.shared
              .setString(Preference.firebaseAuthUid, userCredential.user!.uid);
          isShowProgress = false;
          await FireStoreHelper().onSync();
          update([Constant.idProVersionProgress]);

          Utils.showToast(context, "toastLogin".tr);

          Preference.shared.setIsUserLogin(true);
          Get.offAllNamed(AppRoutes.home);
        } else {
          isShowProgress = false;
        }
      } else {
        Utils.showToast(context, "Something Want Wrong");
        isShowProgress = false;
      }
    } catch (e) {
      Utils.showToast(context, e.toString());

      isShowProgress = false;
      update([Constant.idProVersionProgress]);
      print(e.toString());
    } finally {
      isShowProgress = false;
      update([Constant.idProVersionProgress]);
    }
  }

  String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  loginWithApple(context) async {
    try {
      isShowProgress = true;
      update([Constant.idProVersionProgress]);

      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);

      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );
      await FireStoreHelper().onSync();
      Utils.showToast(context, "toastLogin".tr);
      isShowProgress = false;
      update([Constant.idProVersionProgress]);
      Preference.shared.setIsUserLogin(true);
      Get.offNamed(AppRoutes.home);
      DataBaseHelper().insertUser(UserTable(
          uId: null,
          email: appleCredential.email,
          name: appleCredential.givenName,
          fcmToken: fcmToken));

      var auth =
          await FirebaseAuth.instance.signInWithCredential(oauthCredential);
      Preference.shared.setString(Preference.firebaseAuthUid, auth.user!.uid);
      FireStoreHelper().addUser(auth.user);
      return auth;
    } catch (e) {
      isShowProgress = false;
      update([Constant.idProVersionProgress]);
      Utils.showToast(context, e.toString());
      print(" $e");
    }
  }

  Future<void> logoutGoogle() async {
    await _googleSignIn.signOut();
    Get.back();
  }
}
