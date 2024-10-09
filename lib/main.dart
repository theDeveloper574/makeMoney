import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:makemoney/pages/home.dart';
import 'package:makemoney/service/stateManagment/provider/account_provider.dart';
import 'package:makemoney/service/stateManagment/provider/buy_sell_provider.dart';
import 'package:makemoney/service/stateManagment/provider/cu_user_provider.dart';
import 'package:makemoney/service/stateManagment/provider/deposit_provider.dart';
import 'package:makemoney/service/stateManagment/provider/fetch_task_provider.dart';
import 'package:makemoney/service/stateManagment/provider/market_provider.dart';
import 'package:makemoney/service/stateManagment/provider/mobile_course_provider.dart';
import 'package:makemoney/service/stateManagment/provider/user_account_provider.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
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
      ],
      child: GetMaterialApp(
        title: 'Future Invest',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
