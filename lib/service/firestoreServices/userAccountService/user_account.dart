import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:makemoney/service/model/user_model.dart';

class UserAccounts {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<UserModel>> userCount() {
    return _db
        // .collection('users')
        .collection('futureInvestUsers')
        .where('isDeleted', isEqualTo: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((e) {
        return UserModel.fromMap(e.data());
      }).toList();
    });
  }

  Future<List<UserModel>> getUsers() async {
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection('futureInvestUsers')
          .where('isDeleted', isEqualTo: false)
          .orderBy('createdAt', descending: true)
          .where('uid', isNotEqualTo: '2hMNPs27hlTijhFO6DcMM9SNQmy2')
          .get();
      List<UserModel> users = snapshot.docs.map((doc) {
        return UserModel.fromMap(doc.data());
      }).toList();
      return users;
    } catch (e) {
      // Handle any errors
      if (kDebugMode) {
        print('Error fetching users: $e');
      }
    }
    return [];
  }

  Future<List<UserModel>> getUsersInvest() async {
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection('futureInvestUsers')
          .where('isDeleted', isEqualTo: false)
          .orderBy('createdAt', descending: true)
          .where('paymentStatus', isEqualTo: true)
          .where('uid', isNotEqualTo: '2hMNPs27hlTijhFO6DcMM9SNQmy2')
          .get();
      List<UserModel> users = snapshot.docs.map((doc) {
        return UserModel.fromMap(doc.data());
      }).toList();
      return users;
    } catch (e) {
      // Handle any errors
      if (kDebugMode) {
        print('Error fetching users: $e');
      }
    }
    return [];
  }

  ///data for admin
  Stream<List<UserModel>> getUserSnpAdmin() {
    return _db
        // .collection('users')
        .collection('futureInvestUsers')
        .orderBy('createdAt', descending: true)
        .where('uid', isNotEqualTo: '2hMNPs27hlTijhFO6DcMM9SNQmy2')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((e) {
        return UserModel.fromMap(e.data());
      }).toList();
    });
  }

  ///try to update some values
  Future<void> deleteUser(UserModel user) async {
    // await _db.collection('users').doc(user.uid).update(user.toMap());
    await _db
        .collection('futureInvestUsers')
        .doc(user.uid)
        .update(user.toMap());
  }
}
