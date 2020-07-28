import 'package:flutter/material.dart';
import 'package:fractaltest/screens/home/home.dart';
import 'package:fractaltest/screens/search/search.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.teal,
        canvasColor: Colors.transparent,
      ),
      routes: <String, WidgetBuilder> {
        '/': (BuildContext context) => Home(),
        '/search' : (BuildContext context) => Search(),
      },
    );
  }
}

