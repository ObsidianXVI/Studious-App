part of studious.objects;

class Submission extends StudiousObject {
  String assignmentId;
  List submittedFiles;
  String submittedText;

  Submission({
    required this.assignmentId,
    required this.submittedFiles,
    required this.submittedText,
  });

  Submission.fromJson(Map<String, Object?> json)
      : assignmentId = json['assignmentId']! as String,
        submittedFiles = [],
        submittedText = json['submittedText'] as String;

  @override
  Map<String, Object?> toJson() => {
        'assignmentId': assignmentId,
        'submittedFiles': [],
        'submittedText': submittedText,
      };
}
