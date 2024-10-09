import 'package:cloud_firestore/cloud_firestore.dart';

class BuySellModel {
  String? image;
  String? uid;
  String? docId;
  bool? isDeleted;
  String? description;
  int? number;
  DateTime? createdAt;

  BuySellModel({
    this.image,
    this.description,
    this.number,
    this.createdAt,
    this.docId,
    this.uid,
    this.isDeleted,
  });

  factory BuySellModel.fromMap(Map<String, dynamic> map) {
    return BuySellModel(
      image: map['image'],
      description: map['description'],
      number: map['number'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      docId: map['docId'],
      uid: map['uid'],
      isDeleted: map['isDeleted'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'description': description,
      'number': number,
      'createdAt': createdAt,
      'docId': docId,
      'uid': uid,
      'isDeleted': isDeleted,
    };
  }
}
