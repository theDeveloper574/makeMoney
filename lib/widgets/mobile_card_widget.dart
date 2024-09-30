import 'package:flutter/material.dart';

class MobieCardWidget extends StatelessWidget {
  final String text;
  final String image;
  const MobieCardWidget({
    super.key,
    required this.text,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          color: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          margin: EdgeInsets.symmetric(horizontal: 24),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
                Image.asset(
                  image,
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
