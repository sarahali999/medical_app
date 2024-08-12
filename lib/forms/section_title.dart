import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16, top: 24),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Color(0xFF5CBBE3),
        ),
      ).animate()
          .fadeIn(duration: 600.ms, curve: Curves.easeOutQuad)
          .slideX(begin: -0.2, end: 0, duration: 600.ms, curve: Curves.easeOutQuad)
          .scale(begin: Offset(0.8, 0.8), end: Offset(1, 1), duration: 600.ms, curve: Curves.easeOutQuad),
    );
  }
}