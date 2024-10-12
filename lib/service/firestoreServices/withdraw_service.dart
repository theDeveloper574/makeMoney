import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/withdraw_model.dart';

class WithdrawService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Future<void> addWithdraw(WithdrawModel model) async {
    _db.collection('futureInvestWithdraw').doc(model.docId).set(model.toMap());
  }

  Future<void> updateWithdraw(WithdrawModel update) async {
    _db.collection('futureInvestWithdraw').doc(update.docId).update(
          update.toMap(),
        );
  }

  Stream<List<WithdrawModel>> getWithdraw() {
    return _db
        .collection('futureInvestWithdraw')
        .orderBy(
          'createdAt',
          descending: true,
        )
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => WithdrawModel.fromMap(doc.data()))
              .toList(),
        );
  }

  Stream<List<WithdrawModel>> getWithdrawCheck() {
    return _db.collection('futureInvestWithdraw').snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => WithdrawModel.fromMap(doc.data()))
              .toList(),
        );
  }

  Stream<List<WithdrawModel>> getInvestWithdrawAdmin() {
    return _db
        .collection('futureInvestWithdraw')
        .orderBy(
          'createdAt',
          descending: true,
        )
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => WithdrawModel.fromMap(doc.data()))
              .toList(),
        );
  }

  ///get deposit list data
  // Replaces the stream with a Future method to fetch deposits
  Future<List<WithdrawModel>> getWithdraws() async {
    final snapshot = await _db
        .collection('futureInvestWithdraw')
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => WithdrawModel.fromMap(doc.data()))
        .toList();
  }

  Future<List<WithdrawModel>> getWithdrawAdmin() async {
    final snapshot = await _db
        .collection('futureInvestWithdraw')
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => WithdrawModel.fromMap(doc.data()))
        .toList();
  }

  Future<void> withdrawNotification({
    required String amount,
    required String uid,
  }) async {
    _db.collection("widrawNotification").doc().set(
      {
        'amount': amount,
        'createdAt': FieldValue.serverTimestamp(),
        'isRead': false,
        'message': '"You have received a withdrawal"',
        'uid': uid,
      },
    );
  }
}
