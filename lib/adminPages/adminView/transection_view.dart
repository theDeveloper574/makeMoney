import 'package:flutter/material.dart';
import 'package:makemoney/core/commen/app_utils.dart';
import 'package:makemoney/service/model/deposit_model.dart';
import 'package:makemoney/widgets/listtile_shimmer_widget.dart';
import 'package:provider/provider.dart';

import '../../service/stateManagment/provider/cu_user_provider.dart';
import '../../service/stateManagment/provider/deposit_provider.dart';

class TransactionView extends StatelessWidget {
  const TransactionView({super.key});

  @override
  Widget build(BuildContext context) {
    final depositPro = Provider.of<DepositProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Transaction Admin Panel"),
      ),
      body: StreamBuilder<List<DepositModel>>(
        stream: depositPro.getStrAdmin(), // Stream to get data from Firebase
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const ListTileShimmerWidget();
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error loading transactions"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No transactions available"));
          }
          // Data is available, create a ListView with cards
          final transactions = snapshot.data!;
          return ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final transaction = transactions[index];
              return TransactionCard(transaction: transaction);
            },
          );
        },
      ),
    );
  }
}

// A custom widget for displaying each transaction as a card
class TransactionCard extends StatelessWidget {
  final DepositModel transaction;
  const TransactionCard({required this.transaction, super.key});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: transaction.isApproved!
          ? Colors.green.withOpacity(0.2)
          : Colors.red.withOpacity(0.1),
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        title: Text(
          'Name: ${transaction.name}',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(
              'Deposit Amount: Rs. ${transaction.depositAmount}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Phone Number: ${transaction.number}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'JazzCash Number: ${transaction.jazzCashNumber}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Date: ${transaction.createdAt?.toLocal().toString().split(' ')[0]}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Approved: ${transaction.isApproved == true ? "Yes" : "No"}',
              style: TextStyle(
                fontSize: 16,
                color:
                    transaction.isApproved == true ? Colors.green : Colors.red,
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
                    Provider.of<DepositProvider>(context, listen: false);
                if (transaction.isApproved!) {
                } else {
                  AppUtils().customDialog(
                    context: context,
                    onDone: () async {
                      await updateBalance.updateCu(
                        docId: transaction.uid!,
                        balance: transaction.depositAmount!,
                        coinBalance: transaction.depositAmount!,
                      );
                      await depositPro.updateDepositForAdmin(transaction, true);
                      AppUtils().toast('User Deposit Accepted.');
                    },
                    title: "Deposit Payment",
                    des: "accept the deposit",
                    onDoneTxt: 'yes',
                  );
                }
              },
              child: CircleAvatar(
                radius: 16,
                backgroundColor:
                    transaction.isApproved == true ? Colors.blue : Colors.grey,
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
