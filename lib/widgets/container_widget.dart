import 'package:flutter/material.dart';
import 'package:makemoney/core/commen/constants.dart';

class ConatinerWidget extends StatelessWidget {
  const ConatinerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.blurColor,
        borderRadius: BorderRadius.circular(8),
      ),
      width: double.infinity,
      child: const Center(
        child: Column(
          children: [
            Text(
              "Coming soon",
              style: TextStyle(
                fontSize: 32,
              ),
            ),
            Text(
              "جلد آرہا ہے۔",
              style: TextStyle(
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
