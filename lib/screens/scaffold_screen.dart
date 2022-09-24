import 'package:flutter/material.dart';

class ScaffoldScreen extends StatelessWidget {
  const ScaffoldScreen({super.key});

  static String route = "/scaffolds";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(color: Colors.cyan,
        child: SafeArea(
          child: Column(
            children: [
              Text('Texto 1'),
              Text('Texto 2'),
              Text('Texto 3'),
            ],
          ),
        ),
        ),
      ),
      endDrawer: Drawer(
        child: Container(color: Colors.cyan,
        child: Column(
          children: [
            Text('Texto 1'),
            Text('Texto 2'),
            Text('Texto 3'),
          ],
        ),
        ),
      ),
      appBar: AppBar(
        title: Text('Scaffold Screen'),
        elevation: 0,
        //backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.grey.shade100,
      body: Center(child: Container(
        padding: EdgeInsets.only(top: 2, right: 6, bottom: 10, left: 15), 
        color: Colors.white,
        child: Text('ScaffoldScreen'),
        )
        ),
        //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        //floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('floating action button');
        },
        child: Icon(Icons.add),
      ),
        );
  }
}