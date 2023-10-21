library studious.db;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:studious/objects/objects.dart';

final db = FirebaseFirestore.instance
  ..useFirestoreEmulator(
    '127.0.0.1',
    8080,
  );

class Database {
  static final CollectionReference<Class> classesColl =
      db.collection('classes').withConverter<Class>(
            fromFirestore: (snapshot, _) => Class.fromJson(snapshot.data()!),
            toFirestore: (classObj, _) => classObj.toJson(),
          );

  static final CollectionReference<Assignment> assignmentsColl = db
      .collection('assignments')
      .withConverter<Assignment>(
        fromFirestore: (snapshot, _) => Assignment.fromJson(snapshot.data()!),
        toFirestore: (assignmentObj, _) => assignmentObj.toJson(),
      );

  static Future<void> init(FirebaseOptions webOptions) async {
    await Firebase.initializeApp(
      options: webOptions,
    );
    await db.enablePersistence();
  }

  static Future<List<Class>> getClasess() async {
    final QuerySnapshot<Class> snapshot = await classesColl.get();
    return [for (final doc in snapshot.docs) doc.data()];
  }

  static Future<List<Assignment>> getAssignments(
      List<String> assignmentIds) async {
    final List<Assignment> results = [];
    for (String assignmentId in assignmentIds) {
      results.add((await assignmentsColl.doc(assignmentId).get()).data()!);
    }
    return results;
  }
}
