import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EstadosProvider with ChangeNotifier {
  EstadosProvider() {
    cargarUsuarios();
  }

  cargarUsuarios() async {
    final prefs = await SharedPreferences.getInstance();
    final personasRegistradas = prefs.getStringList('personas_registradas');
    if (personasRegistradas != null) {
      _personas = personasRegistradas;
    }
  }

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

  personasAdd(String elemento) async {
    _personas.add(elemento);
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('personas_registradas', _personas);
    notifyListeners();
  }
}
