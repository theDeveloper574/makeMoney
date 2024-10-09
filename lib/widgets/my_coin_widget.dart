import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class MyCoinWidget extends StatelessWidget {
  const MyCoinWidget({super.key});

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
                  child: CircleAvatar(
                    child: Image.asset('assets/icons/d-logo.png'),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Dada",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text("da"),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: Get.height * 0.007),
            Padding(
              padding: EdgeInsets.only(left: Get.width * 0.03),
              child: const Text(
                "Rup: 1.20",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: Get.width * 0.02),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Rup 1.20",
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
