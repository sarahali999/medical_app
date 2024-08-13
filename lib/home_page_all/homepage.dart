import 'package:flutter/material.dart';
import '../languages/lang.dart';
import 'AnimatedClinicNews.dart';
import 'AnimatedUserCard.dart';
import 'animated_examination_cards.dart';
import 'dart:ui';

class Homepage extends StatelessWidget {
  final Language selectedLanguage;
  Homepage({required this.selectedLanguage});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedSpecialText(),
            AnimatedUserCard(selectedLanguage: selectedLanguage),
            AnimatedExaminationCards(
              parentContext: context,
              selectedLanguage: selectedLanguage,
            ),
            _buildSectionTitle(sectionTitle),
            AnimatedClinicNews(),
          ],
        ),
      ),
    );
  }

  String get sectionTitle {
    switch (selectedLanguage) {
      case Language.Arabic:
        return 'اخر الاخبار';
      case Language.Persian:
        return 'آخرین اخبار';
      case Language.Kurdish:
        return 'نووسینە تایبەتی';
      case Language.Turkmen:
        return 'Dernières nouvelles';
      default:
        return 'Latest News';
    }
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}

class AnimatedSpecialText extends StatefulWidget {
  @override
  _AnimatedSpecialTextState createState() => _AnimatedSpecialTextState();
}

class _AnimatedSpecialTextState extends State<AnimatedSpecialText> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1, end: 1.1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _controller.forward().then((_) => _controller.reverse());
      },
      child: ScaleTransition(
        scale: _animation,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Container(
                child:Text(
                  "الحسين(ع) هو المنطق.. الحسين(ع) هو الطريق.. الحسين(ع) هو الانتصار",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontFamily: 'Amiri',
                    fontStyle: FontStyle.italic,
                    shadows: [
                      Shadow(
                        blurRadius: 8.0,
                        color: Colors.grey,
                        offset: Offset(1.0, 1.0),
                      ),
                    ],
                  ),
                )
            ),
          ),
        ),
      ),
    );
  }
}
