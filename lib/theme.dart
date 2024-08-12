import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  scaffoldBackgroundColor: Color(0xFFEFF1EE),
  fontFamily: 'Zain', // Set the default font to Zain-Regular
  textTheme: TextTheme(
    headline1: _textStyle,
    headline2: _textStyle,
    headline3: _textStyle,
    headline4: _textStyle,
    headline5: _textStyle,
    headline6: _textStyle,
    subtitle1: _textStyle,
    subtitle2: _textStyle,
    bodyText1: _textStyle,
    bodyText2: _textStyle,
    caption: _textStyle,
    button: _textStyle,
    overline: _textStyle,
  ),
);

const TextStyle _textStyle = TextStyle(
  fontFamily: 'Zain', // Use Zain-Regular font style
);
