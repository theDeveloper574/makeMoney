import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:makemoney/pages/charts/sample_char.dart';
import 'package:makemoney/service/stateManagment/provider/user_account_provider.dart';
import 'package:provider/provider.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          flex: 2,
          child: SamoleChart(),
        ),
        SizedBox(width: Get.width * 0.004),
        Expanded(
            child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text(
                          " App Members",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Consumer<UserAccountProvider>(
                        builder: (context, value, child) {
                          if (value.users.isEmpty) {
                            return const Text(
                              "loading...",
                              style: TextStyle(fontSize: 12),
                            );
                          } else {
                            return Text(
                              value.users.length.toString(),
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Column(
                    children: [
                      const Text(
                        "Invest User",
                        textAlign: TextAlign.center,
                      ),
                      Consumer<UserAccountProvider>(
                        builder: (context, value, child) {
                          if (value.usersInvest.isEmpty) {
                            return Text(
                              value.usersInvest.length.toString(),
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          } else {
                            return Text(
                              value.usersInvest.length.toString(),
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20)
          ],
        )),
      ],
    );
  }
}
