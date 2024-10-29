import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AccountInfo extends StatelessWidget {
  final String uid = 'W59hbs0PkFc8V9zbKrq62JEU4uO2';

  const AccountInfo({super.key}); // Specify your UID here

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('accountNumbers')
          .doc(uid)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Error fetching data'));
        }
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Center(child: Text('No data found'));
        }

        // Assuming the document contains fields 'name' and 'number'
        final data = snapshot.data!.data() as Map<String, dynamic>;
        final name = data['name'] ?? 'Unknown Name';
        final number = data['number'] ?? 'Unknown Number';
        final account = data['accontName'] ?? 'Unknown Number';

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$account Acc Name:",
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
            ),
            Text(
              name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  number,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(width: 16),
                InkWell(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: number));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('نمبر کاپی ہو گیا ہے')),
                    );
                  },
                  child: const Icon(
                    Icons.copy,
                    size: 20,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
