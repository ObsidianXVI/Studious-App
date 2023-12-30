import 'package:flutter/material.dart';
import 'package:studious/main.dart';

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

  String get timeAgo {
    Duration diff = DateTime.now().difference(this);
    final String result;
    if (diff.inDays > 365) {
      result =
          "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
    } else if (diff.inDays > 30) {
      result =
          "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
    } else if (diff.inDays > 7) {
      result =
          "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
    } else if (diff.inDays > 0) {
      result = "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
    } else if (diff.inHours > 0) {
      result = "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
    } else if (diff.inMinutes > 0) {
      result =
          "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
    } else {
      result = "just now";
    }
    return result;
  }
}

extension StringUtils on String {
  bool containsSubset(String other) =>
      toLowerCase().contains(other.toLowerCase());
}

void ensureAuthenticated(BuildContext context) {
  showDialog(
    context: context,
    builder: (buildContext) => Center(
      child: Container(
        width: 600,
        height: 300,
        child: Column(
          children: [
            Text('Please log in to access this page'),
            const SizedBox(height: 50),
            TextButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(RouteNames.launch),
              child: Text('Go to login'),
            ),
          ],
        ),
      ),
    ),
  );
}
