import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:makemoney/service/model/withdraw_model.dart';
import 'package:makemoney/service/stateManagment/provider/withdraw_provider.dart';
import 'package:provider/provider.dart';

import '../../core/commen/app_utils.dart';
import '../../service/model/user_model.dart';
import '../../service/stateManagment/provider/cu_user_provider.dart';
import '../../widgets/text_field_widget.dart';

class WithdrawView extends StatefulWidget {
  final UserModel? userModel;
  const WithdrawView({super.key, this.userModel});

  @override
  State<WithdrawView> createState() => _WithdrawViewState();
}

class _WithdrawViewState extends State<WithdrawView> {
  final amountCon = TextEditingController();
  bool isCompleted = false;
  int? withdrawAmount;
  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.blue,
          title: const Text(
            "Withdraw",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            const Text(
              "Total Rupees: ",
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
            Consumer<CuUserProvider>(builder: (context, value, child) {
              return Text(
                "${value.user?.balance ?? 0}",
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              );
            }),
            const SizedBox(width: 24),
          ],
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
                  await handleWithdraw();
                },
                child: const Text(
                  "Submit Request",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> handleWithdraw() async {
    // Check if the amount input is empty
    if (amountCon.text.isEmpty) {
      AppUtils().toast('براہ کرم رقم درج کریں'); // "Please enter the amount."
      return;
    }

    // Check if the user’s balance is less than 300
    if (widget.userModel!.balance! < 300) {
      AppUtils().snackBarUtil(
          'رقم 300 سے کم نہیں ہو سکتی'); // "The amount cannot be less than 300."
      return;
    }

    // Try to parse the entered amount to double
    double? amount;
    try {
      amount = double.parse(amountCon.text);
    } catch (e) {
      AppUtils().toast(
        'براہ کرم درست رقم درج کریں',
      ); // "Please enter a valid amount."
      return;
    }

    // Validate if the parsed amount is less than 300
    if (amount < 300) {
      AppUtils().toast(
        'رقم 300 سے کم نہیں ہو سکتی',
      ); // "The amount cannot be less than 300."
      return;
    }
    // Check if the withdrawal amount is greater than the available balance
    if (amount > widget.userModel!.balance!) {
      AppUtils().toast(
          'رقم دستیاب بیلنس سے زیادہ نہیں ہو سکتی'); // "The amount cannot exceed the available balance."
      return;
    }

    // Proceed with withdrawal if the amount is valid
    withdrawAmount = amount.toInt(); // Convert the double amount to an integer
    context.loaderOverlay.show(); // Show a loading overlay during processing

    // Generate a document ID for the transaction
    String docId = AppUtils().generateFormattedString();

    // Get the WithdrawProvider instance
    final withdrawPro = Provider.of<WithdrawProvider>(context, listen: false);
    final userPro = Provider.of<CuUserProvider>(context, listen: false);

    // Create a new WithdrawModel with the necessary data
    WithdrawModel model = WithdrawModel(
      isApproved: false, // Set approval status as false initially
      name: widget.userModel!.name,
      jazzCashNumber: widget.userModel!.accountNumber,
      totalAmount: widget.userModel!.balance,
      withdrawAmount:
          withdrawAmount, // Withdrawal amount (already converted to int)
      createdAt: DateTime.now(), // Set current time
      number: widget.userModel!.phoneNumber,
      uid: widget.userModel!.uid,
      docId: docId, // Unique document ID for the transaction
    );
    // Add the withdrawal request to the database

    await userPro.loadUser(widget.userModel!.uid!);
    await withdrawPro.addDeposit(model);
    // Hide the loading overlay once the request is done
    context.loaderOverlay.hide();
    AppUtils().toast(
      'Request Submitted Please wait for the admin to approved\nدرخواست جمع کرائی گئی براہ کرم منتظم کے منظور ہونے کا انتظار کریں۔',
    );
    Get.back();
  }
}
