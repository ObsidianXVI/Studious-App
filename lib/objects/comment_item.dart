part of studious.objects;

class CommentItem extends StudiousObject {
  String user;
  String content;
  bool flagged;

  CommentItem({
    required this.user,
    required this.content,
    required this.flagged,
  });

  CommentItem.fromJson(Map<String, Object?> json)
      : user = json['user'] as String,
        content = json['content'] as String,
        flagged = json['flagged'] as bool;

  @override
  Map<String, Object?> toJson() => {
        'user': user,
        'content': content,
        'flagged': flagged,
      };
}
