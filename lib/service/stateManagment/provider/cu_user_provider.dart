import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:makemoney/service/firestoreServices/userService/user_service.dart';
import 'package:makemoney/service/model/user_model.dart';

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
}
