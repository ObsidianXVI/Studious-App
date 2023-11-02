part of studious.objects;

enum CommentStatus {
  defaultStatus,
  flagged,
  resolved;

  static CommentStatus fromString(String name) {
    switch (name) {
      case "flagged":
        return CommentStatus.flagged;
      case "resolved":
        return CommentStatus.resolved;
      case "defaultStatus":
        return CommentStatus.defaultStatus;
    }
    throw "Invalid comment status $name";
  }
}

class CommentItem extends StudiousObject {
  String user;
  String content;
  CommentStatus commentStatus;
  int upvotes;

  CommentItem({
    required this.user,
    required this.content,
    required this.upvotes,
    this.commentStatus = CommentStatus.defaultStatus,
  });

  CommentItem.fromJson(Map<String, Object?> json)
      : user = json['user'] as String,
        content = json['content'] as String,
        commentStatus =
            CommentStatus.fromString(json['commentStatus'] as String),
        upvotes = json['upvotes'] as int;

  @override
  Map<String, Object?> toJson() => {
        'user': user,
        'content': content,
        'commentStatus': commentStatus.name,
        'upvotes': upvotes,
      };
}
