library studious.ds;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:studious/db/db.dart';
import 'package:studious/objects/objects.dart';
import 'package:studious/utils/utils.dart';
import 'package:studious/views/views.dart';

part './button.dart';
part './input.dart';
part './shelf.dart';
part './view_scaffold.dart';
part './class_card.dart';
part './assignment_card.dart';
part './submission_card.dart';
part './utils.dart';
part 'feedback_overlay.dart';
part './card_shelf.dart';
part 'comment_card.dart';
part './status_card.dart';
part './loading_indicator.dart';
part './activity_card.dart';

class StudiousTheme {
  static const Color lightPurple = Color(0xFF8b6eae);
  static const Color purple = Color(0xFF5F1CB0);
  static const Color darkPurple = Color(0xFF3D0483);
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

  static TextStyle appBarTitle() {
    return const TextStyle(
      color: StudiousTheme.white,
      fontSize: 34,
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.normal,
      fontFamily: defaultFont,
    );
  }

  static TextStyle viewTitle() {
    return const TextStyle(
      color: StudiousTheme.purple,
      fontSize: 40,
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.normal,
      fontFamily: defaultFont,
    );
  }

  static TextStyle body() {
    return const TextStyle(
      color: StudiousTheme.purple,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      fontFamily: defaultFont,
    );
  }

  static TextStyle buttonText() {
    return const TextStyle(
      color: StudiousTheme.white,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      fontFamily: defaultFont,
    );
  }
}
