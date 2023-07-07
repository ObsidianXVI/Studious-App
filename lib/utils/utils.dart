import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();

double screenHeight(BuildContext context) {
  final padding = MediaQuery.of(context).viewPadding;
  final height = MediaQuery.of(context).size.height;
  return height - padding.top;
}

double screenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

Color semanticColorBasedOnDeadline(DateTime deadline) {
  final DateTime now = DateTime.now();
  if (now.isBefore(deadline.subtract(const Duration(days: 7)))) {
    return Colors.green;
  } else if (now.isAfter(deadline)) {
    return Colors.red;
  } else {
    return Colors.orange;
  }
}

extension DateUtils on DateTime {
  static const List<String> monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  String get summary {
    final List<String> chunks = [];
    chunks.addAll([
      day.toString().padLeft(2, '0'),
      monthNames[month],
      year.toString(),
    ]);
    return chunks.join(' ');
  }
}
