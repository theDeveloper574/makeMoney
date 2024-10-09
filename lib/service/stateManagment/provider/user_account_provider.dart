import 'package:flutter/foundation.dart';
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
  List<UserModel> _usersInvest = [];
  List<UserModel> get usersInvest => _usersInvest;
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
      if (kDebugMode) {
        print('Error fetching users: $e');
      }
    }
    notifyListeners();
  }

  Future<void> fetchUsersInvest() async {
    try {
      // Call the method to get users
      List<UserModel> fetchedUsers =
          await userAccounts.getUsersInvest(); // Updated this line
      // Store the fetched users in the _users list
      _usersInvest = fetchedUsers;
      // await userAccounts.getUsers();
      // Notify listeners if you update any UI-relevant state
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching users: $e');
      }
    }
    notifyListeners();
  }

  ///try to fetch the admin users
  Stream<List<UserModel>> loadUserAdmin() {
    return userAccounts.getUserSnpAdmin();
  }

  ///try to delete the user
  Future<void> deleteUsr(UserModel user, bool value) async {
    user.isDeleted = value;
    userAccounts.deleteUser(user);
  }
}
