import 'package:flutter/material.dart';

class StatefulScreen extends StatefulWidget {
  const StatefulScreen({super.key});

  static String route = 'stateful_screen';

  @override
  State<StatefulScreen> createState() => _StatefulScreenState();
}

class _StatefulScreenState extends State<StatefulScreen> {
  int navigationIndex = 0;

  changeIndex(int index) {
    print('Se selecciono la opcion ');
    print(index);

    setState(() {
      navigationIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('Se ejecuta el build');
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text('Stateful Screen'),
      ),
      body: Pantallas(
        pantallaIndex: navigationIndex,
        changeIndex: changeIndex,
      ),
      bottomNavigationBar: Navegacion(
        navigationIndex: navigationIndex,
        changeIndex: changeIndex,
      ),
    );
  }
}

class Pantallas extends StatelessWidget {
  Pantallas({
    Key? key,
    required this.pantallaIndex,
    required this.changeIndex,
  }) : super(key: key);

  final int pantallaIndex;
  final void Function(int)? changeIndex;

  //List<Widget> _pantallas = [
  //  PantallaUno(),
  //  PantallaDos(
  //    changeIndex: changeIndex,
  //  ),
  //  Center(
  //    child: Text('Pantalla 3'),
  //  ),
  //];

  @override
  Widget build(BuildContext context) {
    if (pantallaIndex == 0) {
      return PantallaUno();
    }
    if (pantallaIndex == 1) {
      return PantallaDos(changeIndex: changeIndex);
    }
    if (pantallaIndex == 2) {
      return Center(
        child: Text('Pantalla 3'),
      );
    }
    return Center();
  }
}

class PantallaDos extends StatelessWidget {
  const PantallaDos({
    Key? key,
    required this.changeIndex,
  }) : super(key: key);

  final Function(int)? changeIndex;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          changeIndex!(0);
        },
        child: Text('Inicio'),
      ),
    );
  }
}

class PantallaUno extends StatefulWidget {
  const PantallaUno({
    Key? key,
  }) : super(key: key);

  @override
  State<PantallaUno> createState() => _PantallaUnoState();
}

class _PantallaUnoState extends State<PantallaUno> {
  bool _switch = true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Pantalla 1'),
          Switch(
              value: _switch,
              onChanged: (valor) {
                setState(() {
                  _switch = valor;
                });
                print('Elemento Switch');
                print(_switch);
              })
        ],
      ),
    );
  }
}

class Navegacion extends StatelessWidget {
  const Navegacion({
    Key? key,
    required this.navigationIndex,
    required this.changeIndex,
  }) : super(key: key);

  final int navigationIndex;

  final Function(int)? changeIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: changeIndex,
      currentIndex: navigationIndex,
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
