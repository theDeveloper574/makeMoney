import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:makemoney/core/commen/app_utils.dart';
import 'package:provider/provider.dart';

import '../../service/model/user_model.dart';
import '../../service/stateManagment/provider/user_account_provider.dart';
import '../../service/stateManagment/provider/withdraw_provider.dart';
import '../../widgets/image_view.dart';

class UserCard extends StatelessWidget {
  final UserModel user;
  UserCard({super.key, required this.user});
  final amount = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final adminPro = Provider.of<UserAccountProvider>(context, listen: false);
    final balance = Provider.of<WithdrawProvider>(context, listen: false);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: user.isDeleted
          ? Colors.red.withOpacity(0.2)
          : Colors.green.withOpacity(0.2),
      elevation: 0,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: InkWell(
          onTap: () {
            Get.to(
              () => ImageViewWidget(image: user.profileUrl!),
            );
          },
          child: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey[300], // Placeholder background color
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl:
                    user.profileUrl ?? '', // If profileUrl is null, handle it
                placeholder: (context, url) =>
                    const CircularProgressIndicator(color: Colors.black),
                errorWidget: (context, url, error) => Image.asset(
                  'assets/logos/placeholder.jpg', // Fallback image on error
                  fit: BoxFit.cover,
                ),
                fit: BoxFit.cover,
                width: 60,
                height: 60,
              ),
            ),
          ),
        ),
        title: Text(
          user.name ?? 'Unknown User',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.phone, size: 12, color: Colors.grey),
                const SizedBox(width: 6),
                Text(
                  user.phoneNumber ?? 'No Phone',
                  style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                      fontWeight: FontWeight.w800),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Text(
                  'Created on: ${user.createdAt != null ? user.createdAt!.toLocal().toString().split(' ')[0] : 'N/A'}',
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
            Row(
              children: [
                const Text("Balance: "),
                Text(user.balance.toString()),
              ],
            ),
            Row(
              children: [
                const Text("Payment Status: "),
                Text(
                  user.paymentStatus ? 'Accepted' : "Pending",
                  style: TextStyle(
                    color: user.paymentStatus ? Colors.black : Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () async {
                AppUtils().customDialog(
                  controller: amount,
                  isTextField: true,
                  context: context,
                  onDone: () async {
                    balance.giveBalance(
                      docId: user.uid!,
                      balance: int.parse(amount.text),
                    );
                    Get.back();
                    AppUtils().toast("Balance added");
                  },
                  title: "Give Balance",
                  des: 'Give Balance',
                  onDoneTxt: 'yes',
                );
              },
              child: const Icon(Icons.attach_money),
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () async {
                if (user.isDeleted) {
                  AppUtils().customDialog(
                    context: context,
                    onDone: () async {
                      bool setDel = user.isDeleted = false;
                      await adminPro.deleteUsr(user, setDel);
                      AppUtils().toast('un-blocked account');
                      Get.back();
                    },
                    title: "Un-block Account",
                    des: "un-block this account",
                    onDoneTxt: "yes",
                  );
                } else {
                  AppUtils().customDialog(
                    context: context,
                    onDone: () async {
                      bool setDel = user.isDeleted = true;
                      await adminPro.deleteUsr(user, setDel);
                      AppUtils().toast('account blocked');
                      Get.back();
                    },
                    title: "Account block",
                    des: "block this account",
                    onDoneTxt: "yes",
                  );
                }
              },
              child: const Icon(Icons.delete),
            ),
            Icon(
              user.isDeleted ? Icons.block : Icons.check_circle,
              color: user.isDeleted ? Colors.red : Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}
