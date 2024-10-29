import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateAccountDialog extends StatefulWidget {
  const UpdateAccountDialog({
    super.key,
  });

  @override
  UpdateAccountDialogState createState() => UpdateAccountDialogState();
}

class UpdateAccountDialogState extends State<UpdateAccountDialog> {
  final String uid = 'W59hbs0PkFc8V9zbKrq62JEU4uO2';
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _accontNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchAccountData();
  }

  Future<void> _fetchAccountData() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('accountNumbers')
        .doc(uid)
        .get();

    if (doc.exists) {
      final data = doc.data() as Map<String, dynamic>;
      _nameController.text = data['name'] ?? '';
      _numberController.text = data['number'] ?? '';
      _accontNameController.text = data['accontName'] ?? '';
    }
  }

  Future<void> _updateAccountData() async {
    if (_formKey.currentState!.validate()) {
      await FirebaseFirestore.instance
          .collection('accountNumbers')
          .doc(uid)
          .update({
        'name': _nameController.text.trim(),
        'number': _numberController.text.trim(),
        'accontName': _accontNameController.text.trim(),
      });
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Update Account Information'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
              validator: (value) => value!.isEmpty ? 'Name is required' : null,
            ),
            TextFormField(
              controller: _numberController,
              decoration: const InputDecoration(labelText: 'Number'),
              validator: (value) =>
                  value!.isEmpty ? 'Number is required' : null,
            ),
            TextFormField(
              controller: _accontNameController,
              decoration: const InputDecoration(labelText: 'Account Name'),
              validator: (value) =>
                  value!.isEmpty ? 'Account Name is required' : null,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _updateAccountData,
          child: const Text('Update'),
        ),
      ],
    );
  }
}
