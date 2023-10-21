part of studious.objects;

class Class extends StudiousObject {
  final String className;
  final int memberCount;
  final String teacherName;
  final Color color;
  final List<String> assignments;

  const Class({
    required this.className,
    required this.memberCount,
    required this.teacherName,
    required this.color,
    required this.assignments,
  });

  Class.fromJson(Map<String, Object?> json)
      : className = json['className']! as String,
        memberCount = json['memberCount'] as int,
        teacherName = json['teacherName'] as String,
        color = Color(int.parse(json['color'] as String)),
        assignments = (json['assignments'] as List).cast<String>();

  Map<String, Object?> toJson() => {
        'className': className,
        'memberCount': memberCount,
        'teacherName': teacherName,
        'color': color.value,
        'assignments': assignments,
      };
}
