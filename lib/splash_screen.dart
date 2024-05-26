import 'package:flutter/material.dart';
import 'dart:async';
import 'introduction_screen.dart';
import 'lang.dart';

class SplashScreen extends StatelessWidget {
  final Language selectedLanguage;

  const SplashScreen({Key? key, required this.selectedLanguage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => IntroScreen(selectedLanguage: selectedLanguage)),
      );
    });

    return Scaffold(
      backgroundColor:Color(0xFF80CBC4),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Medical Project',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Changa-VariableFont_wght',
              ),
            ),
            SizedBox(height: 20),
           CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}