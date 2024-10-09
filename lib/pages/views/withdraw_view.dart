import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/commen/app_utils.dart';
import '../../widgets/text_field_widget.dart';

class WithdrawView extends StatefulWidget {
  const WithdrawView({super.key});

  @override
  State<WithdrawView> createState() => _WithdrawViewState();
}

class _WithdrawViewState extends State<WithdrawView> {
  final amountCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Withdraw",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/plant.png',
              height: 160,
            ),

            const SizedBox(height: 16),
            const Text(
              "Withdraw Money",
              style: TextStyle(fontSize: 22),
            ), // This will show a gray box where content will go
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width / 6),
              child: TextFieldWidget(
                keyboardType: TextInputType.number,
                hintText: "Please Enter Amount",
                controller: amountCon,
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                if (double.parse(amountCon.text) < 100) {
                  AppUtils().snackBarUtil("رقم 100 سے کم نہیں ہو سکتی");
                } else {}
              },
              child: const Text(
                "Submit Request",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
