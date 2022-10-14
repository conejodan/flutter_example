import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  static String route = "/home_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: const Text(
          'Material App Bar',
        ),
        elevation: 0,
        backgroundColor: Colors.amber,
        actions: [
          Icon(
            Icons.add,
            size: 40,
          ),
          Icon(
            Icons.remove_circle,
            color: Colors.red,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.blue,
            height: 200,
            child: Row(
              children: [
                Column(
                  children: [
                    Text('1'),
                    Text('2'),
                    Text('3'),
                  ],
                ),
                Column(
                  children: [
                    Text('4'),
                    Text('5'),
                    Text('6'),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Container(
            color: Colors.green,
            width: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text('1'),
                    Text('2'),
                    Text('3'),
                  ],
                ),
                Column(
                  children: [
                    Text('4'),
                    Text('5'),
                    Text('6'),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Container(
            color: Colors.pink,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  children: [
                    Text('1'),
                    Text('2'),
                    Text('3'),
                  ],
                ),
                Column(
                  children: [
                    Text('4'),
                    Text('5'),
                    Text('6'),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.blueGrey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text('1'),
                      Text('2'),
                      Text('3'),
                    ],
                  ),
                  Column(
                    children: [
                      Text('4'),
                      Text('5'),
                      Text('6'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(50)),
              padding: EdgeInsets.all(20),
              width: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text('1'),
                      Text('2'),
                      Text('3'),
                    ],
                  ),
                  Column(
                    children: [
                      Text('4'),
                      Text('5'),
                      Text('6'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
