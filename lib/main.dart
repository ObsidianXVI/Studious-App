import 'package:flutter/material.dart';
import 'package:studious/db/db.dart';
import 'package:studious/design_system/design_system.dart';
import './views/views.dart' as views;
import './core/studious_core.dart' as core;

void main() {
  runApp(const StudiousApp());
}

class StudiousApp extends StatelessWidget {
  const StudiousApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Rubik',
        inputDecorationTheme: const InputDecorationTheme(
          focusedBorder: InputBorder.none,
        ),
        iconTheme: const IconThemeData(
          color: StudiousTheme.purple,
          size: 20,
        ),
      ),
      routes: {
        core.NavRoutes.teachers_classes: (BuildContext context) {
          return Material(
            child: views.Teacher_Classes_View(),
          );
        },
        core.NavRoutes.students_classes: (BuildContext context) {
          return Material(
            child: views.Student_Classes_View(
              classes: StudentDatabase.classes.values.toList(),
            ),
          );
        },
/* 
        '/teachers/assignments': (BuildContext context) {},
        '/teachers/view-assignment': (BuildContext context) {}, */
      },
      home: Material(
        child: views.LaunchView(
          key: key,
        ),
      ),
    );
  }
}
