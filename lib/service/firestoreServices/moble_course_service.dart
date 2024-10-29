// class MobileCourseService {}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:makemoney/service/model/course_model.dart';

class CourseRequestService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  String loadingCount = 'loading';
  Stream<List<CourseModel>> getCourseAdmin() {
    return _db
        .collection('courseRequest')
        .orderBy(
          'createdAt',
          descending: true,
        )
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => CourseModel.fromJson(doc.data()))
            .toList());
  }

  Future<int> countCourseRequests() async {
    QuerySnapshot querySnapshot = await _db.collection('courseRequest').get();
    return querySnapshot.docs.length;
  }
}
