import 'package:flutter/material.dart';
import 'package:pills_reminder/utils/constant.dart';

class AppFontStyle {
  /// customise style
  static styleW400(Color? color, double? fontSize) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontFamily: Constant.fontFamilyPoppins,
      fontWeight: FontWeight.w400, /// Light
    );
  }

  static styleW500(Color? color, double? fontSize) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontFamily: Constant.fontFamilyPoppins,
      fontWeight: FontWeight.w500, /// Medium
    );
  }

  static styleW600(Color? color, double? fontSize) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontFamily: Constant.fontFamilyPoppins,
      fontWeight: FontWeight.w600, /// Regular
    );
  }

  static styleW700(Color? color, double? fontSize) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontFamily: Constant.fontFamilyPoppins,
      fontWeight: FontWeight.w700, /// Bold
    );
  }

  static customizeStyle(
      {String? fontFamily, color, fontSize, fontWeight, height}) {
    return TextStyle(
      fontFamily: fontFamily,
      height: height,
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }
}
