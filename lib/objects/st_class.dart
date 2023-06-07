part of studious.objects;

class StudentClass extends StudiousObject {
  final String className;
  final int memberCount;
  final String teacherName;
  final Color color;

  StudentClass({
    required this.className,
    required this.memberCount,
    required this.teacherName,
    required this.color,
  });
}
