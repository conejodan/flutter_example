import 'package:flutter/material.dart';
import 'package:flutter_hello/screens/screens.dart';

class AlertScreen extends StatelessWidget {
  const AlertScreen({super.key});

  static String route = "/alertas";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mensaje de Alerta'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Alerta'),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Titulo del dialogo'),
                  content: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text('Esto es un mensaje'), TextFormField()],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Inicio'),
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed(
                            LitstadoPantallasScreen.route);
                      },
                    ),
                    TextButton(
                      child: const Text('Cerrar'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: const Text('Guardar'),
                      onPressed: () {
                        Navigator.of(context)
                            .popAndPushNamed(FormularioScreen.route);
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
