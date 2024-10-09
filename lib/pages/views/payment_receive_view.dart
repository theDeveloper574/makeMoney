import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PaymentReceiveView extends StatefulWidget {
  const PaymentReceiveView({super.key});

  @override
  PaymentReceiveViewState createState() => PaymentReceiveViewState();
}

class PaymentReceiveViewState extends State<PaymentReceiveView> {
  @override
  void initState() {
    super.initState();
    markNotificationsAsRead();
  }

  // Function to mark all unread notifications as read
  void markNotificationsAsRead() async {
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;
    var unreadNotifications = await FirebaseFirestore.instance
        .collection('widrawNotification')
        .where('uid', isEqualTo: currentUserId)
        .where('isRead', isEqualTo: false)
        .get();

    // Use batch to update multiple documents
    WriteBatch batch = FirebaseFirestore.instance.batch();
    for (var doc in unreadNotifications.docs) {
      batch.update(doc.reference, {'isRead': true});
    }
    await batch.commit(); // Commit the batch update
  }

  @override
  Widget build(BuildContext context) {
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('widrawNotification')
            .where('uid', isEqualTo: currentUserId)
            .orderBy('createdAt', descending: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No notifications'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var notification = snapshot.data!.docs[index];
              return Container(
                margin: const EdgeInsets.symmetric(
                    vertical: 8.0, horizontal: 16.0), // Spacing between items
                padding: const EdgeInsets.all(12.0), // Internal padding
                decoration: BoxDecoration(
                  color: notification['isRead']
                      ? Colors.grey[200]
                      : Colors.white, // Different color for read/unread
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // Shadow color
                      spreadRadius: 1, // How much the shadow spreads
                      blurRadius: 5, // Blurriness of the shadow
                      offset: const Offset(0, 3), // Shadow position
                    ),
                  ],
                  border: Border.all(
                    color: Colors.blueAccent, // Border color
                    width: 1.0, // Border width
                  ),
                ),
                child: ListTile(
                  title: Text(
                    notification['message'] ?? 'No message',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      fontSize: 16.0,
                    ),
                  ),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Text(
                          'You have received ${notification['amount']} rupees',
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ), // Space between text and createdAt
                      Text(
                        'Date Time on: ${DateFormat('dd/MM/yyyy, hh:mm a').format(notification['createdAt'].toDate())}', // Assuming `createdAt` is a Firestore Timestamp
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                  trailing: Icon(
                    notification['isRead'] ? Icons.check_circle : Icons.circle,
                    color: notification['isRead'] ? Colors.green : Colors.red,
                    size: 24.0,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
