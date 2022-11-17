import 'package:flutter/material.dart';
import 'package:flutter_hello/models/models.dart';

class UsersProvider extends ChangeNotifier {
  UsersProvider() {
    getUsers();
  }

  late User selectedUser;
  // List<User> users = List.generate(
  //   16,
  //   (index) => User(
  //     id: index,
  //     name: 'User ${index + 1}',
  //     username: 'Username $index',
  //     active: Random().nextBool(),
  //   ),
  // );
  bool _isLoading = false;
  get isLoading => _isLoading;
  set isLoading(val) {
    _isLoading = val;
    notifyListeners();
  }

  List<User> users = [];

  getUsers() async {
    print('getUsers');
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 3));
    _isLoading = false;
    notifyListeners();
  }

  addUser(User user) {
    users.add(user);
    notifyListeners();
  }
}
