part of studious.objects;

class User extends StudiousObject {
  String name;
  String username;
  String password;

  User({
    required this.name,
    required this.username,
    required this.password,
  });

  User.fromJson(Map<String, Object?> json)
      : name = json['name']! as String,
        username = json['username']! as String,
        password = json['password']! as String;

  @override
  Map<String, Object?> toJson() => {
        'name': name,
        'username': username,
        'password': password,
      };
}

class Student extends User {
  String formClass;
  List<String> enrolledClasses;
  Map<String, String> submissions;
  List<Activity> activities;

  Student({
    required this.formClass,
    required this.submissions,
    required this.enrolledClasses,
    required this.activities,
    required super.name,
    required super.username,
    required super.password,
  });

  Student.fromJson(Map<String, Object?> json)
      : formClass = json['formClass']! as String,
        enrolledClasses = (json['enrolledClasses'] as List).cast<String>(),
        submissions =
            Map<String, String>.from(json['submissions'] as LinkedHashMap),
        activities = [
          for (var a in (json['activities'] as List))
            Activity.fromJson(Map<String, Object?>.from(a as LinkedHashMap))
        ],
        super.fromJson(json);

  @override
  Map<String, Object?> toJson() => {
        ...super.toJson(),
        'formClass': formClass,
        'submissions': submissions,
        'activities': [for (var a in activities) a.toJson()],
      };

  AssignmentStatus statusForAssignment(
      DocumentSnapshot<Assignment> assignment) {
    if (submissions.containsKey(assignment.id)) {
      return AssignmentStatus.submitted;
    } else {
      return AssignmentStatus.inProgress;
    }
  }
}
