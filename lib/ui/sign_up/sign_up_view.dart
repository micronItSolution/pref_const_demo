import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pills_reminder/custom/progress_dialog.dart';
import 'package:pills_reminder/utils/color.dart';
import 'package:pills_reminder/utils/constant.dart';
import 'package:pills_reminder/utils/sizer_utils.dart';

import 'sign_up_logic.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<SignUpLogic>();

    return Stack(
      children: [
        Scaffold(
          body: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColor.colorTheme,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: AppSizes.height_4_5,
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Sign Up",
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
                            textField(),
                            SizedBox(
                              height: AppSizes.height_4_5,
                            ),
                            loginBut(context),
                            SizedBox(
                              height: AppSizes.height_3,
                            ),
                            InkWell(
                              onTap: () => Get.back(),
                              child: RichText(
                                  text: TextSpan(
                                      text: 'Have you Account?',
                                      style: TextStyle(
                                          color: AppColor.black,
                                          fontSize: AppFontSize.size_11,
                                          fontFamily:
                                              Constant.fontFamilyPoppins),
                                      children: <InlineSpan>[
                                    TextSpan(
                                      text: ' sign in',
                                      style: TextStyle(
                                          color: AppColor.darkGreen,
                                          fontSize: AppFontSize.size_11,
                                          fontFamily:
                                              Constant.fontFamilyPoppins,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ])),
                            ),
                            SizedBox(
                              height: AppSizes.height_3,
                            ),
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
        GetBuilder<SignUpLogic>(
          id: Constant.idProVersionProgress,
          builder: (logic) {
            return ProgressDialog(
              inAsyncCall: logic.isShowProgress,
              child: const SizedBox(),
            );
          },
        ),
      ],
    );
  }
}

Widget textField() {
  return GetBuilder<SignUpLogic>(builder: (logic) {
    return Form(
      key: logic.formKey,
      child: Container(
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
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  } else if (value.length < 6) {
                    return 'Password must be at least 6 characters long';
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
                controller: logic.confirmPasswordController,
                decoration: const InputDecoration(
                    hintText: "Confirm Password",
                    hintStyle: TextStyle(
                        color: AppColor.txtColor999,
                        fontFamily: Constant.fontFamilyPoppins),
                    border: InputBorder.none),
                obscureText: true, // Hides the password characters.

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  } else if (value != logic.passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  });
}

Widget loginBut(BuildContext context) {
  return GetBuilder<SignUpLogic>(builder: (logic) {
    return InkWell(
      onTap: () {
        logic.singUp(context);
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: AppColor.colorTheme),
        child: Center(
          child: Text(
            "Sign up",
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
