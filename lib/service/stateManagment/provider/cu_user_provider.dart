import 'package:cloud_firestore/cloud_firestore.dart';
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
  //final updateBalance = Provider.of<CuUserProvider>(context, listen: false);
// final withdrawPro = Provider.of<WithdrawProvider>(context, listen: false);
//
// AppUtils().customDialog(
//   context: context,
//   onDone: () async {
//     // Subtract the withdrawal amount from user's balance
//     await updateBalance.subtractFromUserBalance(
//       docId: transaction.uid!,
//       withdrawAmount: transaction.withdrawAmount!,
//     );
//     await withdrawPro.updateWithdrawForAdmin(transaction, true);
//     AppUtils().toast('User Withdrawal Accepted.');
//     Get.back();
//   },
//   title: "Withdraw Payment",
//   des: "approve the withdrawal",
//   onDoneTxt: 'yes',
// );
}
