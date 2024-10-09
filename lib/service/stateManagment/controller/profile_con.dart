import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileCon extends GetxController {
  RxString imagePath = "".obs;
  XFile? imagePa;

  ///image pick from gallery
  Future pickImageGall() async {
    final img = await ImagePicker().pickImage(
        source: ImageSource.gallery, maxHeight: 1000, maxWidth: 1000);
    if (img != null) {
      imagePa = img;
      imagePath.value = imagePa!.path.toString();
    } else {
      Get.snackbar(
        "Future Invest",
        "No image selected",
        titleText: const Text(
          "Future Invest",
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
        backgroundColor: Colors.black,
      );
    }
    update();
  }

  ///image pick from camera
  Future pickImageCam() async {
    final img = await ImagePicker()
        .pickImage(source: ImageSource.camera, maxHeight: 1000, maxWidth: 1000);
    if (img != null) {
      imagePa = img;
      imagePath.value = imagePa!.path.toString();
    } else {
      Get.snackbar(
        "Future Invest",
        "No image selected",
        titleText: const Text(
          "Future Invest",
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
        backgroundColor: Colors.black,
      );
    }
    update();
  }
}
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
//
// class ProfileCon extends GetxController {
//   RxString imagePath = ''.obs;
//   XFile? imagePa;
//
//   /// Image pick from gallery
//   Future<void> pickImageGall() async {
//     final img = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (img != null) {
//       imagePa = img;
//       imagePath.value = imagePa!.path; // Store path
//     } else {
//       _showSnackbar("No image selected");
//     }
//   }
//
//   /// Image pick from camera
//   Future<void> pickImageCam() async {
//     final img = await ImagePicker().pickImage(source: ImageSource.camera);
//     if (img != null) {
//       imagePa = img;
//       imagePath.value = imagePa!.path; // Store path
//     } else {
//       _showSnackbar("No image selected");
//     }
//   }
//
//   void _showSnackbar(String message) {
//     Get.snackbar(
//       "Future Invest",
//       message,
//       titleText: const Text(
//         "Future Invest",
//         style: TextStyle(color: Colors.white),
//       ),
//       messageText: const Text(
//         "No Image Selected",
//         style: TextStyle(color: Colors.white),
//       ),
//       backgroundColor: Colors.black,
//     );
//   }
// }
