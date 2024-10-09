import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../../core/commen/constants.dart';

class SocialService {
  Future<void> launchSocialLink(String platform) async {
    try {
      // Fetch the document based on the platform name
      var docSnapshot = await FirebaseFirestore.instance
          .collection('socialLinks')
          .doc(platform.toLowerCase())
          .get();
      if (docSnapshot.exists) {
        var data = docSnapshot.data()!;
        String? url = data['link']; // Assuming each document has a 'link' field

        if (url != null && await canLaunchUrl(Uri.parse(url))) {
          await launchUrl(Uri.parse(url));
        } else {
          Get.snackbar(
            'Error',
            'Invalid or missing URL for $platform',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.black,
            colorText: Colors.white,
          );
        }
      } else {
        Get.snackbar(
          'Error',
          'No link found for $platform',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to fetch the link',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black,
        colorText: Colors.white,
      );
    }
  }

  static Future<List<dynamic>> getMarkets() async {
    Uri reqPath = Uri.parse(apiPath);
    try {
      var response = await http.get(reqPath);
      var decodeRes = jsonDecode(response.body);
      // print('res body');
      // print(decodeRes);
      List<dynamic> markets = decodeRes as List<dynamic>;
      return markets;
    } catch (e) {
      // print('value api called');
      // print(e.toString());
      return [];
    }
  }

  Future<void> launchTask(String? url, String platform) async {
    if (url != null && await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      Get.snackbar(
        'Error',
        'Invalid or missing URL for $platform',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black,
        colorText: Colors.white,
      );
    }
  }
}
