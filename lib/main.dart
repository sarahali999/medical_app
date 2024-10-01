import 'package:flutter/material.dart';
import 'package:medicapp/pagess/introduction_screen.dart';
import 'package:medicapp/pagess/splash_screen.dart';

import 'home_page_all/home.dart';
import 'languages/lang.dart';


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
        fontFamily: "Main",
      ),
      home: Directionality(
        textDirection: _isRtlLanguage(_selectedLanguage)
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: SplashScreen(selectedLanguage: _selectedLanguage),
      ),
      routes: {
        '/intro': (context) => IntroScreen(selectedLanguage: _selectedLanguage),
        '/home': (context) => MainScreen(selectedLanguage: _selectedLanguage),
      },
    );
  }

  bool _isRtlLanguage(Language language) {
    return language == Language.Arabic ||
        language == Language.Persian ||
        language == Language.Kurdish;
  }
}
