library studious.db;

import 'package:flutter/material.dart';
import 'package:studious/objects/objects.dart';

class StudentDatabase {
  static Map<String, StudentClass> classes = {
    'music': StudentClass(
      className: 'Class Name',
      memberCount: 24,
      teacherName: 'Mr Tarantino',
      color: Colors.amber,
      assignments: [
        Assignment(
          assignmentName: 'Intro to Hip-Hop',
          description:
              'This assignment introduces you to the world of hip-hop. Listen to the track attached and write down the themes discussed.',
          materials: const [
            MaterialItem(
              fileName: 'Soul Food III',
              materialType: MaterialItemType.audio,
            ),
          ],
          created: DateTime.now(),
          deadline: DateTime.now().add(const Duration(days: 7)),
          allowedFileTypes: [
            MaterialItemType.pdf,
          ],
          reviewConfigs: const ReviewConfigs(
            reviewTemplate: null,
            allowAnonReviewing: false,
          ),
          submittedFiles: [],
          handedIn: false,
          hasFeedback: false,
        ),
      ],
    ),
  };
}