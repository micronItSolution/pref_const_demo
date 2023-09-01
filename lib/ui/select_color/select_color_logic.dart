import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pills_reminder/utils/constant.dart';

class SelectColorLogic extends GetxController {
  ImagePicker picker = ImagePicker();
  XFile? image;
  CroppedFile? croppedFile;

  // Color selectedColor = Colors.red;

  ColorSwatch? tempMainColor;
  Color? tempShadeColor;
  ColorSwatch? mainColor = Colors.blue;
  Color? shadeColor = Colors.black26;


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

  Future<void> pickImageFromGallery() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    if(image != null){
      croppedFile = await ImageCropper().cropImage(
        sourcePath: image!.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Get.theme.primaryColor,
              toolbarWidgetColor: Get.theme.cardColor,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
          WebUiSettings(
            context: Get.context!,
          ),
        ],
      );
    }

    mainColor = Colors.blue;
    shadeColor = Colors.black26;
    update([Constant.idSelectedImage]);
  }

  void updateColor() {
    image = null;
    croppedFile = null;
    mainColor = tempMainColor;
    shadeColor = tempShadeColor;
    update([Constant.idSelectedColor,Constant.idSelectedImage]);
  }
}
