part of studious.objects;

class CommentItem extends StudiousObject {
  int upvoteCount;
  String user;
  String content;
  bool flagged;

  CommentItem({
    required this.user,
    required this.content,
    required this.flagged,
    required this.upvoteCount,
  });

  CommentItem.fromJson(Map<String, Object?> json)
      : user = json['user'] as String,
        content = json['content'] as String,
        flagged = json['flagged'] as bool,
        upvoteCount = json['upvoteCount'] as int;

  @override
  Map<String, Object?> toJson() => {
        'user': user,
        'content': content,
        'flagged': flagged,
        'upvoteCount': upvoteCount
      };
}
