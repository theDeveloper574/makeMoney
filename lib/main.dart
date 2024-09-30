import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:makemoney/pages/home.dart';
import 'package:makemoney/service/stateManagment/provider/account_provider.dart';
import 'package:makemoney/service/stateManagment/provider/user_account_provider.dart';
import 'package:makemoney/service/stateManagment/provider/user_provider.dart';
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
        ChangeNotifierProvider<UserProvider>(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider<UserAccountProvider>(
          create: (_) => UserAccountProvider(),
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
