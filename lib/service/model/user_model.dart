import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? docId;
  String? phoneNumber;
  String? profileUrl;
  String? name;
  String? accountNumber;
  DateTime? createdAt;
  bool isDeleted;
  bool paymentStatus;
  int? balance;
  int? coinBalance;

  UserModel({
    this.uid,
    this.docId,
    this.phoneNumber,
    this.profileUrl,
    this.name,
    this.createdAt,
    this.accountNumber,
    required this.isDeleted,
    required this.paymentStatus,
    this.balance,
    this.coinBalance,
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
      paymentStatus: map['paymentStatus'],
      balance: map['balance'] ?? 0,
      coinBalance: map['coinBalance'] ?? 0,
      accountNumber: map['accountNumber'] ?? "",
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
      'paymentStatus': paymentStatus,
      'balance': balance,
      'coinBalance': coinBalance,
      'accountNumber': accountNumber,
    };
  }
}
