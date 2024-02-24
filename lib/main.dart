import 'package:flutter/material.dart';
import 'home_page.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(
          bodyText1: TextStyle(
            fontFamily: 'Cairo',
          ),
          bodyText2: TextStyle(
            fontFamily: 'Cairo',
          ),
        ),
      ),
      home: HomePage(),
    );
  }
}