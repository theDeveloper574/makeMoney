import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
      child: Center(child: CircularProgressIndicator(color: Colors.blue)),
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

  Widget waitLoading() {
    return const SizedBox(
      height: 24,
      width: 24,
      child: CircularProgressIndicator(),
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
}
