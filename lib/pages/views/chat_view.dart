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
        SizedBox(width: Get.width * 0.01),
        Expanded(
          child: Column(
            children: [
              const Text(" App Members"),
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
        ),
      ],
    );
  }
}
