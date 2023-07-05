library studious.db;

import 'package:flutter/material.dart';
import 'package:studious/objects/objects.dart';

class Database {
  static Map<String, Class> classes = {
    'music': Class(
      className: 'Class Name',
      memberCount: 24,
      teacherName: 'Mr Tarantino',
      color: Colors.amber,
      assignments: [
        Assignment(
          className: 'Clas name',
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
          assignmentStatus: AssignmentStatus.unread,
          feedbackItem: null,
        ),
      ],
    ),
  };
}
