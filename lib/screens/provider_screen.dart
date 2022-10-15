import 'package:flutter/material.dart';
import 'package:flutter_hello/providers/estados_provider.dart';
import 'package:flutter_hello/providers/tema_provider.dart';
import 'package:provider/provider.dart';

class ProviderScreen extends StatelessWidget {
  const ProviderScreen({super.key});

  static String route = '/provider';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EstadosProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Provider Screen'),
        ),
        backgroundColor: Colors.grey.shade200,
        body: PantallasProvider(),
        bottomNavigationBar: NavegacionDos(),
        floatingActionButton: MiFloatingActionButton(),
      ),
    );
  }
}

class MiFloatingActionButton extends StatelessWidget {
  const MiFloatingActionButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        final estadosProvider =
            Provider.of<EstadosProvider>(context, listen: false);
        estadosProvider.personasAdd('Juan');
      },
      child: Icon(Icons.add),
    );
  }
}

class PantallasProvider extends StatelessWidget {
  const PantallasProvider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final estadosProvider = Provider.of<EstadosProvider>(context);
    int pantallaIndex = estadosProvider.navigationIndex;
    if (pantallaIndex == 0) {
      return PantallaUnoProvider();
    }
    if (pantallaIndex == 1) {
      return PantallaDosProvider();
    }
    if (pantallaIndex == 2) {
      return Pantalla3();
    }
    return Center();
  }
}

class Pantalla3 extends StatelessWidget {
  const Pantalla3({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final estadosProvider = Provider.of<EstadosProvider>(context);
    return ListView(
      children: [
        ...estadosProvider.personas.map((persona) => ListTile(
              title: Text(persona),
            ))
      ],
    );
  }
}

class PantallaDosProvider extends StatelessWidget {
  const PantallaDosProvider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          final estadosProvider = Provider.of<EstadosProvider>(
            context,
            listen: false,
          );
          estadosProvider.navigationIndex = 0;
        },
        child: Text('Inicio'),
      ),
    );
  }
}

class PantallaUnoProvider extends StatelessWidget {
  const PantallaUnoProvider({super.key});

  @override
  Widget build(BuildContext context) {
    final estadosProvider = Provider.of<EstadosProvider>(context);
    final temaProvider = Provider.of<TemaProvider>(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Pantalla 1'),
          Switch(
              value: estadosProvider.switchValue,
              onChanged: (valor) {
                print('Elemento Switch');
                estadosProvider.switchValue = valor;
                temaProvider.modoLight = valor;
              })
        ],
      ),
    );
  }
}

class NavegacionDos extends StatelessWidget {
  const NavegacionDos({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final estadosProvider = Provider.of<EstadosProvider>(context);
    return BottomNavigationBar(
      onTap: ((value) {
        estadosProvider.navigationIndex = value;
      }),
      currentIndex: estadosProvider.navigationIndex,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.workspace_premium_outlined),
          label: 'Favoritos',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.logout), label: 'Salir'),
      ],
    );
  }
}
