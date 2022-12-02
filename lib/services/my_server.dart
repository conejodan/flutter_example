import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_hello/models/models.dart';

class MyServer {
  static String server = "192.168.100.25";
  static String portApi = "4902";
  static final String _baseUrlApi = "$server:$portApi";
  static String portSocket = "5493";

  IO.Socket socket = IO.io(
      'http://$server:$portSocket/',
      IO.OptionBuilder()
          .setTransports(['websocket']) // for Flutter or Dart VM
          .disableAutoConnect()
          .build());

  Future<http.Response?> login({
    String username = '',
    String password = '',
  }) async {
    final url = Uri.http(_baseUrlApi, '/api/login');
    try {
      return await http.post(
        url,
        body: {
          'username': username,
          'password': password,
        },
      );
    } catch (e) {
      return null;
    }
  }

  Future<List<User>?> getUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final url = Uri.http(_baseUrlApi, '/api/users');
    try {
      final resp =
          await http.get(url, headers: {'Authorization': 'Bearer $token'});
      if (resp.statusCode == 200) {
        final decode = jsonDecode(resp.body);
        final List userList = decode['data'];
        return userList.map((e) => User.fromJson(e)).toList();
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<http.Response?> getUser() async {
    return null;
  }

  Future<List<Device>?> getDevices() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final url = Uri.http(_baseUrlApi, '/api/devices');
    try {
      final resp =
          await http.get(url, headers: {'Authorization': 'Bearer $token'});
      if (resp.statusCode == 200) {
        final decode = jsonDecode(resp.body);
        final List deviceList = decode['data'];
        return deviceList.map((e) => Device.fromJson(e)).toList();
      }
    } catch (e) {
      return null;
    }
  }

  Future<http.Response?> getDevice() async {
    return null;
  }

  Future<bool> createUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final url = Uri.http(_baseUrlApi, '/api/users');
    try {
      final resp = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: {
          'name': user.name,
          'username': user.username,
          'password': user.password,
        },
      );
      if (resp.statusCode == 201) {
        return true;
      }
      return false;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<http.Response?> createDevice(Device device) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final url = Uri.http(_baseUrlApi, '/api/devices');
    try {
      return await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: {'name': device.name},
      );
    } catch (e) {
      throw e.toString();
    }
  }

  Future<bool> updateUser(User user) async {
    print('${user.username} - ${user.name} - ${user.password}');
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final url = Uri.http(_baseUrlApi, '/api/users/${user.id}');
    try {
      final resp = await http.put(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: {
          'name': user.name,
          'username': user.username,
          'password': user.password,
        },
      );
      if (resp.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<bool> enableDisableUser(User user) async {
    print('${user.username} - ${user.name} - ${user.password}');
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final url = Uri.http(_baseUrlApi, '/api/users/${user.id}');
    final resp = await http.put(
      url,
      headers: {'Authorization': 'Bearer $token'},
      body: {
        "active": "${!user.active}",
        "username": user.username,
        "name": user.name,
        "password": ""
      },
    );
    if (resp.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<http.Response?> updateDevice(Device device) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final url = Uri.http(_baseUrlApi, '/api/devices/${device.id}');
    final body = device.toJson();
    try {
      return await http.put(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: body,
      );
    } catch (e) {
      throw e.toString();
    }
  }
}
