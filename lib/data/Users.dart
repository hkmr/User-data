import 'package:flutter/material.dart';
import 'package:user_form/models/User.dart';

class Users extends ChangeNotifier {
  static List<User> users = [];

  void addUser(User user) {
    users.add(user);
    notifyListeners();
  }

  void removeUser(int index) {
    users.removeAt(index);
    notifyListeners();
  }

  getUsers() {
    return users;
  }
}
