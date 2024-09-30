import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class FundsWidget extends StatelessWidget {
  const FundsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.greenAccent,
      shadowColor: Colors.grey.withOpacity(0.4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // <-- Radius
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // SizedBox(width: Get.width * 0.01),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: const CircleAvatar(
                    child: Icon(Icons.currency_bitcoin),
                  ),
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Bitcoin",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text("Btc"),
                  ],
                ),
              ],
            ),
            SizedBox(height: Get.height * 0.007),
            Padding(
              padding: EdgeInsets.only(left: Get.width * 0.03),
              child: const Text(
                "\$23423",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: Get.width * 0.02),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // SizedBox(width: Get.width * 0.07),
                  const Text(
                    "+\$34546",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.01,
                  ),
                  const Text(
                    "+\$0.097%",
                    style: TextStyle(fontSize: 12, color: Colors.red),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
