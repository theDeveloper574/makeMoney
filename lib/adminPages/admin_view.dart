import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:makemoney/adminPages/adminView/user_list_view.dart';
import 'package:makemoney/core/commen/app_utils.dart';
import 'package:makemoney/service/stateManagment/provider/fetch_task_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/admin_button_widget.dart';
import 'adminView/buy_sell_list_view.dart';
import 'adminView/mobile_app_list_view.dart';
import 'adminView/task_dialog_view.dart';
import 'adminView/transection_view.dart';
import 'adminView/withdraw_view.dart';

class AdminView extends StatefulWidget {
  const AdminView({super.key});

  @override
  State<AdminView> createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
  final linkCon = TextEditingController();
  final taskCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hello Admin"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AdminButton(
                  text: "Link & Task",
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return TaskUpdateView(
                          linkCon: linkCon,
                          taskCon: taskCon,
                          onSaved: () async {
                            final taskPro = Provider.of<TaskProvider>(
                              context,
                              listen: false,
                            );
                            String determinePlatform(String link) {
                              link = link
                                  .toLowerCase(); // Convert link to lowercase to avoid case sensitivity issues

                              if (link.contains('facebook.com') ||
                                  link.contains('fb.me')) {
                                return 'facebook';
                              } else if (link.contains('instagram.com') ||
                                  link.contains('instagr.am')) {
                                return 'instagram';
                              } else if (link.contains('youtube.com') ||
                                  link.contains('youtu.be')) {
                                return 'youtube';
                              } else if (link.contains('tiktok.com')) {
                                return 'tiktok';
                              } else {
                                return 'Unknown';
                              }
                            }

                            String platform = determinePlatform(linkCon.text);
                            if (platform == 'Unknown') {
                              AppUtils().toast("Platform is unknown");
                            } else {
                              await taskPro.updateLinkAndTask(
                                determinePlatform(linkCon.text),
                                linkCon.text,
                                newTask: taskCon.text,
                              );
                              AppUtils().toast("Link Updated $platform");
                              Get.back();
                            }
                          },
                        );
                      },
                    );
                  },
                ),
                AdminButton(
                  text: "Users List",
                  onPressed: () {
                    Get.to(() => const UserListViewAdmin());
                  },
                ),
              ],
            ),
            SizedBox(height: Get.height * 0.02),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AdminButton(
                  text: "Mobile App",
                  onPressed: () {
                    Get.to(() => const CourseRequestAdminWidget());
                  },
                ),
                AdminButton(
                  text: "Buy & Sale",
                  onPressed: () {
                    Get.to(() => const BuySellListView());
                  },
                ),
              ],
            ),
            SizedBox(height: Get.height * 0.02),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AdminButton(
                  bgColor: Colors.black,
                  text: "Withdraw List",
                  onPressed: () {
                    Get.to(() => const WithdrawAdminView());
                  },
                ),
                AdminButton(
                  bgColor: Colors.black,
                  text: "Transaction List",
                  onPressed: () {
                    Get.to(() => const TransactionView());
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
