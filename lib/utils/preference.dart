import 'dart:async';

import 'package:get_storage/get_storage.dart';
import 'package:pills_reminder/utils/constant.dart';


class Preference {
  static const String authorization = "AUTHORIZATION";

  static const String selectedLanguage = "LANGUAGE";
  static const String selectedCountryCode = "SELECTED_COUNTRY_CODE";
  static const String isSOUND = "SOUND";
  static const String isMusic = "Music";

  static const String isFirstTimeOpenApp = "IS_FIRST_TIME_OPEN_APP";
  static const String isUserLogin = "isUserLogin";
  static const String appTheme = "APP_THEME";
  static const String firebaseAuthUid = "FIREBASE_AUTH_UID";
  static const String fcmToken  = "fcmToken";
  static const String mId = "mId";




  /// ------------------ SINGLETON -----------------------
  static final Preference _preference = Preference._internal();

  factory Preference() {
    return _preference;
  }

  Preference._internal();

  static Preference get shared => _preference;

  static GetStorage? _pref;


  FutureOr<GetStorage?> instance() async {
    if (_pref != null) return _pref;
    await GetStorage.init().then((value) {
      if (value) {
        _pref = GetStorage();
      }
    }).catchError((onError) {
      _pref = null;
    });
    return _pref;
  }

  String? getString(String key) {
    return _pref!.read(key);
  }


  Future<void> setString(String key, String value) {
    return _pref!.write(key, value);
  }

  int? getInt(String key) {
    return _pref!.read(key);
  }

  Future<void> setInt(String key, int value) {
    return _pref!.write(key, value);
  }

  bool? getBool(String key) {
    return _pref!.read(key);
  }

  Future<void> setBool(String key, bool value) {
    return _pref!.write(key, value);
  }

  double? getDouble(String key) {
    return _pref!.read(key);
  }

  Future<void> setDouble(String key, double value) {
    return _pref!.write(key, value);
  }

  List<String>? getStringList(String key) {
    return _pref!.read(key);
  }

  Future<void> setStringList(String key, List<String> value) {
    return _pref!.write(key, value);
  }

///IsUserLogin

  Future<void> setIsUserLogin(bool value) {
    return _pref!.write(isUserLogin, value);
  }

  bool getIsUserLogin() {
    return _pref!.read(isUserLogin) ?? false;
  }
  /// App Theme
  Future<void> setAppTheme(String value) {
    return _pref!.write(appTheme, value);
  }

  String getAppTheme() {
    return _pref!.read(appTheme) ?? Constant.appThemeLight;
  }

///MedicineID

  int getMId() {
    return _pref!.read(mId) ?? 1;
  }
  Future<void> setMId(int value) {
    return _pref!.write(mId, value);
  }


  Future<void> remove(key, [multi = false]) async {
    GetStorage? pref = await instance();
    if (multi) {
      key.forEach((f) async {
        return await pref!.remove(f);
      });
    } else {
      return await pref!.remove(key);
    }
  }


  static Future<bool> clear() async {
    _pref!.getKeys().forEach((key) async {
      await _pref!.remove(key);
    });

    return Future.value(true);
  }

  static Future<bool> clearLogout() async {
    return Future.value(true);
  }

}
