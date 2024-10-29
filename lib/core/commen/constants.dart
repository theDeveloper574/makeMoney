import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String apiPath =
    "https://api.coingecko.com/api/v3/coins/markets?vs_currency=pkr&order=market_cap_desc&per_page=20&page=1&sparkline=false";

class AppColors {
  static Color blurColor = const Color(0xff6EACDA);
}

class LocalImg {
  static String quran = 'assets/icons/quran.png';
  static String app = 'assets/icons/mobile-app.png';
  static String business = 'assets/icons/business.png';
  static String shop = 'assets/icons/shopping.png';
  static String logo = 'assets/logo.jpg';

  static String graphic = 'assets/icons/graphic-icon.png';

  static String mobileApp = 'assets/icons/smartphone.png';
  static String dLogo = 'assets/icons/d-logo.png';

  static String whatsApp = 'assets/icons/whatsapp.png';

  static String freelance = 'assets/icons/freelancer.png';

  static String ar = 'assets/logos/ar.png';

  static String flowerLogo = 'assets/logos/flowers-com.jpg';
}

class AssetsImg {
  static String bismillah = 'assets/bismillah.png';
}

class AuthIcon {
  static String facebook = 'assets/auth-icons/facebook.png';

  static String google = 'assets/auth-icons/google.png';

  static String guest = 'assets/auth-icons/user.png';

  static String phone = 'assets/auth-icons/telephone.png';
}

class DateFormatter {
  // Method to format DateTime to a string
  static String formatDate(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  // Method to format a date string (assuming ISO 8601 format)
  static String formatDateString(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    return formatDate(dateTime);
  }
}
