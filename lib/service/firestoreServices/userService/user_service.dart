import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:makemoney/service/model/user_model.dart';

class UserService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  //add user to the database
  Future<void> addUser(UserModel user) async {
    // await _db.collection("users").doc(user.uid).set(user.toMap());
    await _db.collection("futureInvestUsers").doc(user.uid).set(user.toMap());
  }

  //update user from the database
  Future<void> updateUser(UserModel user) async {
    // await _db.collection('users').doc(user.uid).update(user.toMap());
    await _db.collection('futureInvestUsers').doc(user.uid).update(
          user.toMap(),
        );
  }

  //get user from the database
  Future<UserModel?> getUser(String uid) async {
    try {
      // DocumentSnapshot doc = await _db.collection("users").doc(uid).get();
      DocumentSnapshot doc =
          await _db.collection("futureInvestUsers").doc(uid).get();
      if (doc.exists) {
        return UserModel.fromMap(doc.data() as Map<String, dynamic>);
      } else {
        log("no user found with this Id");
      }
    } catch (e) {
      log("error getting user ${e.toString()}");
    }
    return null;
  }

  Future<void> updateCustom({
    required String docId,
    required int balance,
    required int coinBalance,
  }) async {
    await _db.collection('futureInvestUsers').doc(docId).update({
      'paymentStatus': true,
      'balance': balance,
      'coinBalance': coinBalance,
    });
  }
}
