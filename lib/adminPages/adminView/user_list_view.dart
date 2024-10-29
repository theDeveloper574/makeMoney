import 'package:flutter/material.dart';
import 'package:makemoney/adminPages/adminWidgets/user_card_widget.dart';
import 'package:provider/provider.dart';

import '../../service/model/user_model.dart';
import '../../service/stateManagment/provider/user_account_provider.dart';
import '../../widgets/listtile_shimmer_widget.dart';

class UserListViewAdmin extends StatelessWidget {
  const UserListViewAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    final getUser = Provider.of<UserAccountProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Users"),
      ),
      body: StreamBuilder(
        stream: getUser.loadUserAdmin(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const ListTileShimmerWidget();
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("no users found"));
          } else {
            List<UserModel> users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return UserCard(
                  user: users[index],
                );
              },
            );
          }
        },
      ),
    );
  }
}
