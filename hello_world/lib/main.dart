import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Hello World App',
      theme: ThemeData(
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Hello World App')
        ),
        body: Center(
          child: Text(
            'Hello World',
            style: TextStyle(
              fontSize: 75,
              color: Colors.blue,
            ),
          )
        ),
      ),
    );
  }
}
