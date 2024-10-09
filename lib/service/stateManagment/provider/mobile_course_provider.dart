import 'package:flutter/cupertino.dart';

import '../../firestoreServices/moble_course_service.dart';
import '../../model/course_model.dart';

class MobileCourseProvider extends ChangeNotifier {
  MobileCourseProvider() {
    loadCourseCount();
  }
  int _courseCount = 0;
  final CourseRequestService _courseRequestService = CourseRequestService();

  int get courseCount => _courseCount;

  // Method to load course count
  Future<void> loadCourseCount() async {
    _courseCount = await _courseRequestService.countCourseRequests();
    notifyListeners(); // Notify listeners when the data changes
  }

  // Stream to fetch admin course requests
  Stream<List<CourseModel>> getCourseAdmin() {
    return _courseRequestService.getCourseAdmin();
  }
}
