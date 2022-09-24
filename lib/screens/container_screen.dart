import 'package:flutter/material.dart';

class ContainerScreen extends StatelessWidget {
  const ContainerScreen({super.key});

  static String route = "/containers";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Container(
          height: 100,
          width: 100,
          color: Colors.red,
        ),
        SizedBox(height: 20,),
        Container(
          height: 100,
          width: double.infinity,
          color: Colors.blue,
        ),

        GestureDetector(
          onTap: () {
            print('dando click');
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: 100,
              width: 100,
              color: Colors.green,
            ),
          ),
        ),
        ContainerYellow(),
      ],),),
    );
  }
}

class ContainerYellow extends StatelessWidget {
  const ContainerYellow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(height: 100, width: 100,
    margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.amber,
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            spreadRadius: 0.1,
            blurRadius: 8,
            offset: Offset(-3, 3)
            )
        ]
      ),
    );
  }
}