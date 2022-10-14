import 'package:flutter/material.dart';

class StatefulScreen extends StatefulWidget {
  const StatefulScreen({super.key});

  static String route = 'stateful_screen';

  @override
  State<StatefulScreen> createState() => _StatefulScreenState();
}

class _StatefulScreenState extends State<StatefulScreen> {
  bool valor = false;

  cambiandoValor(bool nuevoValor) {
    print('cambiandoValor');
    setState(() {
      valor = nuevoValor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text('Stateful Screen'),
      ),
      body: Contenido(
        valor: valor,
        onChange: cambiandoValor,
      ),
    );
  }
}

class Contenido extends StatelessWidget {
  const Contenido({
    Key? key,
    required this.valor,
    this.onChange,
  }) : super(
          key: key,
        );

  final bool valor;
  final Function(bool)? onChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [MiCard(valor: valor, onChange: onChange)],
      ),
    );
  }
}

class MiCard extends StatelessWidget {
  const MiCard({
    Key? key,
    required this.valor,
    required this.onChange,
  }) : super(key: key);

  final bool valor;
  final Function(bool p1)? onChange;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: MiFila(valor: valor, onChange: onChange),
      ),
    );
  }
}

class MiFila extends StatelessWidget {
  const MiFila({
    Key? key,
    required this.valor,
    required this.onChange,
  }) : super(key: key);

  final bool valor;
  final Function(bool p1)? onChange;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('Desactivado / Activado'),
        Switch(value: valor, onChanged: onChange),
      ],
    );
  }
}
