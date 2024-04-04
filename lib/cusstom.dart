import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextStyle textStyle;
  final TextDirection textDirection;
  final IconData? icon;
  final String? Function(String?)? validator;

  CustomTextField(
      this.hintText,
      this.controller,
      {
        this.textStyle = const TextStyle(
          fontSize: 18,
          color: Colors.black,
          fontFamily: 'Cairo',
        ),
        required this.textDirection,
        this.icon,
        this.validator,
      });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: textStyle,
        icon: icon != null ? Icon(icon) : null,
      ),
      style: textStyle,
      textAlign: textDirection == TextDirection.rtl
          ? TextAlign.right
          : TextAlign.left,
      textDirection: textDirection,
      validator: validator,
    );
  }
}