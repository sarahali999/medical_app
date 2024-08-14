import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingScreen extends StatelessWidget {
  final VoidCallback onLoaded; // Add this line

  LoadingScreen({Key? key, required this.onLoaded}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      onLoaded();
    }
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      body:  Center(
        child: Lottie.asset('assets/lottie/1.json'),
      ),
    );
  }
}
