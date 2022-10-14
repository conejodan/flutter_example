import 'package:flutter/material.dart';
import 'package:flutter_hello/screens/screens.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      //home: LitstadoPantallasScreen(),
      initialRoute: '/',
      routes: {
        LitstadoPantallasScreen.route: (context) => LitstadoPantallasScreen(),
        HomeScreen.route: (context) => HomeScreen(),
        ContainerScreen.route: (context) => ContainerScreen(),
        ScaffoldScreen.route: (context) => ScaffoldScreen(),
        ImagenesScreen.route: (context) => ImagenesScreen(),
        StatefulScreen.route: (context) => StatefulScreen(),
      },
    );
  }
}
