import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'introduction_screen.dart';
import 'lang.dart';
import 'homee.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Language _selectedLanguage = Language.Arabic;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
          bodyText1: TextStyle(
            fontFamily: 'Changa-VariableFont_wght',
          ),
          bodyText2: TextStyle(
            fontFamily: 'Changa-VariableFont_wght',
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(selectedLanguage: _selectedLanguage),
        '/intro': (context) => IntroScreen(selectedLanguage: _selectedLanguage),
        '/home': (context) => HomeScreen(selectedLanguage: _selectedLanguage),
      },
    );
  }
}
