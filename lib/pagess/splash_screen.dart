import 'package:flutter/material.dart';
import 'dart:async';
import '../languages/lang.dart';
import 'introduction_screen.dart';

class SplashScreen extends StatelessWidget {

  final Language selectedLanguage;

  const SplashScreen({Key? key, required this.selectedLanguage}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => IntroScreen(selectedLanguage:selectedLanguage ,)),
      );
    }
  );

    return Scaffold(
      backgroundColor:Color(0xFF1AD0C0),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/i30.png'),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
