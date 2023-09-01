import 'package:flutter/material.dart';

import '../utils/color.dart';

final _timePickerTheme = TimePickerThemeData(
  backgroundColor: AppColor.white,
  hourMinuteShape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    side: BorderSide(color: AppColor.txtLightGray, width: 1),
  ),
  dayPeriodColor: MaterialStateColor.resolveWith((states) =>
      states.contains(MaterialState.selected)
          ? AppColor.colorTheme
          : AppColor.white.withOpacity(0.6)),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
  ),
  dayPeriodTextColor: MaterialStateColor.resolveWith((states) =>
      states.contains(MaterialState.selected)
          ? AppColor.white
          : AppColor.black),
  dayPeriodShape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
  ),
  hourMinuteColor: MaterialStateColor.resolveWith((states) =>
      states.contains(MaterialState.selected)
          ? AppColor.colorTheme
          : AppColor.white),
  hourMinuteTextColor: MaterialStateColor.resolveWith((states) =>
      states.contains(MaterialState.selected)
          ? AppColor.white
          : AppColor.black),
  dialHandColor: AppColor.colorTheme.withOpacity(0.9),
  dialBackgroundColor: AppColor.colorBGGrey.withOpacity(0.3),
  hourMinuteTextStyle:
      const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  dayPeriodTextStyle:
      const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
  helpTextStyle: const TextStyle(
      fontSize: 12, fontWeight: FontWeight.bold, color: AppColor.black),
  inputDecorationTheme: const InputDecorationTheme(
    border: InputBorder.none,
    contentPadding: EdgeInsets.all(0),
  ),
  dialTextColor: MaterialStateColor.resolveWith((states) =>
      states.contains(MaterialState.selected)
          ? AppColor.white
          : AppColor.black),
  entryModeIconColor: AppColor.colorTheme,
  dayPeriodBorderSide: const BorderSide(color: AppColor.txtLightGray, width: 1),
);

final _datePickerTheme = DatePickerThemeData(

  backgroundColor: AppColor.white,
  dayForegroundColor: MaterialStateProperty.all(AppColor.black),
  dayOverlayColor: MaterialStateProperty.all(AppColor.colorTheme),
  headerBackgroundColor: AppColor.colorTheme,
  headerForegroundColor: AppColor.black,
  rangePickerHeaderBackgroundColor: AppColor.colorTheme,
  rangePickerHeaderForegroundColor: AppColor.darkGreen,
  surfaceTintColor: AppColor.black.withOpacity(0.4),

  weekdayStyle: const TextStyle(color: AppColor.black, fontWeight: FontWeight.bold),
    dayBackgroundColor: MaterialStateColor.resolveWith((states) =>
    states.contains(MaterialState.selected)
        ? AppColor.colorTheme
        : AppColor.transparent),
    todayBackgroundColor: MaterialStateColor.resolveWith((states) =>
    states.contains(MaterialState.selected)
        ? AppColor.colorTheme
        : AppColor.transparent),
    todayForegroundColor: MaterialStateColor.resolveWith((states) =>
    states.contains(MaterialState.selected)
        ? AppColor.white
        : AppColor.colorTheme),
    todayBorder: const BorderSide(color: AppColor.colorTheme)
);

ThemeData lightTheme = ThemeData(
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColor.colorTheme, // background (button) color
      foregroundColor: Colors.white, // foreground (text) color
    ),
  ),
  scaffoldBackgroundColor: AppColor.white,
  cardColor: AppColor.white,
  primaryColor: AppColor.black,
  useMaterial3: true,
  timePickerTheme: _timePickerTheme,
  datePickerTheme: _datePickerTheme,
  scrollbarTheme: ScrollbarThemeData(
    thumbColor: MaterialStateProperty.all(AppColor.black.withOpacity(.3)),
  ),
  highlightColor: AppColor.colorTransparent,
  splashColor: AppColor.colorTransparent,
  colorScheme: const ColorScheme(
    background: AppColor.white,
    brightness: Brightness.dark,
    primary: AppColor.black,
    onPrimary: AppColor.black,
    secondary: AppColor.black,
    onSecondary: AppColor.black,
    error: AppColor.black,
    onError: AppColor.black,
    onBackground: AppColor.black,
    surface: AppColor.black,
    onSurface: AppColor.black,
  ),
);
