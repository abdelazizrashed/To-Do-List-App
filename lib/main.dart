import 'package:flutter/material.dart';

void main() async{
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Something'),
        ),
      )
    );
  }
}
