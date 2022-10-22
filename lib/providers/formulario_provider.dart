import 'package:flutter/material.dart';

class FormularioProvider with ChangeNotifier {
  bool _isLoading = false;

  get isLoading => _isLoading;

  set isLoading(value) {
    print('isLoading = $value');
    _isLoading = value;
    notifyListeners();
  }

  String usuario = '';
  String password = '';

  login() async {
    isLoading = true;
    print('El valor del usuario es ${usuario}');
    print('El valor del password es ${password}');
    await Future.delayed(Duration(seconds: 3));
    usuario = '';
    password = '';
    isLoading = false;
  }
}
