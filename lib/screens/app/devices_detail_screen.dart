import 'package:flutter/material.dart';
import 'package:flutter_hello/providers/devices_provider.dart';
import 'package:provider/provider.dart';

class DevicesDetailScreen extends StatelessWidget {
  const DevicesDetailScreen({super.key});

  static String route = "/app-devices-detail";

  @override
  Widget build(BuildContext context) {
    final deviceProvider = Provider.of<DevicesProvider>(context, listen: false);
    deviceProvider.startSocketDevice();
    print('Device: ${deviceProvider.selectedDevice.key}');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Device Detail'),
      ),
      body: _DeviceDetail(),
    );
  }
}

class _DeviceDetail extends StatelessWidget {
  const _DeviceDetail({super.key});

  Color getColorStatus(status) {
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
    final deviceProvider = Provider.of<DevicesProvider>(context, listen: true);
    final bool led = deviceProvider.led;
    print("detail");
    return ListView(
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
                    color: getColorStatus(deviceProvider.connection),
                  )
                ],
              ),
            ),
            SizedBox(
              child: Row(
                children: [
                  Text('Led'),
                  Switch(
                      value: led,
                      onChanged: (value) {
                        final deviceProvider = Provider.of<DevicesProvider>(
                            context,
                            listen: false);
                        deviceProvider.emitLed(value);
                      })
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
                onPressed: () {
                  final deviceProvider =
                      Provider.of<DevicesProvider>(context, listen: false);
                  deviceProvider.emitLed(!deviceProvider.led);
                },
                icon: Icon(
                  Icons.power_settings_new_outlined,
                  color: led ? Colors.green : Colors.red,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
