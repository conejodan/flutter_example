import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

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

    var respuestaExitosa = false;

    //await Future.delayed(Duration(seconds: 2));
    var url = Uri.http('192.168.100.47:4902', '/api/login');

    // Await the http get response, then decode the json-formatted response.
    var response = await http.post(url, body: {
      'username': username,
      'password': password,
    });

    isLoading = false;
    notifyListeners();
    return response;
  }
}
