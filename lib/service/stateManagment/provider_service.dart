import 'package:makemoney/service/stateManagment/provider/account_provider.dart';
import 'package:makemoney/service/stateManagment/provider/buy_sell_provider.dart';
import 'package:makemoney/service/stateManagment/provider/cu_user_provider.dart';
import 'package:makemoney/service/stateManagment/provider/deposit_provider.dart';
import 'package:makemoney/service/stateManagment/provider/fetch_task_provider.dart';
import 'package:makemoney/service/stateManagment/provider/market_provider.dart';
import 'package:makemoney/service/stateManagment/provider/mobile_course_provider.dart';
import 'package:makemoney/service/stateManagment/provider/user_account_provider.dart';
import 'package:makemoney/service/stateManagment/provider/withdraw_provider.dart';
import 'package:provider/provider.dart';

class AppProviderService {
  // Method to return all providers combined
  static List<ChangeNotifierProvider> getProviders() {
    return [
      ChangeNotifierProvider<UserAccount>(
        create: (_) => UserAccount(),
      ),
      ChangeNotifierProvider<CuUserProvider>(
        create: (_) => CuUserProvider(),
      ),
      ChangeNotifierProvider<UserAccountProvider>(
        create: (_) => UserAccountProvider(),
      ),
      ChangeNotifierProvider<BuySellProvider>(
        lazy: false,
        create: (_) => BuySellProvider(),
      ),
      ChangeNotifierProvider<MarketProvider>(
        lazy: false,
        create: (_) => MarketProvider(),
      ),
      ChangeNotifierProvider<TaskProvider>(
        lazy: false,
        create: (_) => TaskProvider(),
      ),
      ChangeNotifierProvider<MobileCourseProvider>(
        lazy: false,
        create: (_) => MobileCourseProvider(),
      ),
      ChangeNotifierProvider<DepositProvider>(
        lazy: false,
        create: (_) => DepositProvider(),
      ),
      ChangeNotifierProvider<WithdrawProvider>(
        lazy: false,
        create: (_) => WithdrawProvider(),
      ),
    ];
  }
}
