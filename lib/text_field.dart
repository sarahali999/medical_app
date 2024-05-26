import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final TextStyle? textStyle;
  final TextInputType? keyboardType;
  final TextAlign textAlign;
  final IconData? prefixIcon;
  final bool enabled;
  final bool isPassword;
  final Function(String)? onChanged;

  CustomTextField(
      this.label, this.controller, {
        this.hintText = '',
        this.maxLines = 1,
        this.textAlign = TextAlign.start,
        this.prefixIcon,
        this.enabled = true,
        this.isPassword = false,
        this.onChanged,
        this.textStyle,
        this.keyboardType,
        Key? key,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: getGulzarTextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Changa-VariableFont_wght',

            color: Colors.black,
          ),
        ),
        TextField(
          controller: controller,
          maxLines: maxLines,
          textAlign: textAlign,
          style: getGulzarTextStyle(),
          enabled: enabled,
          obscureText: isPassword,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.all(16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary),
              borderRadius: BorderRadius.circular(10.0),
            ),
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, color: Theme.of(context).colorScheme.primary)
                : null,
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}

TextStyle getGulzarTextStyle({
  double fontSize = 16,
  FontWeight fontWeight = FontWeight.normal,
  fontFamily: 'Changa-VariableFont_wght',

  Color color = Colors.black,
}) {
  return TextStyle(
    fontFamily: 'Changa-VariableFont_wght',
    fontWeight: FontWeight.bold,    fontSize: fontSize,
    color: color,
  );
}