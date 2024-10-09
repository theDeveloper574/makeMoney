import 'package:flutter/material.dart';

class TaskUpdateView extends StatelessWidget {
  final TextEditingController linkCon;
  final TextEditingController taskCon;
  final Function() onSaved;
  const TaskUpdateView({
    super.key,
    required this.linkCon,
    required this.taskCon,
    required this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Update Link'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: linkCon,
            decoration: const InputDecoration(hintText: 'Link'),
          ),
          TextField(
            controller: taskCon,
            decoration: const InputDecoration(hintText: 'Task Name'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog without saving
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: onSaved,
          child: const Text('Save'),
        ),
      ],
    );
  }
}
