import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      theme: new ThemeData(
        primaryColor: Colors.black,
      ),
      home: new Scaffold(
        appBar: AppBar(
          title: Text("New App")
        ),
        body: new Text("Hello")
      )
    );
  }
}
