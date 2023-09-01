import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pills_reminder/main.dart';
import 'package:pills_reminder/utils/RingtoneService.dart';
import 'package:pills_reminder/utils/constant.dart';
import 'package:pills_reminder/utils/debug.dart';

class SelectSoundScreenLogic extends GetxController {
  List<Ringtone> ringtones = [];
  static AudioPlayer audioPlayer = AudioPlayer();
  static const channel = MethodChannel('ringtone_channel');
  String pickedRingtoneTitle = "txtTakeRingtone".tr;
  String? pickedSoundTitle;

  String? pickedRingtoneUri;
  String? pickedSoundUri;

  bool isRingPlaying = false;
  List<bool> selectedSoundList =
      List<bool>.filled(Constant.soundList.length, false);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  Future<void> getRingtones() async {
    try {
      selectedSoundList =
          List.generate(selectedSoundList.length, (index) => false);
      pickedSoundUri = null;
      pickedSoundTitle = null;
      FlutterRingtonePlayer.stop();
      update([Constant.idListOfSounds]);
      final Map<dynamic, dynamic>? result =
          await channel.invokeMethod('getSystemRingtones');
      if (result != null && result.entries.isNotEmpty) {
        Debug.printLog('ringtones invokeMethod: ${result.entries}');
        pickedRingtoneTitle = result['Title'];
        pickedRingtoneUri = result['URI'];
        update([Constant.idSelectAlertSound]);
      }
    } on PlatformException catch (ex) {
      if (kDebugMode) {
        print('Exception: $ex.message');
      }
    }
  }

  Future<void> playRingtone() async {
    if (pickedRingtoneUri != null) {
      isRingPlaying =
          await channel.invokeMethod('playSystemRingtone', pickedRingtoneUri);
      update([Constant.idSelectAlertSound]);
    }
  }

  Future<void> stopRingTone() async {
    isRingPlaying = await channel.invokeMethod('stopSystemRingtone');
    update([Constant.idSelectAlertSound]);
  }

  void changeSelectedRing({required int index, required bool value}) {
    stopRingTone();
    pickedRingtoneTitle = "txtTakeRingtone".tr;
    pickedRingtoneUri = null;
    update([Constant.idSelectAlertSound]);
    for (int i = 0; i < selectedSoundList.length; i++) {
      selectedSoundList[i] = (i == index) ? value : false;
    }
    pickedSoundTitle = Constant.soundList[index];
    pickedSoundUri =
        'assets/sounds/${Constant.soundList[index].toLowerCase().removeAllWhitespace}.mp3';
    FlutterRingtonePlayer.play(fromAsset: pickedSoundUri);
    update([Constant.idListOfSounds]);
  }

  void saveSound() {
    stopRingTone();
    FlutterRingtonePlayer.stop();
    Map<String, dynamic> map = {
      Constant.idSoundUriArgs: pickedRingtoneUri ?? pickedSoundUri,

      Constant.idSoundTypeArgs: pickedRingtoneUri != null ?"Ringtone" : "Sound",

      Constant.idSoundTitleArgs:
          pickedRingtoneUri != null ? pickedRingtoneTitle : pickedSoundTitle,
    };
    print('saveSound: ${map.entries.toString()}');
    print(":::::::${map.entries.toString()}");
    Get.back(result: map);
  }
}
