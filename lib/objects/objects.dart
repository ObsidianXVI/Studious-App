library studious.objects;

import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

part './st_class.dart';
part 'assignment.dart';
part './material_item.dart';
part './review_configs.dart';
part './comment_item.dart';
part 'user.dart';
part './submission.dart';

abstract class StudiousObject {
  const StudiousObject();

  @mustCallSuper
  Map<String, Object?> toJson();
}
