import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:studious/db/db.dart';
import 'package:studious/db/db_configs.dart';
import 'package:studious/design_system/design_system.dart';
import 'package:studious/objects/objects.dart';
import './views/views.dart' as views;
import './utils/utils.dart' as utils;

String? studentId;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Database.init(webOptions);
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
                  future: getClasses(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      return views.ClassesView(
                        classes: snapshot.data!,
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ),
      },
    );
  }

  Future<List<DocumentSnapshot<Class>>> getClasses() async {
    return Database.getClasess(
        (await Database.getStudent(studentId!)).data()!.enrolledClasses);
  }
}

class RouteNames {
  static const String classes = '/classes';
  static const String launch = '/launch';

/*         '/students/assignment': (BuildContext context) {},
        '/students/view-assignment': (BuildContext context) {},
        '/teachers/classes': (BuildContext context) {},
        '/teachers/assignments': (BuildContext context) {},
        '/teachers/view-assignment': (BuildContext context) {}, */
}
