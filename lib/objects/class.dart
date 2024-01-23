part of studious.objects;

class Class extends StudiousObject {
  String className;
  int memberCount;
  String teacherName;
  Color color;
  List<String> assignments;

  Class({
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

  @override
  Map<String, Object?> toJson() => {
        'className': className,
        'memberCount': memberCount,
        'teacherName': teacherName,
        'color': color.value,
        'assignments': assignments,
      };
}
