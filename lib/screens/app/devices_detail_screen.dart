import 'package:flutter/material.dart';
import 'package:flutter_hello/providers/devices_provider.dart';
import 'package:provider/provider.dart';

enum ServerStatus { online, offline, connecting }

class DevicesDetailScreen extends StatelessWidget {
  const DevicesDetailScreen({super.key});

  static String route = "/app-devices-detail";

  Color getColorStatus(ServerStatus status) {
    if (status == ServerStatus.online) {
      return Colors.green;
    }
    if (status == ServerStatus.offline) {
      return Colors.red;
    }
    return Colors.yellow;
  }

  @override
  Widget build(BuildContext context) {
    const bool led = true;

    final deviceProvider = Provider.of<DevicesProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Device Detail'),
      ),
      body: ListView(
        padding: EdgeInsets.all(15),
        children: [
          Text(
            'Device: ${deviceProvider.selectedDevice.key}',
            style: TextStyle(fontSize: 20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                child: Row(
                  children: [
                    Text('Status'),
                    Icon(
                      Icons.circle,
                      color: getColorStatus(ServerStatus.connecting),
                    )
                  ],
                ),
              ),
              SizedBox(
                child: Row(
                  children: [
                    Text('Led'),
                    Switch(value: led, onChanged: (value) {})
                  ],
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Ink(
                decoration: ShapeDecoration(
                  color: led
                      ? Colors.green.withOpacity(.3)
                      : Colors.red.withOpacity(.3),
                  shape: const CircleBorder(),
                ),
                child: IconButton(
                  iconSize: 30,
                  onPressed: () {},
                  icon: Icon(
                    Icons.power_settings_new_outlined,
                    color: led ? Colors.green : Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
