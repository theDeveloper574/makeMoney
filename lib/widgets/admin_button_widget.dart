import 'package:flutter/material.dart';
import 'package:makemoney/service/model/user_model.dart';
import 'package:makemoney/service/model/withdraw_model.dart';
import 'package:makemoney/service/stateManagment/provider/withdraw_provider.dart';
import 'package:provider/provider.dart';

import '../service/model/deposit_model.dart';
import '../service/stateManagment/provider/deposit_provider.dart';
import '../service/stateManagment/provider/user_account_provider.dart';

class AdminButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? bgColor;

  const AdminButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor ?? Colors.blue,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ), // Padding
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30), // Rounded corners
          ),
        ),
        child: Text(
          text, // Button label
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ), // Text styling
        ),
      ),
    );
  }
}

class AdminButtonWithBadge extends StatelessWidget {
  final VoidCallback onPressed;
  // final DepositService _depositService;

  const AdminButtonWithBadge({
    super.key,
    required this.onPressed,
    // required DepositService depositService,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DepositProvider>(context, listen: false);
    return StreamBuilder<List<DepositModel>>(
      stream: provider.getDepositStrFal(), // Subscribe to deposit stream
      builder: (context, snapshot) {
        // Handle loading state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Show loading spinner
        }
        // Handle error state
        if (snapshot.hasError) {
          return const Icon(Icons.error); // Handle error
        }
        // Get the list of deposits
        final deposits = snapshot.data ?? [];
        // Count unapproved deposits
        final unapprovedCount =
            deposits.where((deposit) => !deposit.isApproved!).length;
        return IconButton(
          onPressed: onPressed,
          icon: Badge.count(
            isLabelVisible: true,
            count: unapprovedCount, // Update count based on unapproved deposits
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black,
              ),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Transactions', // Your button text
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

///withdraw button

class AdminButtonWithBadgeWith extends StatelessWidget {
  final VoidCallback onPressed;
  // final DepositService _depositService;

  const AdminButtonWithBadgeWith({
    super.key,
    required this.onPressed,
    // required DepositService depositService,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WithdrawProvider>(context, listen: false);
    return StreamBuilder<List<WithdrawModel>>(
      stream: provider.getDepositStrFal(), // Subscribe to deposit stream
      builder: (context, snapshot) {
        // Handle loading state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Show loading spinner
        }
        // Handle error state
        if (snapshot.hasError) {
          return const Icon(Icons.error); // Handle error
        }
        // Get the list of deposits
        final deposits = snapshot.data ?? [];
        // Count unapproved deposits
        final unapprovedCount =
            deposits.where((deposit) => !deposit.isApproved!).length;
        return IconButton(
          onPressed: onPressed,
          icon: Badge.count(
            isLabelVisible: true,
            count: unapprovedCount, // Update count based on unapproved deposits
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black,
              ),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Withdraws', // Your button text
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

///users button

class AdminButtonUsersBadgeUser extends StatelessWidget {
  final VoidCallback onPressed;
  // final DepositService _depositService;

  const AdminButtonUsersBadgeUser({
    super.key,
    required this.onPressed,
    // required DepositService depositService,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserAccountProvider>(context, listen: false);
    return StreamBuilder<List<UserModel>>(
      stream: provider.loadUserAdminFal(), // Subscribe to deposit stream
      builder: (context, snapshot) {
        // Handle loading state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Show loading spinner
        }
        // Handle error state
        if (snapshot.hasError) {
          return const Icon(Icons.error); // Handle error
        }
        // Get the list of deposits
        final deposits = snapshot.data ?? [];
        // Count unapproved deposits
        final unapprovedCount =
            deposits.where((deposit) => !deposit.paymentStatus).length;
        return IconButton(
          onPressed: onPressed,
          icon: Badge.count(
            isLabelVisible: true,
            count: unapprovedCount, // Update count based on unapproved deposits
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black,
              ),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Users', // Your button text
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
