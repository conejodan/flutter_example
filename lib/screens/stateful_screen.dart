import 'package:flutter/material.dart';

class StatefulScreen extends StatefulWidget {
  const StatefulScreen({super.key});

  static String route = 'stateful_screen';

  @override
  State<StatefulScreen> createState() => _StatefulScreenState();
}

class _StatefulScreenState extends State<StatefulScreen> {
  int navigationIndex = 0;

  changeIndex(index) {
    setState(() {
      navigationIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text('Stateful Screen'),
      ),
      body: Pantallas(
        pantallaIndex: navigationIndex,
      ),
      bottomNavigationBar: Navegacion(
        navigationIndex: navigationIndex,
        changeIndex: changeIndex,
      ),
    );
  }
}

class Pantallas extends StatelessWidget {
  const Pantallas({
    Key? key,
    required this.pantallaIndex,
  }) : super(key: key);

  final int pantallaIndex;

  static const List<Widget> _pantallas = [
    Center(
      child: Text('Pantalla 1'),
    ),
    Center(
      child: Text('Pantalla 2'),
    ),
    Center(
      child: Text('Pantalla 3'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return _pantallas[pantallaIndex];
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
            icon: Icon(Icons.workspace_premium_outlined), label: 'Favoritos'),
        BottomNavigationBarItem(icon: Icon(Icons.logout), label: 'Salir'),
      ],
    );
  }
}
