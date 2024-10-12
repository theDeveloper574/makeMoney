import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:makemoney/core/commen/constants.dart';
import 'package:makemoney/pages/accountsView/create_user_account.dart';
import 'package:makemoney/pages/accountsView/phone_auth.dart';
import 'package:makemoney/pages/views/chat_view.dart';
import 'package:makemoney/pages/views/cu_user_profile_view.dart';
import 'package:makemoney/service/stateManagment/provider/cu_user_provider.dart';
import 'package:makemoney/widgets/boxes.dart';
import 'package:provider/provider.dart';

import '../../core/commen/app_utils.dart';
import '../../service/stateManagment/provider/fetch_task_provider.dart';
import '../../widgets/binance_ad_widget.dart';
import '../views/chat_user_view.dart';

class BusinessCom extends StatefulWidget {
  const BusinessCom({super.key});

  @override
  State<BusinessCom> createState() => _BusinessComState();
}

class _BusinessComState extends State<BusinessCom> {
  @override
  void initState() {
    final userPro = Provider.of<CuUserProvider>(context, listen: false);
    final taskPro = Provider.of<TaskProvider>(context, listen: false);
    User? cuUid = FirebaseAuth.instance.currentUser;
    if (cuUid != null) {
      userPro.loadUser(cuUid.uid);
      taskPro.getSocialLinks();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Business"),
        actions: [
          Consumer<CuUserProvider>(builder: (context, value, child) {
            if (value.user != null) {
              return InkWell(
                onTap: () {
                  final userPro =
                      Provider.of<CuUserProvider>(context, listen: false);
                  final taskPro =
                      Provider.of<TaskProvider>(context, listen: false);
                  User? cuUid = FirebaseAuth.instance.currentUser;
                  if (cuUid != null) {
                    userPro.loadUser(cuUid.uid);
                    taskPro.getSocialLinks();
                  }
                  Get.to(
                    () => UserProfile(
                      userModel: value.user!,
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: value.user!.profileUrl.toString(),
                      placeholder: (context, url) =>
                          AppUtils().waitLoading(color: Colors.black),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
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
            const BinanceAdWidget(),
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
