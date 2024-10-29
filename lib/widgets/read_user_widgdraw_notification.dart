import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../pages/views/payment_receive_view.dart';

class NotificationsBadge extends StatelessWidget {
  const NotificationsBadge({super.key});

  @override
  Widget build(BuildContext context) {
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('widrawNotification')
          .where('uid',
              isEqualTo: currentUserId) // Filter by current user's UID
          .where('isRead', isEqualTo: false) // Filter unread notifications
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return IconButton(
            onPressed: () {
              Get.to(() => const PaymentReceiveView());
            },
            icon: Badge.count(
              isLabelVisible: false,
              count: 0, // Show 0 until data is available
              child: const Icon(Icons.notifications),
            ),
          );
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return IconButton(
            onPressed: () {
              Get.to(() => const PaymentReceiveView());
            },
            icon: Badge.count(
              isLabelVisible: false,
              count: 0, // No unread notifications
              child: const Icon(Icons.notifications),
            ),
          );
        }
        // Get the unread notifications count
        int unreadCount = snapshot.data!.docs.length;
        return IconButton(
          onPressed: () {
            Get.to(() => const PaymentReceiveView());
          },
          icon: Badge.count(
            count: unreadCount, // Dynamic unread count
            child: const Icon(Icons.notifications),
          ),
        );
      },
    );
  }
}
