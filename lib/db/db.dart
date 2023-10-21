library studious.db;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

final db = FirebaseFirestore.instance
  ..useFirestoreEmulator(
    '127.0.0.1',
    8080,
  );

class Database {
  static Future<void> init(FirebaseOptions webOptions) async {
    await Firebase.initializeApp(
      options: webOptions,
    );
    await db.enablePersistence();
  }
}
