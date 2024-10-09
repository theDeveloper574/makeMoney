import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class TaskProvider with ChangeNotifier {
  TaskProvider() {
    getSocialLinks();
  }
  List<Map<String, dynamic>> _socialLinks = [];
  bool _isLoading = false;

  List<Map<String, dynamic>> get socialLinks => _socialLinks;
  bool get isLoading => _isLoading;

  // Method to fetch social links from Firestore
  Future<void> getSocialLinks() async {
    _isLoading = true;
    // notifyListeners();

    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('socialLinks').get();
      _socialLinks = snapshot.docs.map((doc) {
        return {
          'link': doc['link'],
          'task': doc['task'],
          'name': doc['name'],
          'color': doc['color'],
        };
      }).toList();
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching social links: $e');
      }
      _socialLinks = [];
    }
    _isLoading = false;
    notifyListeners();
  }

  ///update the task

  // Method to update the 'link' and optionally the 'task' fields of a social link
  Future<void> updateLinkAndTask(String id, String newLink,
      {String? newTask}) async {
    try {
      Map<String, dynamic> updateData = {'link': newLink};

      // Only add 'task' to the update if it's provided (not null)
      if (newTask != null) {
        updateData['task'] = newTask;
      }
      await FirebaseFirestore.instance
          .collection('socialLinks')
          .doc(id)
          .update(updateData);
      await getSocialLinks(); // Refresh the list after updating the document
    } catch (e) {
      if (kDebugMode) {
        print('Error updating social link: $e');
      }
    }
  }
}
