import 'package:flutter/material.dart';
import 'package:flutter_hello/screens/screens.dart';

class LitstadoPantallasScreen extends StatelessWidget {
  const LitstadoPantallasScreen({super.key});

  static String route = "/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Listado de Pantallas'),),
      body: ListView(
        children: [
          ListTile(
            onTap: () async {
              print('Click elemento 1');
              await Future.delayed(Duration(milliseconds: 1000));
              Navigator.of(context).pushNamed(HomeScreen.route);
            },
            leading: Icon(Icons.access_alarms),
            trailing: Icon(Icons.chevron_right),
            title: Text('HomeScreen'),
            subtitle: Text('Subtitulo'),
          ),
          ListTile(
            onTap: () {
              print('Click elemento 2');
              Navigator.of(context).pushNamed(ContainerScreen.route);
            },
            onLongPress: () {
              print('Long Press');
              Navigator.of(context).pushNamed(ContainerScreen.route);
            },
            title: Text('ContainerScreen'),
          ),
          ListTile(
            leading: Icon(Icons.account_balance_sharp),
            trailing: GestureDetector(
              onTap: () {
                print('Click GestureDetector');
                Navigator.of(context).pushNamed(ScaffoldScreen.route);
              },
              child: Icon(Icons.chevron_right),
            ),
            title: Text('ScaffoldScreen'),
            subtitle: Text('Subtitulo'),
          ),
        ],
      ),

    );
  }
}