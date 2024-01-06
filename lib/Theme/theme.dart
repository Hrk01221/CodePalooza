import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Color(0xffe4f3ec),
    primary: Color(0xffbbefd8),
    secondary: Color(0xff26b051),
  )
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      background: Color(0xff515157),
      primary: Colors.black12,
      secondary: Colors.white.withOpacity(0.8),
    )
);