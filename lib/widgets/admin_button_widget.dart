import 'package:flutter/material.dart';

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
