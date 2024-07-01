import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextStyle textStyle;
  final TextDirection textDirection;
  final IconData? icon;
  final String? Function(String?)? validator;
  final double width;
  final double height;

  CustomTextField(
      this.hintText,
      this.controller, {
        this.textStyle = const TextStyle(
          fontSize: 18,
          color: Colors.black,
          fontFamily: 'Changa-VariableFont_wght',
        ),
        required this.textDirection,
        this.icon,
        this.validator,
        this.width = 0.0,
        this.height = 0.0,
      });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: hintText,
        filled: true,
        fillColor: Colors.grey[100]!,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color:  Color(0xFF5CBBE3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey[100]!, width: 1.0),
        ),
      ),
      validator: validator ?? (val) {
        if (val!.isEmpty) {
          return "Email cannot be empty";
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(        fontFamily: 'Changa-VariableFont_wght',
      ),
      textAlign: textDirection == TextDirection.rtl
          ? TextAlign.right
          : TextAlign.left,
      textDirection: textDirection,
    );
  }
}
