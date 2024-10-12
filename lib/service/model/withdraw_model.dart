import 'package:cloud_firestore/cloud_firestore.dart';

class WithdrawModel {
  String? docId;
  String? uid;
  int? totalAmount;
  int? withdrawAmount;
  String? name;
  String? number;
  String? jazzCashNumber;
  DateTime? createdAt;
  bool? isApproved;
  WithdrawModel({
    this.docId,
    this.uid,
    this.totalAmount,
    this.name,
    this.number,
    this.jazzCashNumber,
    this.createdAt,
    this.isApproved,
    this.withdrawAmount,
  });
  factory WithdrawModel.fromMap(Map<String, dynamic> map) {
    return WithdrawModel(
      docId: map['docId'],
      uid: map['uid'],
      number: map['number'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      totalAmount: map['totalAmount'],
      jazzCashNumber: map['jazzCashNum'],
      name: map['name'],
      isApproved: map['isApproved'],
      withdrawAmount: map['withdrawAmount'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'docId': docId,
      'uid': uid,
      'number': number,
      'createdAt': createdAt,
      'totalAmount': totalAmount,
      'jazzCashNum': jazzCashNumber,
      'name': name,
      'isApproved': isApproved,
      'withdrawAmount': withdrawAmount,
    };
  }
}
