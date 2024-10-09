import 'package:flutter/material.dart';

import '../../firestoreServices/buy_sell_service.dart';
import '../../model/buy_sell_model.dart';

class BuySellProvider with ChangeNotifier {
  final BuySellService _buySellService = BuySellService();
  List<BuySellModel> _buySellList = [];
  bool _isLoading = true;
  bool _isAdding = false; // New variable to track adding product state

  List<BuySellModel> get buySellList => _buySellList;
  bool get isLoading => _isLoading;
  bool get isAdding => _isAdding; // Expose this for UI updates

// Fetch BuySell data and notify listeners
//   void fetchBuySell() {
//     _buySellService.getBuySell().listen((buySellData) {
//       _buySellList = buySellData;
//       _isLoading = false;
//       notifyListeners(); // Notify listeners to update the UI
//     });
//   }

// Add a new BuySell item with loading state
  Future<void> addBuySell(BuySellModel model) async {
    _isAdding = true; // Start loading
    notifyListeners();
    await _buySellService.addBuySell(model);
    _isAdding = false; // Stop loading
    notifyListeners();
    // fetchBuySell(); // Refresh the list after adding a new item
  }

  Stream<List<BuySellModel>> gteStre() {
    return _buySellService.getBuySell();
  }

  Stream<List<BuySellModel>> gteStreAdmin() {
    return _buySellService.getBuySellAdmin();
  }

  Future<void> updateforAdmin(BuySellModel update, bool value) async {
    update.isDeleted = value;
    await _buySellService.updateTheBuySell(update);
  }
}
