import 'package:flutter/cupertino.dart';
import 'package:makemoney/service/model/user_model.dart';

import '../../firestoreServices/userAccountService/user_account.dart';

class UserAccountProvider extends ChangeNotifier {
  //snapshot of the user
  UserAccounts userAccounts = UserAccounts();
  Stream<List<UserModel>> countUser() {
    return userAccounts.userCount();
  }

  ///get the user using get method
  List<UserModel> _users = [];

  List<UserModel> get users => _users;

  Future<void> fetchUsers() async {
    try {
      // Call the method to get users
      List<UserModel> fetchedUsers =
          await userAccounts.getUsers(); // Updated this line
      // Store the fetched users in the _users list
      _users = fetchedUsers;
      // await userAccounts.getUsers();
      // Notify listeners if you update any UI-relevant state
      notifyListeners();
    } catch (e) {
      print('Error fetching users: $e');
    }
    notifyListeners();
  }
}
