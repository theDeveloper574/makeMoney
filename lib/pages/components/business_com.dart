import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:makemoney/core/commen/constants.dart';
import 'package:makemoney/pages/accountsView/create_user_account.dart';
import 'package:makemoney/pages/accountsView/phone_auth.dart';
import 'package:makemoney/pages/views/chat_view.dart';
import 'package:makemoney/pages/views/cu_user_profile_view.dart';
import 'package:makemoney/service/stateManagment/provider/user_provider.dart';
import 'package:makemoney/widgets/boxes.dart';
import 'package:makemoney/widgets/container_widget.dart';
import 'package:provider/provider.dart';

import '../views/chat_user_view.dart';

class BusinessCom extends StatefulWidget {
  const BusinessCom({super.key});

  @override
  State<BusinessCom> createState() => _BusinessComState();
}

class _BusinessComState extends State<BusinessCom> {
  @override
  void initState() {
    final userPro = Provider.of<UserProvider>(context, listen: false);
    User? cuUid = FirebaseAuth.instance.currentUser;
    if (cuUid != null) {
      userPro.loadUser(cuUid.uid);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Business"),
        actions: [
          Consumer<UserProvider>(builder: (context, value, child) {
            if (value.user != null) {
              return InkWell(
                onTap: () {
                  Get.to(
                    () => UserProfile(
                      userModel: value.user!,
                    ),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.0),
                  child: Icon(
                    Icons.person,
                    size: 30,
                  ),
                ),
              );
            } else {
              return const SizedBox();
            }
          })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ConatinerWidget(),
            SizedBox(height: Get.height * 0.01),
            const ChatView(),
            SizedBox(height: Get.height * 0.01),
            const ChatUserView(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Boxes(
                  text2: 'Facebook',
                  image: AuthIcon.facebook,
                ),
                Boxes(
                  text2: 'Phone',
                  image: AuthIcon.phone,
                  onTap: () {
                    Get.to(() => const PhoneAuthView());
                  },
                ),
                Boxes(
                  text2: 'Google',
                  image: AuthIcon.google,
                  onTap: () {
                    Get.to(() => CrateUserAccount());
                  },
                ),
                Boxes(
                  text2: 'Guest',
                  image: AuthIcon.guest,
                  onTap: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
