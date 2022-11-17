import 'package:flutter/material.dart';
import 'package:flutter_hello/screens/screens.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LitstadoPantallasScreen extends StatelessWidget {
  const LitstadoPantallasScreen({super.key});

  static String route = "/listado-pantallas";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listado de Pantallas'),
      ),
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
          ListTile(
            onTap: () async {
              Navigator.of(context).pushNamed(ImagenesScreen.route);
            },
            leading: Icon(Icons.image),
            trailing: Icon(Icons.chevron_right),
            title: Text('ImagesScreen'),
            subtitle: Text('Cargando imagenes e imagenes de fondo'),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed(StatefulScreen.route);
            },
            leading: Icon(Icons.circle),
            trailing: Icon(Icons.chevron_right),
            title: Text('Stateful Screen'),
            subtitle: Text('Manejo de estados'),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed(ProviderScreen.route);
            },
            leading: Icon(Icons.circle),
            trailing: Icon(Icons.chevron_right),
            title: Text('Provider Screen'),
            subtitle: Text('Manejo de estados avanzado'),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed(FormularioScreen.route);
            },
            leading: Icon(Icons.circle),
            trailing: Icon(Icons.chevron_right),
            title: Text('Formulario Screen'),
            subtitle: Text('Manejo de datos de formulario'),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed(AlertScreen.route);
            },
            leading: Icon(Icons.warning),
            trailing: Icon(Icons.chevron_right),
            title: Text('Alert Screen'),
            subtitle: Text('Mostrando alerta'),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed(FormularioProviderScreen.route);
            },
            leading: Icon(Icons.circle),
            trailing: Icon(Icons.chevron_right),
            title: Text('Formulario Provider Screen'),
            subtitle: Text('Manejo de datos de formulario con provider'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final prefs = await SharedPreferences.getInstance();
          final ultimoUsuario = prefs.getString('ultimo_usuario');
          print("Ultimo Usuario registrado: $ultimoUsuario");
        },
        child: Icon(Icons.people),
      ),
    );
  }
}
