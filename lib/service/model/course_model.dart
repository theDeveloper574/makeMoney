import 'package:cloud_firestore/cloud_firestore.dart';

class CourseModel {
  String? courseName;
  String? studentClass;
  String? studentName;
  String? userId;
  DateTime? dateTime;

  CourseModel({
    this.courseName,
    this.studentClass,
    this.studentName,
    this.userId,
    this.dateTime,
  });
  factory CourseModel.fromJson(Map<String, dynamic> map) {
    return CourseModel(
      courseName: map['courseName'] ?? "",
      studentClass: map['studentClass'] ?? "",
      studentName: map['studentName'] ?? "",
      userId: map['userId']!,
      dateTime: (map['createdAt'] as Timestamp).toDate(),
    );
  }
}
