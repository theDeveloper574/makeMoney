import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class AppUtils {
  Future<void> toast(String msg) async {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static Widget loadingWid() {
    return const SizedBox(
      height: 2,
      width: 2,
      child: Center(
        child: CircularProgressIndicator(color: Colors.blue),
      ),
    );
  }

  ///generate 5 number random
  String generateFormattedString() {
    DateTime now = DateTime.now();
    String year = now.year.toString();
    String month = now.month.toString().padLeft(2, '0');
    String day = now.day.toString().padLeft(2, '0');
    int randomFiveDigitNumber = generateRandomFiveDigitNumber();

    return '$year-$month-$day-$randomFiveDigitNumber';
  }

  int generateRandomFiveDigitNumber() {
    Random random = Random();
    return 10000 + random.nextInt(90000); // 10000 + (0 to 89999)
  }

  Widget waitLoading({Color? color}) {
    return SizedBox(
      height: 24,
      width: 24,
      child: CircularProgressIndicator(
        color: color ?? Colors.white,
      ),
    );
  }

  Widget networkChaImage(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50.0), // Circular border
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (context, url) => AppUtils().waitLoading(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        width: 40, // Adjust the size as needed
        height: 40,
        fit: BoxFit.cover,
      ),
    );
  }

  Future<void> copyText(String text) async {
    await Clipboard.setData(
      ClipboardData(text: text),
    );
    Get.snackbar(
      'Future Invest',
      'متن کلپ بورڈ پر کاپی ہو گیا۔',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.black,
      colorText: Colors.white,
    );
  }

  SnackbarController snackBarUtil(String message) {
    return Get.snackbar(
      'Future Invest',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.black,
      colorText: Colors.white,
    );
  }

  // Function to show the dialog
  void exitDialog(BuildContext context, Function() onLogout) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Logout"),
          content: const Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(); // Close the dialog without any action
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: onLogout,
              child: const Text("Logout"),
            ),
          ],
        );
      },
    );
  }

  void customDialog({
    required BuildContext context,
    required Function() onDone,
    String? balance,
    required String title,
    required String des,
    required String onDoneTxt,
    TextEditingController? controller,
    bool isTextField = false,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(
                "Rs.$balance" ?? '0',
                style: const TextStyle(fontSize: 14),
              )
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Are you sure you want to $des?"),
              if (isTextField) const SizedBox(height: 10),
              if (isTextField)
                TextField(
                  controller: controller, // Attach controller
                  keyboardType: TextInputType.number, // Accept only numbers
                  decoration: const InputDecoration(
                    labelText: "Enter Deposit Amount",
                  ),
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              //   onPressed: onDone,
              onPressed: () {
                if (isTextField &&
                    (controller == null || controller.text.isEmpty)) {
                  AppUtils().toast(
                      "Please enter an amount"); // Show message if no amount entered
                } else {
                  onDone(); // Call onDone only if valid input
                }
              },
              child: Text(onDoneTxt),
            ),
          ],
        );
      },
    );
  }
}
