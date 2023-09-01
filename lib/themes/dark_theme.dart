import 'package:flutter/material.dart';

import '../utils/color.dart';

final _timePickerTheme = TimePickerThemeData(
  backgroundColor: AppColor.black,
  hourMinuteShape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    side: BorderSide(color: AppColor.txtLightGray, width: 1),
  ),
  dayPeriodColor: MaterialStateColor.resolveWith((states) =>
      states.contains(MaterialState.selected)
          ? AppColor.colorTheme
          : AppColor.black.withOpacity(0.6)),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
  ),
  dayPeriodTextColor: MaterialStateColor.resolveWith((states) =>
      states.contains(MaterialState.selected)
          ? AppColor.black
          : AppColor.white),
  dayPeriodShape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
  ),
  hourMinuteColor: MaterialStateColor.resolveWith((states) =>
      states.contains(MaterialState.selected)
          ? AppColor.colorTheme
          : AppColor.black),
  hourMinuteTextColor: MaterialStateColor.resolveWith((states) =>
      states.contains(MaterialState.selected)
          ? AppColor.black
          : AppColor.white),
  dialHandColor: AppColor.colorBGGrey.withOpacity(0.9),
  dialBackgroundColor: AppColor.colorBGGrey.withOpacity(0.2),
  hourMinuteTextStyle:
      const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  dayPeriodTextStyle:
      const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
  helpTextStyle: const TextStyle(
      fontSize: 12, fontWeight: FontWeight.bold, color: AppColor.white),
  inputDecorationTheme: const InputDecorationTheme(
    border: InputBorder.none,
    contentPadding: EdgeInsets.all(0),
  ),
  dialTextColor: MaterialStateColor.resolveWith((states) =>
      states.contains(MaterialState.selected)
          ? AppColor.colorTheme
          : AppColor.white),
  entryModeIconColor: AppColor.colorTheme,
  dayPeriodBorderSide: const BorderSide(color: AppColor.txtLightGray, width: 1),

);

final _datePickerTheme = DatePickerThemeData(

    backgroundColor: AppColor.black,
    dayForegroundColor: MaterialStateProperty.all(AppColor.white),
    dayOverlayColor: MaterialStateProperty.all(AppColor.colorTheme),
  weekdayStyle: const TextStyle(color: AppColor.white, fontWeight: FontWeight.bold),

  dayBackgroundColor: MaterialStateColor.resolveWith((states) =>
        states.contains(MaterialState.selected)
            ? AppColor.colorTheme
            : AppColor.transparent),
    headerBackgroundColor: AppColor.colorTheme,
    headerForegroundColor: AppColor.white,
    surfaceTintColor: AppColor.white.withOpacity(0.4),
    todayBackgroundColor: MaterialStateColor.resolveWith((states) =>
        states.contains(MaterialState.selected)
            ? AppColor.colorTheme
            : AppColor.transparent),
    todayForegroundColor: MaterialStateColor.resolveWith((states) =>
        states.contains(MaterialState.selected)
            ? AppColor.white
            : AppColor.colorTheme),
    todayBorder: const BorderSide(color: AppColor.colorTheme),);
ThemeData darkTheme = ThemeData(

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColor.colorTheme, // background (button) color
      foregroundColor: Colors.white, // foreground (text) color
    ),
  ),
  scaffoldBackgroundColor: AppColor.black,
  primaryColor: AppColor.white,
  cardColor: AppColor.colorDarkCard,
  useMaterial3: true,
  timePickerTheme: _timePickerTheme,
  datePickerTheme: _datePickerTheme,
  scrollbarTheme: ScrollbarThemeData(
    thumbColor: MaterialStateProperty.all(AppColor.white.withOpacity(.3)),
  ),
  highlightColor: AppColor.colorTransparent,
  splashColor: AppColor.colorTransparent,
  colorScheme: const ColorScheme(
    background: AppColor.black,
    brightness: Brightness.dark,
    primary: AppColor.white,
    onPrimary: AppColor.white,
    secondary: AppColor.white,
    onSecondary: AppColor.white,
    error: AppColor.white,
    onError: AppColor.white,
    onBackground: AppColor.white,
    surface: AppColor.white,
    onSurface: AppColor.white,
  ),
);
