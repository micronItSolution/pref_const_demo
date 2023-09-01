import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pills_reminder/custom/progress_dialog.dart';
import 'package:pills_reminder/routes/app_routes.dart';
import 'package:pills_reminder/ui/sign_in/controller/sign_in_controller.dart';
import 'package:pills_reminder/utils/asset.dart';
import 'package:pills_reminder/utils/color.dart';
import 'package:pills_reminder/utils/constant.dart';
import 'package:pills_reminder/utils/sizer_utils.dart';

class SignInScreen extends StatelessWidget {
  final SignInController controller = Get.put(SignInController());

  SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColor.colorTheme,
            ),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: AppSizes.height_4_5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Sign In",
                            style: TextStyle(
                                color: AppColor.white,
                                fontSize: AppFontSize.size_26,
                                fontFamily: Constant.fontFamilyPoppins,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40))),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(30),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: AppSizes.height_4,
                              ),
                              const TextField(),
                              SizedBox(
                                height: AppSizes.height_4_5,
                              ),
                              const LoginButton(),
                              SizedBox(
                                height: AppSizes.height_3,
                              ),
                              InkWell(
                                onTap: () => Get.toNamed(AppRoutes.signUp),
                                child: Text("Don't have an account?",
                                    style: TextStyle(
                                        color: AppColor.darkGreen,
                                        fontSize: AppFontSize.size_11,
                                        fontFamily: Constant.fontFamilyPoppins)),
                              ),
                              SizedBox(
                                height: AppSizes.height_3,
                              ),
                              orDivider(),
                              SizedBox(
                                height: AppSizes.height_3,
                              ),
                              const GoogleLogin(),
                              SizedBox(
                                height: AppSizes.height_3,
                              ),
                              if (Platform.isIOS) const AppleLogin()
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        GetBuilder<SignInController>(
          id: Constant.idProVersionProgress,
          builder: (logic) {
            return ProgressDialog(inAsyncCall: logic.isShowProgress, child: const SizedBox(),
            );
          },
        ),

      ],
    );
  }
}

class TextField extends StatelessWidget {
  const TextField({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignInController>(builder: (logic) {
      return Container(
        decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: AppColor.colorTheme.withOpacity(0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 10))
            ]),
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
              decoration: const BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: AppColor.txtLightGray))),
              child: TextFormField(
                controller: logic.emailController,
                decoration: const InputDecoration(
                    hintText: "Email",
                    hintStyle: TextStyle(
                        color: AppColor.txtColor999,
                        fontFamily: Constant.fontFamilyPoppins),
                    border: InputBorder.none),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!logic.isEmailValid(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
              decoration: const BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: AppColor.txtLightGray))),
              child: TextFormField(
                controller: logic.passwordController,
                decoration: const InputDecoration(
                    hintText: "Password",
                    hintStyle: TextStyle(
                        color: AppColor.txtColor999,
                        fontFamily: Constant.fontFamilyPoppins),
                    border: InputBorder.none),
                obscureText: true, // Hides the password characters.
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a password';
                  } else if (value.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignInController>(builder: (logic) {
      return InkWell(
        onTap: () {
          logic.login(context);
        },
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: AppColor.colorTheme),
          child: Center(
            child: Text(
              "Login",
              style: TextStyle(
                  color: AppColor.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: Constant.fontFamilyPoppins,
                  fontSize: AppFontSize.size_12),
            ),
          ),
        ),
      );
    });
  }
}

Widget orDivider() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
    child: Row(
      children: [
        Flexible(
          child: Container(
            height: 1,
            color: AppColor.txtColor999,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'or',
            style: TextStyle(
              fontSize: AppFontSize.size_14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Flexible(
          child: Container(
            height: 1,
            color: AppColor.txtColor999,
          ),
        ),
      ],
    ),
  );
}

class GoogleLogin extends StatelessWidget {
  const GoogleLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignInController>(builder: (logic) {
      return InkWell(
        onTap: () {
          logic.loginWithGoogle(context);
        },
        child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: AppColor.blue, borderRadius: BorderRadius.circular(50)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppAsset.icGoogle,
                    height: 32, color: AppColor.white),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Login with Google",
                  style: TextStyle(
                      color: AppColor.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: Constant.fontFamilyPoppins,
                      fontSize: AppFontSize.size_12),
                ),
              ],
            )),
      );
    });
  }
}

class AppleLogin extends StatelessWidget {
  const AppleLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignInController>(builder: (logic) {
      return InkWell(
        onTap: () {
          logic.loginWithApple(context);
        },
        child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: AppColor.black, borderRadius: BorderRadius.circular(50)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppAsset.icApple,
                    height: 35, color: AppColor.white),
                const SizedBox(
                  width: 10,
                ),
                // ignore: prefer_const_constructors
                Text(
                  "Login with Apple",
                  style: const TextStyle(
                      color: AppColor.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: Constant.fontFamilyPoppins,
                      fontSize: 16),
                ),
              ],
            )),
      );
    });
  }
}
