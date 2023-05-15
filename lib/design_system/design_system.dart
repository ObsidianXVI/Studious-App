library studious.ds;

import 'package:flutter/material.dart';

class StudiousTheme {
  static const Color purple = Color(0xFF5F1CB0);
  static const Color white = Color(0xFFF4F4F9);
}

class StudiousFont {
  static const String defaultFont = 'Rubik';

  static TextStyle megaTitle({required Color color, bool isItalic = false}) {
    return TextStyle(
      color: color,
      fontSize: 70,
      fontWeight: FontWeight.w900,
      fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
      fontFamily: defaultFont,
    );
  }
}
