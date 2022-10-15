import 'package:flutter/material.dart';

class EstadosProvider with ChangeNotifier {
  int _navigationIndex = 0;

  int get navigationIndex => _navigationIndex;

  set navigationIndex(int valor) {
    _navigationIndex = valor;
    notifyListeners();
  }

  bool _switchValue = true;

  bool get switchValue => _switchValue;

  set switchValue(bool valor) {
    _switchValue = valor;
    notifyListeners();
  }

  List<String> _personas = [];

  List<String> get personas => _personas;

  personasAdd(String elemento) {
    _personas.add(elemento);
    notifyListeners();
  }
}
