import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/deposit_model.dart';

class DepositService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Future<void> addDeposit(DepositModel model) async {
    _db.collection('futureInvestDeposit').doc(model.docId).set(model.toMap());
  }

  Future<void> updateDeposit(DepositModel update) async {
    _db.collection('futureInvestDeposit').doc(update.docId).update(
          update.toMap(),
        );
  }

  Stream<List<DepositModel>> getDeposit() {
    return _db
        .collection('futureInvestDeposit')
        .orderBy(
          'createdAt',
          descending: true,
        )
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => DepositModel.fromMap(doc.data()))
              .toList(),
        );
  }

  Stream<List<DepositModel>> getDepositCheck() {
    return _db.collection('futureInvestDeposit').snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => DepositModel.fromMap(doc.data()))
              .toList(),
        );
  }

  Stream<List<DepositModel>> getInvestDepositAdmin() {
    return _db
        .collection('futureInvestDeposit')
        .orderBy(
          'createdAt',
          descending: true,
        )
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => DepositModel.fromMap(doc.data()))
              .toList(),
        );
  }

  ///get deposit list data
  // Replaces the stream with a Future method to fetch deposits
  Future<List<DepositModel>> getDeposits() async {
    final snapshot = await _db
        .collection('futureInvestDeposit')
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => DepositModel.fromMap(doc.data()))
        .toList();
  }

  Future<List<DepositModel>> getInvestAdmin() async {
    final snapshot = await _db
        .collection('futureInvestDeposit')
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => DepositModel.fromMap(doc.data()))
        .toList();
  }

  Stream<List<DepositModel>> getDepositFalse() {
    return _db
        .collection('futureInvestDeposit')
        .where('isApproved', isEqualTo: false)
        .orderBy(
          'createdAt',
          descending: true,
        )
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => DepositModel.fromMap(doc.data()))
              .toList(),
        );
  }
}
