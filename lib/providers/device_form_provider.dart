import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_hello/models/models.dart';
import 'package:flutter_hello/services/my_server.dart';

class DeviceFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Device device;

  DeviceFormProvider(this.device);

  Map<String, dynamic> _errors = {};
  Map<String, dynamic> get errors => _errors;
  set errors(value) {
    _errors = value;
    notifyListeners();
  }

  String _message = '';
  get message => _message;
  set message(value) {
    _message = value;
    notifyListeners();
  }

  bool _isLoading = false;
  get isLoading => _isLoading;
  set isLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  bool validate() {
    if (formKey.currentState == null) {
      return false;
    }
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      return true;
    }
    return false;
  }

  Future<bool> createDevice() async {
    _isLoading = true;
    _errors = {};
    var created = false;
    notifyListeners();

    final resp = await MyServer().createDevice(device);
    if (resp == null) return false;
    if (resp.statusCode == 201) {
      // final decode = jsonDecode(resp.body);
      _message = 'Device Created';
      created = true;
    }
    if (resp.statusCode == 422) {
      final decode = jsonDecode(resp.body);
      _errors = decode['errors'];
      _message = 'Error Form';
    }
    _isLoading = false;
    notifyListeners();
    return created;
  }

  Future<bool> updateDevice() async {
    _isLoading = true;
    _errors = {};
    notifyListeners();

    final resp = await MyServer().updateDevice(device);
    if (resp == null) return false;
    if (resp.statusCode == 200) {
      // final decode = jsonDecode(resp.body);
      _message = 'Device Updated';
      _isLoading = false;
      notifyListeners();
      return true;
    }
    if (resp.statusCode == 422) {
      final decode = jsonDecode(resp.body);
      _errors = decode['errors'];
      _message = 'Error Form';
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }
}
