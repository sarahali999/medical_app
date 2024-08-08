import 'package:flutter/material.dart';
import 'pagess/splash_screen.dart';
import 'pagess/introduction_screen.dart';
import 'languages/lang.dart';
import 'home_page_all/home.dart';

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
        scaffoldBackgroundColor: Color(0xFFEFF1EE), // Set your desired background color here
        textTheme: TextTheme(
          headline1: TextStyle(
            fontFamily: 'Changa-VariableFont_wght',
          ),
          headline2: TextStyle(
            fontFamily: 'Changa-VariableFont_wght',
          ),
          headline3: TextStyle(
            fontFamily: 'Changa-VariableFont_wght',
          ),
          headline4: TextStyle(
            fontFamily: 'Changa-VariableFont_wght',
          ),
          headline5: TextStyle(
            fontFamily: 'Changa-VariableFont_wght',
          ),
          headline6: TextStyle(
            fontFamily: 'Changa-VariableFont_wght',
          ),
          subtitle1: TextStyle(
            fontFamily: 'Changa-VariableFont_wght',
          ),
          subtitle2: TextStyle(
            fontFamily: 'Changa-VariableFont_wght',
          ),
          bodyText1: TextStyle(
            fontFamily: 'Changa-VariableFont_wght',
          ),
          bodyText2: TextStyle(
            fontFamily: 'Changa-VariableFont_wght',
          ),
          caption: TextStyle(
            fontFamily: 'Changa-VariableFont_wght',
          ),
          button: TextStyle(
            fontFamily: 'Changa-VariableFont_wght',
          ),
          overline: TextStyle(
            fontFamily: 'Changa-VariableFont_wght',
          ),
        ),
      ),
      home: Directionality(
        textDirection: _selectedLanguage == Language.Arabic ||
            _selectedLanguage == Language.Persian ||
            _selectedLanguage == Language.Kurdish
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
}
