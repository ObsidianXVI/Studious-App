import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:studious/db/db.dart';
import 'package:studious/design_system/design_system.dart';
import 'package:studious/objects/objects.dart';
import './views/views.dart' as views;
import './utils/utils.dart' as utils;

String? studentId;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Database.init();
  runApp(const StudiousApp());
}

class StudiousApp extends StatefulWidget {
  const StudiousApp({super.key});

  @override
  State<StatefulWidget> createState() => StudiousAppState();
}

class StudiousAppState extends State<StudiousApp> {
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
      initialRoute: RouteNames.launch,
      routes: {
        RouteNames.launch: (_) => const Material(
              child: views.LaunchView(),
            ),
        RouteNames.classes: (_) => Material(
              child: SelectionArea(
                child: FutureBuilder(
                  future: () async {
                    if (studentId == null && mounted) {
                      Navigator.of(context).pushNamed(RouteNames.launch);
                    } else {
                      return await getClasses(studentId!);
                    }
                  }(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return views.ClassesView(
                        classes: snapshot.data!,
                      );
                    } else {
                      return const LoadingIndicator();
                    }
                  },
                ),
              ),
            ),
        RouteNames.activity: (_) => Material(
              child: FutureBuilder(
                future: () async {
                  if (studentId == null && mounted) {
                    Navigator.of(context).pushNamed(RouteNames.launch);
                  } else {
                    return await getActivities(studentId!);
                  }
                }(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return views.ActivityView(activites: snapshot.data!);
                  } else {
                    return const LoadingIndicator();
                  }
                },
              ),
            ),
      },
    );
  }

  Future<List<DocumentSnapshot<Class>>> getClasses(String studentId) async {
    return Database.getClasses(
        (await Database.getStudent(studentId)).data()!.enrolledClasses);
  }

  Future<List<Activity>> getActivities(String studentId) async {
    return (await Database.getStudent(studentId)).data()!.activities;
  }
}

class RouteNames {
  static const String classes = '/classes';
  static const String launch = '/launch';
  static const String activity = '/activity';
}
