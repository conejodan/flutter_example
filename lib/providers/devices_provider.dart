import 'package:flutter/material.dart';
import 'package:flutter_hello/models/models.dart';
import 'package:flutter_hello/services/my_server.dart';

class DevicesProvider extends ChangeNotifier {
  DevicesProvider() {
    getDevices();
  }

  late Device selectedDevice;
  // List<Device> devices = List.generate(
  //   20,
  //   (index) => Device(
  //     id: index + 1,
  //     name: 'Device ${index + 1}',
  //     active: Random().nextBool(),
  //   ),
  // );

  List<Device> devices = [];

  bool _isLoading = false;
  get isLoading => _isLoading;
  set isLoading(val) {
    _isLoading = val;
    notifyListeners();
  }

  getDevices() async {
    print('getDevices');
    final deviceList = await MyServer().getDevices();
    if (deviceList == null) return null;
    devices = deviceList;
    notifyListeners();
  }
}
