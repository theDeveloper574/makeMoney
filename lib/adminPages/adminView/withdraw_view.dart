import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:makemoney/core/commen/app_utils.dart';
import 'package:makemoney/service/model/withdraw_model.dart';
import 'package:makemoney/service/stateManagment/provider/withdraw_provider.dart';
import 'package:makemoney/widgets/listtile_shimmer_widget.dart';
import 'package:provider/provider.dart';

import '../../service/firestoreServices/withdraw_service.dart';
import '../../service/stateManagment/provider/cu_user_provider.dart';

class WithdrawAdminView extends StatelessWidget {
  const WithdrawAdminView({super.key});
  @override
  Widget build(BuildContext context) {
    final depositPro = Provider.of<WithdrawProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Withdraw Admin Panel"),
      ),
      body: StreamBuilder<List<WithdrawModel>>(
        stream: depositPro.getDepositStr(), // Stream to get data from Firebase
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const ListTileShimmerWidget();
          } else if (snapshot.hasError) {
            return Center(
                child: Text("Error loading withdraws ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No withdraws available"));
          }
          // Data is available, create a ListView with cards
          final withdraws = snapshot.data!;
          return ListView.builder(
            itemCount: withdraws.length,
            itemBuilder: (context, index) {
              final withdraw = withdraws[index];
              return WithdrawCard(withdraw: withdraw);
            },
          );
        },
      ),
    );
  }
}

// A custom widget for displaying each withdraw as a card
class WithdrawCard extends StatelessWidget {
  final WithdrawModel withdraw;
  WithdrawCard({
    required this.withdraw,
    super.key,
  });
  final withCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Card(
      color: withdraw.isApproved!
          ? Colors.green.withOpacity(0.2)
          : Colors.red.withOpacity(0.1),
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        title: Text(
          'Name: ${withdraw.name}',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(
              'Total Amount: Rs. ${withdraw.totalAmount!}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Withdraw Amount: Rs. ${withdraw.withdrawAmount}',
              style: TextStyle(
                fontSize: 16,
                decoration: withdraw.isApproved!
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Phone Number: ${withdraw.number}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'JazzCash Number: ${withdraw.jazzCashNumber}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Date: ${withdraw.createdAt?.toLocal().toString().split(' ')[0]}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Approved: ${withdraw.isApproved == true ? "Yes" : "No"}',
              style: TextStyle(
                fontSize: 16,
                color: withdraw.isApproved == true ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () async {
                final updateBalance =
                    Provider.of<CuUserProvider>(context, listen: false);
                final depositPro =
                    Provider.of<WithdrawProvider>(context, listen: false);
                if (withdraw.isApproved!) {
                } else {
                  AppUtils().customDialog(
                    controller: withCon,
                    isTextField: true,
                    context: context,
                    onDone: () async {
                      if (withCon.text.isNotEmpty) {
                        int enteredAmount =
                            int.parse(withCon.text); // Parse the entered amount
                        int depositAmount = withdraw.withdrawAmount!;
                        if (enteredAmount > depositAmount) {
                          AppUtils().toast(
                              "The entered amount cannot be greater than the deposit amount of $depositAmount");
                        } else {
                          await WithdrawService().withdrawNotification(
                            uid: withdraw.uid!,
                            amount: enteredAmount.toString(),
                          );
                          await depositPro.subtractFromUserBalance(
                            docId: withdraw.uid!,
                            withdrawAmount: enteredAmount,
                          );
                          await depositPro.updateDepositForAdmin(
                            withdraw,
                            true,
                          );
                          Get.back();
                          AppUtils().toast('User Withdraw Accepted.');
                        }
                      } else {
                        AppUtils().toast("Please enter a valid amount");
                      }
                    },
                    title: "Withdraw Payment",
                    des: "accept the Withdraw",
                    onDoneTxt: 'yes',
                  );
                }
              },
              child: CircleAvatar(
                radius: 16,
                backgroundColor:
                    withdraw.isApproved == true ? Colors.blue : Colors.grey,
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
