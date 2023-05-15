import 'package:flutter/material.dart';
import './views/views.dart';

void main() {
  runApp(const StudiousApp());
}

class StudiousApp extends StatelessWidget {
  const StudiousApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LaunchView(
        key: key,
      ),
    );
  }
}
