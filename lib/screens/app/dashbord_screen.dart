import 'package:flutter/material.dart';
import 'package:flutter_hello/providers/devices_provider.dart';
import 'package:flutter_hello/providers/users_provider.dart';
import 'package:flutter_hello/screens/app/screens.dart';
import 'package:flutter_hello/widgets/custom_drawer.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  static String route = "/app-dashboard";

  Future buscarDatos(context) async {
    await Provider.of<UsersProvider>(context, listen: false).getUsers();
    await Provider.of<DevicesProvider>(context, listen: false).getDevices();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: FutureBuilder(
        future: buscarDatos(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const _DashboardBody();
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class _DashboardBody extends StatelessWidget {
  const _DashboardBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<UsersProvider>(context).users;
    final devices = Provider.of<DevicesProvider>(context).devices;
    final usersRoute = UsersScreen.route;
    final devicesRoute = DevicesScreen.route;

    return GridView.count(
      // Create a grid with 2 columns. If you change the scrollDirection to
      // horizontal, this produces 2 rows.
      crossAxisCount: 2,
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
      padding: const EdgeInsets.all(20),
      // Generate 100 widgets that display their index in the List.
      children: [
        InkWell(
          onTap: () => Navigator.of(context).pushNamed(usersRoute),
          child: CustomSectionDataCard(
            value: "${users.length}",
            color: Colors.red.shade200,
            section: 'Users',
            icon: Icons.people,
          ),
        ),
        InkWell(
          onTap: () => Navigator.of(context).pushNamed(devicesRoute),
          child: CustomSectionDataCard(
            value: "${devices.length}",
            color: Colors.purple.shade200,
            icon: Icons.device_hub_sharp,
            section: 'Devices',
          ),
        ),
      ],
    );
  }
}

class CustomSectionDataCard extends StatelessWidget {
  final String value;
  final String section;
  final Color color;
  final IconData? icon;

  const CustomSectionDataCard({
    Key? key,
    required this.value,
    this.section = '',
    required this.color,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          const SizedBox(
            height: 0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null)
                Icon(
                  icon,
                  size: 30,
                ),
              if (icon != null && section.isNotEmpty)
                const SizedBox(
                  width: 8,
                ),
              if (section.isNotEmpty)
                Text(
                  section,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
