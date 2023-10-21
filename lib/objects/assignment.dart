part of studious.objects;

enum AssignmentStatus {
  unread('Unread'),
  inProgress('In Progress'),
  attempted('Attempted'),
  submitted("Submitted"),
  overdue('Overdue');

  final String label;
  const AssignmentStatus(this.label);

  static AssignmentStatus fromString(String name) {
    switch (name) {
      case "Unread":
        return AssignmentStatus.unread;
      case "In Progress":
        return AssignmentStatus.inProgress;
      case "Attempted":
        return AssignmentStatus.attempted;
      case "Submitted":
        return AssignmentStatus.submitted;
      case "Overdue":
        return AssignmentStatus.overdue;
    }
    throw "Invalid assignment status $name";
  }
}

class Assignment extends StudiousObject {
  final String assignmentName;
  final String description;
  final List<MaterialItem> materials;
  final List<MaterialItemType> allowedFileTypes;
  final ReviewConfigs reviewConfigs;
  final DateTime created;
  final DateTime deadline;
  final String className;
  AssignmentStatus assignmentStatus;
  FeedbackItem? feedbackItem;

  Assignment({
    required this.assignmentName,
    required this.description,
    required this.materials,
    required this.className,
    required this.reviewConfigs,
    required this.allowedFileTypes,
    required this.created,
    required this.deadline,
    required this.feedbackItem,
    required this.assignmentStatus,
  });

  Assignment.fromJson(Map<String, Object?> json)
      : assignmentName = json['assignmentName']! as String,
        description = json['description'] as String,
        materials = [
          for (final mat
              in (json['materials'] as List).cast<Map<String, Object?>>())
            MaterialItem.fromJson(mat)
        ],
        allowedFileTypes = [
          for (final mat in (json['allowedFileTypes'] as List).cast<String>())
            MaterialItemType.fromString(mat)
        ],
        reviewConfigs = ReviewConfigs.fromJson(
            json['reviewConfigs'] as Map<String, Object?>),
        created = DateTime.parse(json['created'] as String),
        deadline = DateTime.parse(json['deadline'] as String),
        className = json['className']! as String,
        assignmentStatus =
            AssignmentStatus.fromString(json['assignmentStatus'] as String),
        feedbackItem = json.containsKey('feedbackItem')
            ? FeedbackItem.fromJson(
                json['feedbackItem'] as Map<String, Object?>)
            : null;

  Map<String, Object?> toJson() => {
        'assignmentName': assignmentName,
        'description': description,
        'materials': [for (final mat in materials) mat.toJson()],
        'allowedFileTypes': [for (final ftype in allowedFileTypes) ftype.ext],
        'reviewConfigs': reviewConfigs.toJson(),
        'created': created.toIso8601String(),
        'deadline': deadline.toIso8601String(),
        'className': className,
        'assignmentStatus': assignmentStatus.label,
        'feedbackItem': feedbackItem?.toJson(),
      };
}
