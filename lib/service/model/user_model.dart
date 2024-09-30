import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? docId;
  String? phoneNumber;
  String? profileUrl;
  String? name;
  DateTime? createdAt;
  bool isDeleted;

  UserModel({
    this.uid,
    this.docId,
    this.phoneNumber,
    this.profileUrl,
    this.name,
    this.createdAt,
    required this.isDeleted,
  });
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      docId: map['docId'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      profileUrl: map['profileUrl'] ?? '',
      name: map['name'] ?? '',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      isDeleted: map['isDeleted'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'docId': docId,
      'phoneNumber': phoneNumber,
      'profileUrl': profileUrl,
      'name': name,
      'createdAt': createdAt,
      'isDeleted': isDeleted,
    };
  }
}
