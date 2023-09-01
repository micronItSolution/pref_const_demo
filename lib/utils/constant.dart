import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Constant {
 static const languageEn = "en";
  static const countryCodeEn = "US";
  static const fontFamilyPoppins = "Poppins";



  static const boolValueTrue = true;
  static const boolValueFalse = false;
  /// Google Ads

  static const interstitialCount = 5;

  static const idDosageSelect ='idDosageSelect';

  static var idSelectedDosage = 'idSelectedDosage';

  static var  idSelectAlertSound = 'idSelectAlertSound';

  static var idListOfSounds = 'idListOfSounds';

  static var idSoundUriArgs='idSoundUriArgs';

  static var idSoundTypeArgs='idSoundTypeArgs';

  static var idSoundTitleArgs ='idSoundTitleArgs';

  static var idSelectStartDate ='idSelectStartDate';

  static var idSelectEndDate ='idSelectEndDate';

  static var idSelectFrequency ='idSelectFrequency';

  static var idSelectEveryDay ='idSelectEveryDay';

  static var idSelectSpecificDay ='idSelectSpecificDay';

  static var idSelectedTime='idSelectedTime';



  static String getPrivacyPolicyURL() {
    return "Add your privacy policy link here";
  }
  static const appThemeLight = "LIGHT";
  static const appThemeDark = "DARK";

  static const String shareLink = "Add your app url here";

  static const emailPath = 'Add your email address here';

  static String privacyPolicyURL = "Add your privacy policy link here";


  static String googlePlayIdentifier = "Add your googlePlayIdentifier here";

  static String appStoreIdentifier = "Add your appStoreIdentifier here";
  /// Terms & condition URL
  static const termsAndConditionURL = " Add your terms and conditions URL here";


  static const String monthlySubscriptionId = "Add your monthly subscription id here which should be same for both android and iOS";
  static const String yearlySubscriptionId = "Add your yearly subscription id here which should be same for both android and iOS";



  /// In-App Purchase
  static const String productIdiOS = "Add your Product ID here for iOS"; /// 'Your Plan ID (Product ID iOS)';
  static const String productIdAndroid = "lifetime_pro_version"; /// 'Your Plan ID (Product ID Android)';


  static getAsset() => "assets/";


  static getAssetIcons() => "assets/icons/";
  static getAssetItem() => "assets/item/";

  static getAssetBackground() => "assets/background/";
  static getAssetDrag() => "assets/drag assets/";
  static getAssetDragCategory() => "assets/drag assets/category";
  static getAssetDragImages() => "assets/drag assets/images/";
  static getAssetDragNumbers() => "assets/drag assets/numbers/";
  static getAssetDragCounting() => "assets/drag assets/counting/";
  static getAssetDragAnimation() => "assets/drag assets/animation/";
  static getAssetDragTime() => "assets/drag assets/time/";
  static getAssetDragMonths() => "assets/drag assets/months/";
  static getAssetDragDays() => "assets/drag assets/days/";


  static getAssetSubCategory() => "assets/subcategory/";

  static getAssetImage() => "assets/images/";


  static List<Color> colorList = const [
    Color(0XFFD400FF),
    Color(0XFFFF3D3D),
    Color(0XFFFFA900),
    Color(0XFF02E930),
    Color(0XFFFFD800),
    Color(0XFF00A3FF),
    Color(0XFFA43FFF),
    Color(0XFFFC57EE),
    Color(0XFF17F2F3),
    Color(0XFF00A3FF),
    Color(0XFFFFA900),
    Color(0XFFFF3D3D),
    Color(0XFFFFD800),
    Color(0XFFD400FF),
    Color(0XFFA43FFF),
    Color(0XFF17F2F3),
    Color(0XFFD400FF),
    Color(0XFFFC57EE),
    Color(0XFF00A3FF),
    Color(0XFFFFA900),
    Color(0XFFFFD800),
  ];
  static List<String> soundList = const [
    'Default Tone',
    'Analog Watch',
    'Bells',
    'Cartoon',
    'Clock',
    'Google',
    'iPhone',
    'Kids',
    'Telephone',
    'VIP',
  ];
 static List<String> weekDaysList = const [
   'Monday',
   'Tuesday',
   'Wednesday',
   'Thursday',
   'Friday',
   'Saturday',
   'Sunday',
 ];
 static List<String> dosageDataList = [
   "DROPS",
   "CARTON",
   "CC",
   "GR",
   "IU",
   "PILLS",
   "ML",
   "MCG",
   "MEQ",
   "PIECES",
   "PUFFUS",
   "PATCH",
   "SPRAY",
   "TEA SPOON",
   "TABLE SPOON",
   "UNITS",
   "MG",
 ];


 static String txtHowManyObjects = "How Many Objects?";

  static String txtCountTheObjects = "Count the objects";

  /// <<===================>> ****** Widget Id's for refresh in GetX ****** <<===================>>


  static var idProVersionProgress='idProVersionProgress';

  static const idSelectedImage ='idSelectedImage';
 static const idSelectedColor ='idSelectedColor';
  static const idSettingsTheme = "idSettingsTheme";
  static const idHome= "idHome";
  static const isUserActive= "isUserActive";
  static const isMedicineDetails= "isMedicineDetails";
  static const idDrawerSheet= "idDrawerSheet";
  static const idMedicineList= "idMedicineList";


///Navigation Arguments
 static const idImageArg ='idImageArg';
 static const idColorArg = 'idColorArg';

}




