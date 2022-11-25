import 'package:flutter/material.dart';
import 'package:flutter_hello/services/my_server.dart';

class LoginFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String username = '';
  String password = '';

  bool _isLoading = false;
  get isLoading => _isLoading;
  set isLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  bool validate() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      return true;
    }
    return false;
  }

  login() async {
    _isLoading = true;
    notifyListeners();

    final response = await MyServer().login(username: username, password: password);

    isLoading = false;
    notifyListeners();
    return response;
  }
}
