import 'package:flutter/material.dart';
import 'package:flutter_hello/models/models.dart';
import 'package:flutter_hello/providers/devices_provider.dart';
import 'package:flutter_hello/screens/app/screens.dart';
import 'package:provider/provider.dart';

class DevicesScreen extends StatelessWidget {
  const DevicesScreen({super.key});

  static String route = "/app-devices";

  @override
  Widget build(BuildContext context) {
    final deviceProvider = Provider.of<DevicesProvider>(context);
    final devices = deviceProvider.devices;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Devices'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: () {
                print("Reload");
                deviceProvider.getDevices();
              },
              icon: const Icon(
                Icons.replay,
                size: 26.0,
              ),
            ),
          ),
        ],
      ),
      body: ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (_, index) => CustomDeviceListTile(
          device: devices[index],
        ),
        separatorBuilder: (_, __) => const Divider(),
        itemCount: devices.length,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          final devicesProvider =
              Provider.of<DevicesProvider>(context, listen: false);
          devicesProvider.selectedDevice = Device();
          Navigator.of(context).pushNamed(DevicesFormScreen.route);
        },
      ),
    );
  }
}

class CustomDeviceListTile extends StatelessWidget {
  final Device device;

  const CustomDeviceListTile({Key? key, required this.device})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(device.name),
      subtitle: device.key == '' ? null : Text(device.key),
      leading: Icon(
        Icons.circle,
        color: device.active ? Colors.green : Colors.red,
      ),
      trailing: Icon(Icons.chevron_right),
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.edit),
                    title: Text('Edit Device'),
                    onTap: () {
                      final devicesProvider =
                          Provider.of<DevicesProvider>(context, listen: false);
                      devicesProvider.selectedDevice = device;
                      Navigator.of(context)
                          .popAndPushNamed(DevicesFormScreen.route);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.bar_chart_outlined),
                    title: Text('Show Info'),
                    onTap: () {
                      final devicesProvider =
                          Provider.of<DevicesProvider>(context, listen: false);
                      devicesProvider.selectedDevice = device;
                      Navigator.of(context)
                          .popAndPushNamed(DevicesDetailScreen.route);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.do_not_disturb_alt_rounded),
                    title: Text(
                      'Disable Device',
                      style: TextStyle(color: Colors.red.shade400),
                    ),
                    onTap: () {},
                  ),
                ],
              );
            });
      },
    );
  }
}
