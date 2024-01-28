part of studious.objects;

class Submission extends StudiousObject {
  String assignmentId;
  List submittedFiles;
  String submittedText;
  String userId;
  List<CommentItem> comments;

  Submission({
    required this.userId,
    required this.assignmentId,
    required this.submittedFiles,
    required this.submittedText,
    required this.comments,
  });

  Submission.fromJson(Map<String, Object?> json)
      : userId = json['userId']! as String,
        assignmentId = json['assignmentId']! as String,
        submittedFiles = [],
        submittedText = json['submittedText'] as String,
        comments = [
          for (final cm
              in (json['comments'] as List).cast<Map<String, Object?>>())
            CommentItem.fromJson(cm)
        ];

  @override
  Map<String, Object?> toJson() => {
        'userId': userId,
        'assignmentId': assignmentId,
        'submittedFiles': [],
        'submittedText': submittedText,
        'comments': [for (var c in comments) c.toJson()],
      };
}
