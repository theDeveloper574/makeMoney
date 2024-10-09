import 'package:flutter/foundation.dart';

import '../../firestoreServices/deposit_service.dart';
import '../../model/deposit_model.dart';

class DepositProvider with ChangeNotifier {
  final DepositService _depositService = DepositService();
  // final List<DepositModel> _depositList = [];
  // final bool _isLoading = true;
  bool _isAdding = false; // New variable to track adding product state
  //
  // List<DepositModel> get depositList => _depositList;
  bool get isAdding => _isAdding; // Expose this for UI updates
// Add a new BuySell item with loading state
  Future<void> addDeposit(DepositModel model) async {
    _isAdding = true; // Start loading
    notifyListeners();
    await _depositService.addDeposit(model);
    _isAdding = false; // Stop loading
    notifyListeners();
    // fetchBuySell(); // Refresh the list after adding a new item
  }

  Stream<List<DepositModel>> getDepositStr() {
    return _depositService.getDeposit();
  }

  Stream<List<DepositModel>> getStrAdmin() {
    return _depositService.getDeposit();
  }

  Future<void> updateDepositForAdmin(DepositModel update, bool value) async {
    update.isApproved = value;
    await _depositService.updateDeposit(update);
  }

  Stream<List<DepositModel>> checkDeposit() {
    return _depositService.getDepositCheck();
  }

  // Fetch deposits as a Future instead of stream
  final List<DepositModel> _depositList = [];
  bool _isDepositLoading = true;

  List<DepositModel> get depositList => _depositList;
  bool get isDepositLoading => _isDepositLoading;
  Future<void> fetchDeposits() async {
    _isDepositLoading = true;
    notifyListeners();

    try {
      final deposits = await _depositService.getDeposits();
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
  Future<DepositModel?> getLastUserDeposit(String uid) async {
    try {
      final deposits = await _depositService.getDeposits();
      final userDeposits =
          deposits.where((deposit) => deposit.uid == uid).toList();
      if (userDeposits.isNotEmpty) {
        return userDeposits.last;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching last user deposit: $e');
      }
    }
    return null;
  }
}
