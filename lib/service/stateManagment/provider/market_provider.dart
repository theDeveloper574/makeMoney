import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:makemoney/service/firestoreServices/social_service.dart';

import '../../model/market_model.dart';

class MarketProvider extends ChangeNotifier {
  bool isLoading = true;
  List<CryptoCurrencyModel> markets = [];

  MarketProvider() {
    getData();
  }
  Future<void> getData() async {
    List<dynamic> _markets = await SocialService.getMarkets();
    List<CryptoCurrencyModel> temp = [];
    for (var market in _markets) {
      CryptoCurrencyModel newCrypto = CryptoCurrencyModel.fromJSON(market);
      temp.add(newCrypto);
    }
    markets = temp;
    isLoading = false;
    notifyListeners();
  }
}
