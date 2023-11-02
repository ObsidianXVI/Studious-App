part of studious.objects;

class User extends StudiousObject {
  String name;

  User({
    required this.name,
  });

  @override
  Map<String, Object?> toJson() => {
        'name': name,
      };
}

class Student extends User {
  String formClass;
  Map<DocumentSnapshot<Assignment>, DocumentSnapshot<Submission>> submissions;

  Student({
    required this.formClass,
    required this.submissions,
    required super.name,
  });

  @override
  Map<String, Object?> toJson() => {
        ...super.toJson(),
        'formClass': formClass,
        'submissions': {
          for (final sub in submissions.entries) {sub.key.id: sub.value.id}
        }
      };
}
