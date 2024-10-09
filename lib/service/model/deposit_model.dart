import 'package:cloud_firestore/cloud_firestore.dart';

class DepositModel {
  String? docId;
  String? uid;
  int? depositAmount;
  String? name;
  String? number;
  String? jazzCashNumber;
  DateTime? createdAt;
  bool? isApproved;
  DepositModel({
    this.docId,
    this.uid,
    this.depositAmount,
    this.name,
    this.number,
    this.jazzCashNumber,
    this.createdAt,
    this.isApproved,
  });
  factory DepositModel.fromMap(Map<String, dynamic> map) {
    return DepositModel(
      docId: map['docId'],
      uid: map['uid'],
      number: map['number'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      depositAmount: map['depositAmount'],
      jazzCashNumber: map['jazzCashNum'],
      name: map['name'],
      isApproved: map['isApproved'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'docId': docId,
      'uid': uid,
      'number': number,
      'createdAt': createdAt,
      'depositAmount': depositAmount,
      'jazzCashNum': jazzCashNumber,
      'name': name,
      'isApproved': isApproved,
    };
  }
}
