

import 'package:flutter/material.dart';

class AppStyles {
  static const Color primaryColor = Color(0xFF5CBBE3);
  static const Color secondaryColor = Color(0xFF3A8ED0);

  static InputDecoration textFieldDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.grey[100],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    );
  }

  static TextStyle headerStyle = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.bold,
    color: primaryColor,
  );

  static ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    primary: primaryColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    padding: EdgeInsets.symmetric(vertical: 15),
  );
}

