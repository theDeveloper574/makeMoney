import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  final VoidCallback onSave;
  final String? text;
  final bool isSubmit;

  const SaveButton({
    super.key,
    required this.onSave,
    this.text,
    this.isSubmit = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onSave,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        // primary: Colors.blueAccent, // Button color
        // onPrimary: Colors.white, // Text color
        padding:
            const EdgeInsets.symmetric(horizontal: 30, vertical: 15), // Padding
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // Rounded edges
        ),
        elevation: 5, // Elevation for shadow effect
        shadowColor: Colors.blueAccent.withOpacity(0.5), // Shadow color
      ),
      child: isSubmit
          ? const CircularProgressIndicator(color: Colors.white)
          : Row(
              mainAxisSize: MainAxisSize.min, // Shrink to fit content
              children: [
                const Icon(
                  Icons.save,
                  size: 20,
                  color: Colors.white,
                ), // Save icon
                const SizedBox(width: 10), // Space between icon and text
                Text(
                  text ?? 'Save',
                  style: const TextStyle(
                      fontSize: 18, // Text size
                      fontWeight: FontWeight.bold,
                      color: Colors.white // Bold text
                      ),
                ),
              ],
            ),
    );
  }
}
