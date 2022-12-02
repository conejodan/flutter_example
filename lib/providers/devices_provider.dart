import 'package:flutter/material.dart';
import 'package:flutter_hello/models/models.dart';
import 'package:flutter_hello/services/my_server.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { online, offline, connecting }

class DevicesProvider extends ChangeNotifier {
  DevicesProvider() {
    getDevices();
  }

  late Device selectedDevice;

  List<int> temperatures = [];
  List<int> lights = [];
  bool led = true;
  ServerStatus connection = ServerStatus.offline;
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

  IO.Socket? socket;

  startSocketDevice() {
    socket = MyServer().socket;
    if (socket != null && socket!.connected) {
      connection = ServerStatus.offline;
      socket?.disconnect();
    }

    print("startSocketDevice");
    socket?.onConnect((_) {
      print('connect');
      socket?.emit('init', selectedDevice.key);
      connection = ServerStatus.online;
      notifyListeners();
    });
    socket?.on('event', (data) => print(data));
    socket?.onDisconnect((_) {
      print('disconnect');
      connection = ServerStatus.offline;
      notifyListeners();
    });
    socket?.on('temperature', (data) {
      print(data);
      print(data["temperature"]);
      temperatures.add(data["temperature"]);
      notifyListeners();
    });
    socket?.on('light', (data) {
      print(data);
      print(data["light"]);
      lights.add(data["light"]);
      notifyListeners();
    });
    socket?.connect();
  }

  emitLed(value) {
    if (socket != null) {
      print("Emit led $value");
      led = value;
      socket?.emit('led', value);
      notifyListeners();
    }
  }
}
