part of studious.objects;

class Assignment extends StudiousObject {
  final String assignmentName;
  final String description;
  final List<MaterialItem> materials;
  final List<MaterialItemType> allowedFileTypes;
  final ReviewConfigs reviewConfigs;
  final DateTime created;
  final DateTime deadline;
  FeedbackItem? feedbackItem;
  List<MaterialItem> submittedFiles;
  bool handedIn;

  Assignment({
    required this.assignmentName,
    required this.description,
    required this.materials,
    required this.reviewConfigs,
    required this.allowedFileTypes,
    required this.created,
    required this.deadline,
    required this.submittedFiles,
    required this.handedIn,
    required this.feedbackItem,
  });
}
