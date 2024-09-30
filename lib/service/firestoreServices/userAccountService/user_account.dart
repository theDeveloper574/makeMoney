import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:makemoney/service/model/user_model.dart';

class UserAccounts {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<UserModel>> userCount() {
    return _db
        .collection('users')
        .where('isDeleted', isEqualTo: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((e) {
        return UserModel.fromMap(e.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Future<List<UserModel>> getUsers() async {
    try {
      // Fetch users where 'isDeleted' is false
      var snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('isDeleted', isEqualTo: false)
          .get();
      // Process each document and map to UserModel or perform your logic here
      List<UserModel> users = snapshot.docs.map((doc) {
        return UserModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
      return users;
      // Do something with the list of users, e.g., print or update the state
      // print('Users: ${users.length}');
      // You can perform any other actions with the users list here.
    } catch (e) {
      // Handle any errors
      print('Error fetching users: $e');
    }
    return [];
  }
}
