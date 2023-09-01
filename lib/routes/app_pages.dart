import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:pills_reminder/ui/add_medicine/binding/add_medicine_binding.dart';
import 'package:pills_reminder/ui/add_medicine/views/add_medicine_screens.dart';
import 'package:pills_reminder/ui/full_screen_notification/binding/full_screen_notification_binding.dart';
import 'package:pills_reminder/ui/full_screen_notification/views/full_screen_notification_view.dart';
import 'package:pills_reminder/ui/home/binding/home_binding.dart';
import 'package:pills_reminder/ui/home/views/home_screens.dart';
import 'package:pills_reminder/ui/medicine_detailes/binding/medicine_details_binding.dart';
import 'package:pills_reminder/ui/medicine_detailes/views/medicine_details_screens.dart';
import 'package:pills_reminder/ui/select_sound_screen/select_sound_screen_binding.dart';
import 'package:pills_reminder/ui/select_sound_screen/select_sound_screen_view.dart';
import 'package:pills_reminder/ui/select_color/select_color_binding.dart';
import 'package:pills_reminder/ui/select_color/select_color_view.dart';
import 'package:pills_reminder/ui/sign_in/binding/sign_in_binding.dart';
import 'package:pills_reminder/ui/sign_in/views/sign_in_screens.dart';
import 'package:pills_reminder/ui/sign_up/sign_up_binding.dart';
import 'package:pills_reminder/ui/sign_up/sign_up_view.dart';

import 'package:pills_reminder/ui/update_medicine/binding/update_medicine_binding.dart';
import 'package:pills_reminder/ui/update_medicine/views/update_medicine_screens.dart';

import 'app_routes.dart';

class AppPages {
  static var list = [
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),GetPage(
      name: AppRoutes.signIn,
      page: () => SignInScreen(),
      binding: SignInBinding(),
    ),GetPage(
      name: AppRoutes.add,
      page: () => AddMedicineScreen(),
      binding: AddMedicineBinding(),
    ),GetPage(
      name: AppRoutes.details,
      page: () =>  MedicineDetailsScreens(),
      binding: MedicineDetailsBinding(),
    ),GetPage(
      name: AppRoutes.update,
      page: () => UpdateMedicineScreens(),
      binding: UpdateMedicineBinding(),
    ),GetPage(
      name: AppRoutes.selectColor,
      page: () => const SelectColorPage(),
      binding: SelectColorBinding(),
    ),GetPage(
      name: AppRoutes.selectRingtone,
      page: () => const SelectSoundScreenPage(),
      binding: SelectSoundScreenBinding(),
    ),GetPage(
      name: AppRoutes.signUp,
      page: () => const SignUpPage(),
      binding: SignUpBinding(),
    ),GetPage(
      name: AppRoutes.fullScreenNotification,
      page: () => const FullScreenNotificationPage(),
      binding: FullScreenNotificationBinding(),
    ),

  ];
}
