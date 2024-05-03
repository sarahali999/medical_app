import 'package:flutter/material.dart';
import 'introduction_screen.dart';
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
      initialRoute: '/',
      routes: {
        '/': (context) => IntroScreen(selectedLanguage: Language.Arabic), // Provide a default language or use a user-selected language here
        '/home': (context) => HomePage(),
      },
    );
  }
}