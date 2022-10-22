import 'package:flutter/material.dart';
import 'package:flutter_hello/providers/estados_provider.dart';
import 'package:flutter_hello/providers/formulario_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormularioProviderScreen extends StatelessWidget {
  const FormularioProviderScreen({super.key});

  static String route = '/formulario_provider_screen';

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FormularioProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario Provider'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
            child: Column(
          children: [
            TextFormField(
              initialValue: provider.usuario,
              decoration: InputDecoration(labelText: 'Usuario'),
              onChanged: (value) {
                provider.usuario = value;
              },
            ),
            TextFormField(
              initialValue: provider.password,
              decoration: InputDecoration(labelText: 'Contraseña'),
              //obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              onChanged: (value) {
                provider.password = value;
              },
            ),
            !provider.isLoading
                ? ElevatedButton(
                    onPressed: () async {
                      final estadosProvider =
                          Provider.of<EstadosProvider>(context, listen: false);
                      estadosProvider.personasAdd(provider.usuario);
                      final prefs = await SharedPreferences.getInstance();
                      prefs.setString('ultimo_usuario', provider.usuario);
                      await provider.login();
                      Navigator.of(context).pop();
                      //provider.isLoading = true;
                      //await Future.delayed(Duration(seconds: 3));
                      //provider.isLoading = false;
                    },
                    child: Text('Login'))
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  )
          ],
        )),
      ),
    );
  }
}
