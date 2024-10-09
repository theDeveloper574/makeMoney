import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:makemoney/core/commen/app_utils.dart';
import 'package:makemoney/pages/accountsView/create_user_account.dart';
import 'package:makemoney/pages/home.dart';

class UserAccount extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isPhoneAuth = false;
  bool isVerifyingPhone = false;
  bool isVerifyingOpt = false;
  String? verId;
  String? phoneNum;

  ///authenticate with phone number
  Future<void> phoneAuth({required String phoneNumber}) async {
    isPhoneAuth = true;
    notifyListeners();
    _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (_) {
        isPhoneAuth = false;
        notifyListeners();
      },
      verificationFailed: (FirebaseException e) {
        AppUtils().toast(e.message.toString());
        isPhoneAuth = false;
        notifyListeners();
      },
      codeSent: (String verificationId, int? token) {
        isVerifyingPhone = true;
        verId = verificationId;
        phoneNum = phoneNumber;
        if (kDebugMode) {
          print(verId.toString());
          print(phoneNum.toString());
        }
        AppUtils().toast('Number Verified OTP send successfully');
        isPhoneAuth = false;
        notifyListeners();

        ///send verification ID
      },
      codeAutoRetrievalTimeout: (e) {
        // AppUtils().toast(e.toString());
        isPhoneAuth = false;
        notifyListeners();
      },
    );
    notifyListeners();
  }

  ///verify phone number
  Future<void> verifyPhoneNumber({
    required String verificationId,
    required String smsCode,
  }) async {
    isVerifyingOpt = true;
    notifyListeners();
    final credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    try {
      UserCredential userCre = await _auth.signInWithCredential(credential);
      User? user = userCre.user;
      if (user != null) {
        checkAccount(user);
      }
      isVerifyingOpt = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      isVerifyingOpt = false;

      AppUtils().toast(e.message.toString());
      notifyListeners();
    }
    notifyListeners();
  }

  Future<void> checkAccount(User user) async {
    final userDoc = await FirebaseFirestore.instance
        // .collection('users')
        .collection('futureInvestUsers')
        .doc(user.uid)
        .get();
    if (userDoc.exists) {
      AppUtils().toast("Login successfully.");
      Get.offAll(() => const HomePage());
    } else {
      AppUtils().toast("Please Create Account");
      Get.offAll(() => CrateUserAccount());
    }
    notifyListeners();
  }

  void disposeValue() {
    isPhoneAuth = false;
    isVerifyingPhone = false;
    isVerifyingOpt = false;
    verId = null;
    phoneNum = null;
    notifyListeners();
  }
}
