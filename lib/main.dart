import 'package:flutter/material.dart';
import 'package:studious/db/db.dart';
import 'package:studious/db/db_configs.dart';
import 'package:studious/design_system/design_system.dart';
import 'package:studious/objects/objects.dart';
import './views/views.dart' as views;
import './core/studious_core.dart' as core;
import './utils/utils.dart' as utils;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Database.init(webOptions);
  runApp(const StudiousApp());
}

class StudiousApp extends StatelessWidget {
  const StudiousApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: utils.snackbarKey,
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
      initialRoute: core.NavRoutes.classes,
      routes: {
        '/test': (BuildContext context) {
          return views.Teacher_Assignment_Editor_View(
            assignment: Assignment(
              assignmentName: 'assignmentName',
              description: 'description',
              materials: [],
              reviewConfigs: const ReviewConfigs(
                reviewTemplate: null,
                allowAnonReviewing: false,
              ),
              allowedFileTypes: [],
              created: DateTime.now(),
              deadline: DateTime.now().add(const Duration(days: 3)),
              submittedFiles: [],
              feedbackItem: null,
              assignmentStatus: AssignmentStatus.attempted,
              className: 'Munsic',
            ),
          );
        },
        core.NavRoutes.classes: (BuildContext context) {
          return Material(
            child: SelectionArea(
              child: views.ClassesView(
                classes: Database.classes.values.toList(),
              ),
            ),
          );
        },
        core.NavRoutes.assignments: (BuildContext context) {
          return Material(
            child: views.AssignmentsView(
              assignments:
                  Database.classes.values.expand((e) => e.assignments).toList(),
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

/**
 * SelectionArea(
            child: views.Teacher_Assignment_Viewer(
              className: 'CLass x',
              assignment: Assignment(
                assignmentName: 'assignmentName',
                description: 'description',
                materials: [],
                reviewConfigs: const ReviewConfigs(
                  reviewTemplate: null,
                  allowAnonReviewing: false,
                ),
                allowedFileTypes: [],
                created: DateTime.now(),
                deadline: DateTime.now().add(const Duration(days: 3)),
                submittedFiles: [],
                feedbackItem: null,
                assignmentStatus: AssignmentStatus.attempted,
                className: 'Munsic',
              ),
            ),
          )
 */