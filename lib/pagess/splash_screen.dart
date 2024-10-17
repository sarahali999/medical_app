import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';  // استيراد SharedPreferences
import '../home_page_all/home.dart';
import '../languages/lang.dart';
import 'introduction_screen.dart';

class SplashScreen extends StatefulWidget {
  final Language selectedLanguage;
  const SplashScreen({Key? key, required this.selectedLanguage}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 10),
      vsync: this,
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Interval(0.0, 0.5, curve: Curves.easeIn)),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Interval(0.0, 0.5, curve: Curves.easeOutBack)),
    );

    _controller.forward();

    _checkTokenAndNavigate();  // تحقق من الـ token وقم بالتوجيه
  }

  Future<void> _checkTokenAndNavigate() async {
    // الحصول على SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // التحقق مما إذا كان الـ token موجودًا
    String? token = prefs.getString('token');

    // بعد مدة العرض (5 ثواني)، قم بتوجيه المستخدم بناءً على حالة الـ token
    Timer(Duration(seconds: 5), () {
      if (token != null && token.isNotEmpty) {
        // إذا كان الـ token موجودًا، قم بتوجيه المستخدم إلى MainScreen
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => MainScreen(selectedLanguage: widget.selectedLanguage),
          ),
        );
      } else {
        // إذا لم يكن هناك token، قم بتوجيه المستخدم إلى IntroScreen
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => IntroScreen(selectedLanguage: widget.selectedLanguage),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF5CBBE3),
                  Color(0xFF5CBBE3).withOpacity(_controller.value),
                  Colors.white.withOpacity(_controller.value),
                ],
              ),
            ),
            child: Center(
              child: FadeTransition(
                opacity: _opacityAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Image.asset('assets/images/iii.png'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
