import 'package:flutter/material.dart';
import 'package:flutter_hello/models/models.dart';
import 'package:flutter_hello/services/my_server.dart';

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

  Future getUsers() async {
    print('getUsers');
    //isLoading = true;
    await Future.delayed(Duration(seconds: 1));
    final usersList = await MyServer().getUsers();
    if (usersList == null) return null;
    users = usersList;
    notifyListeners();
    //isLoading = false;
  }

  addUser(User user) {
    users.add(user);
    notifyListeners();
  }
}
