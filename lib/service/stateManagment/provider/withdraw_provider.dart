import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:makemoney/service/firestoreServices/withdraw_service.dart';

import '../../model/withdraw_model.dart';

class WithdrawProvider with ChangeNotifier {
  final WithdrawService _depositService = WithdrawService();
  // final List<WithdrawModel> _depositList = [];
  // final bool _isLoading = true;
  bool _isAdding = false; // New variable to track adding product state
  //
  // List<WithdrawModel> get depositList => _depositList;
  bool get isAdding => _isAdding; // Expose this for UI updates
// Add a new BuySell item with loading state
  Future<void> addDeposit(WithdrawModel model) async {
    _isAdding = true; // Start loading
    notifyListeners();
    await _depositService.addWithdraw(model);
    _isAdding = false; // Stop loading
    notifyListeners();
    // fetchBuySell(); // Refresh the list after adding a new item
  }

  Stream<List<WithdrawModel>> getDepositStr() {
    return _depositService.getWithdraw();
  }

  Stream<List<WithdrawModel>> getStrAdmin() {
    return _depositService.getWithdraw();
  }

  Future<void> updateDepositForAdmin(WithdrawModel update, bool value) async {
    update.isApproved = value;
    await _depositService.updateWithdraw(update);
  }

  Stream<List<WithdrawModel>> checkDeposit() {
    return _depositService.getWithdrawCheck();
  }

  // Fetch deposits as a Future instead of stream
  final List<WithdrawModel> _depositList = [];
  bool _isDepositLoading = true;

  List<WithdrawModel> get depositList => _depositList;
  bool get isDepositLoading => _isDepositLoading;
  Future<void> fetchDeposits() async {
    _isDepositLoading = true;
    notifyListeners();

    try {
      final deposits = await _depositService.getWithdraws();
      _depositList.clear();
      _depositList.addAll(deposits);
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching deposits: $e');
      }
    } finally {
      _isDepositLoading = false;
      notifyListeners();
    }
  }

  // Get the user's last deposit and check approval status
  // Future<WithdrawModel?> getLastUserDeposit(String uid) async {
  //   try {
  //     final deposits = await _depositService.getWithdraws();
  //     final userDeposits =
  //         deposits.where((deposit) => deposit.uid == uid).toList();
  //     if (userDeposits.isNotEmpty) {
  //       return userDeposits.last;
  //     }
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print('Error fetching last user deposit: $e');
  //     }
  //   }
  //   return null;
  // }
  Future<WithdrawModel?> getLastApprovedUserWithdraw(String uid) async {
    try {
      final deposits = await _depositService.getWithdraws();

      // Filter only approved deposits for the user
      final userApprovedDeposits = deposits
          .where((deposit) => deposit.uid == uid && deposit.isApproved == false)
          .toList();

      // Sort deposits by createdAt in descending order (latest first)
      userApprovedDeposits.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

      // Return the latest approved deposit
      if (userApprovedDeposits.isNotEmpty) {
        return userApprovedDeposits
            .first; // Fetches the most recent approved deposit
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching last approved user deposit: $e');
      }
    }
    return null;
  }

  Future<void> withDrawNotification({
    required String amount,
    required String uid,
  }) async {
    _depositService.withdrawNotification(
      amount: amount,
      uid: uid,
    );
  }

  final _db = FirebaseFirestore.instance;
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
}
