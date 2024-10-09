import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:makemoney/service/model/buy_sell_model.dart';

class BuySellService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Future<void> addBuySell(BuySellModel model) async {
    _db.collection('BuySell').doc(model.docId).set(model.toMap());
  }

  Future<void> updateTheBuySell(BuySellModel update) async {
    _db.collection('BuySell').doc(update.docId).update(update.toMap());
  }

  Stream<List<BuySellModel>> getBuySell() {
    return _db
        .collection('BuySell')
        .where('isDeleted', isEqualTo: false) // Filter by isDeleted = false
        .orderBy(
          'createdAt',
          descending: true,
        )
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => BuySellModel.fromMap(doc.data()))
              .toList(),
        );
  }

  Stream<List<BuySellModel>> getBuySellAdmin() {
    return _db
        .collection('BuySell')
        .orderBy(
          'createdAt',
          descending: true,
        )
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => BuySellModel.fromMap(doc.data()))
              .toList(),
        );
  }
}
