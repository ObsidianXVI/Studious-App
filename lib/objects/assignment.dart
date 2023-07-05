part of studious.objects;

enum AssignmentStatus {
  unread('Unread'),
  inProgress('In Progress'),
  attempted('Attempted'),
  submitted("Submitted"),
  overdue('Overdue');

  final String label;
  const AssignmentStatus(this.label);
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
  List<MaterialItem> submittedFiles;

  Assignment({
    required this.assignmentName,
    required this.description,
    required this.materials,
    required this.className,
    required this.reviewConfigs,
    required this.allowedFileTypes,
    required this.created,
    required this.deadline,
    required this.submittedFiles,
    required this.feedbackItem,
    required this.assignmentStatus,
  });
}
