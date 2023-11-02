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

  static final CollectionReference<Submission> submissionsColl = db
      .collection('submissions')
      .withConverter<Submission>(
        fromFirestore: (snapshot, _) => Submission.fromJson(snapshot.data()!),
        toFirestore: (submissionObj, _) => submissionObj.toJson(),
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

  static Future<List<DocumentSnapshot<Assignment>>> getAssignments(
      List<String> assignmentIds) async {
    final List<DocumentSnapshot<Assignment>> results = [
      for (String assignmentId in assignmentIds)
        await assignmentsColl.doc(assignmentId).get()
    ];

    return results;
  }

  static Future<DocumentReference<T>> insert<T extends StudiousObject>(
    CollectionReference<T> collection,
    T object,
  ) async {
    return await collection.add(object);
  }
}
