import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileCon extends GetxController {
  RxString imagePath = "".obs;
  XFile? imagePa;

  ///image pick from gallery
  Future pickImageGall() async {
    final img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img != null) {
      imagePa = img;
      imagePath.value = imagePa!.path.toString();
    } else {
      Get.snackbar(
        "Medicine Reminder",
        "No image selected",
        titleText: const Text(
          "Medicine Reminder",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        messageText: const Text(
          "No Image Selected",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.white,
      );
    }
    update();
  }

  ///image pick from camera
  Future pickImageCam() async {
    final img = await ImagePicker().pickImage(source: ImageSource.camera);
    if (img != null) {
      imagePa = img;
      imagePath.value = imagePa!.path.toString();
    } else {
      Get.snackbar(
        "Medicine Reminder",
        "No image selected",
        titleText: const Text(
          "Medicine Reminder",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        messageText: const Text(
          "No Image Selected",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.white,
      );
    }
    update();
  }
}
