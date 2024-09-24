import 'package:flutter/material.dart';
import 'pagess/splash_screen.dart';
import 'pagess/introduction_screen.dart';
import 'languages/lang.dart';
import 'home_page_all/home.dart';
import 'theme.dart';

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
      // theme: ThemeData(
      //   fontFamily: "Zain",
      // )
      // ,

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
