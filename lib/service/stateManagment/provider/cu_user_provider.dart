import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:makemoney/core/commen/app_utils.dart';
import 'package:makemoney/service/firestoreServices/userService/user_service.dart';
import 'package:makemoney/service/model/user_model.dart';

import '../../../pages/home.dart';

class CuUserProvider extends ChangeNotifier {
  final UserService _userService = UserService();
  UserModel? _user;
  bool _isLoading = false;
  // Getters to expose user data and loading state
  UserModel? get user => _user;
  bool get isLoading => _isLoading;

  // Method to fetch a user by document ID
  Future<void> loadUser(String docId) async {
    _isLoading = true;
    // notifyListeners();
    try {
      UserModel? user = await _userService.getUser(docId);
      _user = user;
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching user: $e");
      }
    }
    _isLoading = false;
    notifyListeners();
  }

  // Method to add a new user
  Future<void> addUser(UserModel user) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _userService.addUser(user);
      _user = user; // Update user after adding
    } catch (e) {
      if (kDebugMode) {
        print("Error adding user: $e");
      }
    }

    _isLoading = false;
    notifyListeners(); // Notify that data has changed
  }

  // Method to update an existing user
  Future<void> updateUser(UserModel user) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _userService.updateUser(user);
      _user = user; // Update user after updating
    } catch (e) {
      if (kDebugMode) {
        print("Error updating user: $e");
      }
    }
    _isLoading = false;
    notifyListeners(); // Notify that data has changed
  }

  // Logout method: sets the user model to null
  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Here, you could clear any session tokens or perform other clean-up tasks
      // Firebase sign out
      await FirebaseAuth.instance.signOut();
      _user = null; // Set user to null to log out
    } catch (e) {
      if (kDebugMode) {
        print("Error during logout: $e");
      }
    }

    _isLoading = false;
    notifyListeners(); // Notify listeners that the user is logged out
  }

  Future<void> updateCu({
    required String docId,
    required int balance,
    required int coinBalance,
  }) async {
    try {
      await _userService.updateCustom(
        docId: docId,
        balance: balance,
        coinBalance: coinBalance,
      );
    } catch (e) {
      if (kDebugMode) {
        print('error $e');
      }
    }
    notifyListeners();
  }

  final _db = FirebaseFirestore.instance;
  Future<void> addToUserBalance({
    required String docId,
    required int depositAmount,
  }) async {
    // Get the current user balance and coin balance
    final DocumentSnapshot userDoc =
        await _db.collection('futureInvestUsers').doc(docId).get();

    if (userDoc.exists) {
      int currentBalance = userDoc['balance'] ?? 0;
      int currentCoinBalance = userDoc['coinBalance'] ?? 0;

      // Add the new deposit amount to the current balance and coin balance
      await _db.collection('futureInvestUsers').doc(docId).update({
        'paymentStatus': true,
        'balance': currentBalance + depositAmount,
        'coinBalance': currentCoinBalance + depositAmount,
      });
    } else {
      throw Exception("User document does not exist.");
    }
  }

  Future<void> subtractFromUserBalance({
    required String docId,
    required int withdrawAmount,
  }) async {
    // Get the current user balance and coin balance
    final DocumentSnapshot userDoc =
        await _db.collection('futureInvestUsers').doc(docId).get();

    if (userDoc.exists) {
      int currentBalance = userDoc['balance'] ?? 0;
      int currentCoinBalance = userDoc['coinBalance'] ?? 0;

      // Ensure there is enough balance for the withdrawal
      if (currentBalance >= withdrawAmount &&
          currentCoinBalance >= withdrawAmount) {
        // Subtract the withdraw amount from the current balance and coin balance
        await _db.collection('futureInvestUsers').doc(docId).update({
          'balance': currentBalance - withdrawAmount,
          'coinBalance': currentCoinBalance - withdrawAmount,
        });
      } else {
        throw Exception("Insufficient balance for withdrawal.");
      }
    } else {
      throw Exception("User document does not exist.");
    }
  }

  // Method to sign in with email and password
  Future<void> signInWithEmail(
      String email, String password, BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Sign in with email and password
      context.loaderOverlay.show();
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = await _userService.getUser(
        userCredential.user!.uid,
      );
      Get.offAll(() => const HomePage());
      AppUtils().toast("Login successfully");
      context.loaderOverlay.hide();
    } on FirebaseAuthException catch (e) {
      context.loaderOverlay.hide();
      AppUtils().toast(e.message.toString());
      if (kDebugMode) {
        print("Error signing in: $e");
      }
    }

    _isLoading = false;
    notifyListeners(); // Notify that data has changed
  }

  Future<void> signUpWithEmail(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Sign up with email and password
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Optionally, you can also set the display name or any other info
      await userCredential.user!
          .updateProfile(displayName: email.split('@')[0]);

      // Load the user from Firestore after creation (if necessary)
      _user = await _userService.getUser(userCredential.user!.uid);
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print("Error signing up: ${e.message}");
      }
    }
    _isLoading = false;
    notifyListeners(); // Notify that data has changed
  }
}
