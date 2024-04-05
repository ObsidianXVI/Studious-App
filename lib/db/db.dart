library studious.db;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:studious/objects/objects.dart';
import 'package:studious/db/db_configs.dart';

final db = FirebaseFirestore.instance
  ..useFirestoreEmulator(
    '127.0.0.1',
    8082,
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

  static final CollectionReference<Student> usersColl =
      db.collection('users').withConverter(
            fromFirestore: (snapshot, _) => Student.fromJson(snapshot.data()!),
            toFirestore: (userObj, _) => userObj.toJson(),
          );

  static Future<void> init() async {
    await Firebase.initializeApp(options: webOptions);
  }

  static Future<List<DocumentSnapshot<Class>>> getClasses(
    List<String> classIds,
  ) async {
    final List<DocumentSnapshot<Class>> results = [
      for (String classId in classIds) await classesColl.doc(classId).get()
    ];

    return results;
  }

  static Future<List<DocumentSnapshot<Assignment>>> getAssignments(
    List<String> assignmentIds,
  ) async {
    final List<DocumentSnapshot<Assignment>> results = [
      for (String assignmentId in assignmentIds)
        await assignmentsColl.doc(assignmentId).get()
    ];

    return results;
  }

  static Future<List<DocumentSnapshot<Assignment>>>
      getAssignmentsDueSoon() async {
    final int curr = DateTime.now().millisecondsSinceEpoch;
    final List<DocumentSnapshot<Assignment>> results = (await assignmentsColl
            .where('deadline', isGreaterThanOrEqualTo: curr)
            .where('deadline', isLessThan: curr + (7 * 24 * 60 * 60 * 1000))
            .get())
        .docs;
    return results;
  }

  static Future<DocumentSnapshot<Student>> getStudent(String studentId) {
    return usersColl.doc(studentId).get();
  }

  static Future<DocumentSnapshot<Submission>> getSubmission(
      String submissionId) {
    return submissionsColl.doc(submissionId).get();
  }

  static Future<DocumentReference<T>> insert<T extends StudiousObject>(
    CollectionReference<T> collection,
    T object,
  ) async {
    return await collection.add(object);
  }

  static Future<void> update<T extends StudiousObject>(
    CollectionReference<T> collectionReference,
    String id,
    Map<Object, Object?> data,
  ) {
    return collectionReference.doc(id).update(data);
  }

  static Future<void> delete<T extends StudiousObject>(
    CollectionReference<T> collectionReference,
    String id,
  ) {
    return collectionReference.doc(id).delete();
  }

  static Future<List<DocumentSnapshot<T>>> getAll<T>(
    CollectionReference<T> collection,
    List<String> ids,
  ) async {
    final List<DocumentSnapshot<T>> results = [
      for (String id in ids) await collection.doc(id).get()
    ];

    return results;
  }
}
