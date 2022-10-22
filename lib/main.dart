import 'package:flutter/material.dart';
import 'package:flutter_hello/providers/estados_provider.dart';
import 'package:flutter_hello/providers/formulario_provider.dart';
import 'package:flutter_hello/providers/tema_provider.dart';
import 'package:flutter_hello/screens/screens.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => TemaProvider())),
        ChangeNotifierProvider(create: ((context) => FormularioProvider())),
        ChangeNotifierProvider(create: ((context) => EstadosProvider())),
      ],
      child: ContentApp(),
    );
  }
}

class ContentApp extends StatelessWidget {
  const ContentApp({
    Key? key,
  }) : super(key: key);

  @override
  build(BuildContext context) {
    final temaProvider = Provider.of<TemaProvider>(context);
    return MaterialApp(
      title: 'Material App',
      //home: LitstadoPantallasScreen(),
      theme: temaProvider.modoLight ? ThemeData.light() : ThemeData.dark(),
      initialRoute: '/',
      routes: {
        LitstadoPantallasScreen.route: (context) => LitstadoPantallasScreen(),
        HomeScreen.route: (context) => HomeScreen(),
        ContainerScreen.route: (context) => ContainerScreen(),
        ScaffoldScreen.route: (context) => ScaffoldScreen(),
        ImagenesScreen.route: (context) => ImagenesScreen(),
        StatefulScreen.route: (context) => StatefulScreen(),
        ProviderScreen.route: (context) => ProviderScreen(),
        FormularioScreen.route: (context) => FormularioScreen(),
        FormularioProviderScreen.route: (context) => FormularioProviderScreen(),
        AlertScreen.route: (context) => AlertScreen(),
      },
    );
  }
}
