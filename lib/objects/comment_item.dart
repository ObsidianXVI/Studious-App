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
  final String user;
  final String content;
  final Widget? reference;
  CommentStatus commentStatus;
  int upvotes;

  CommentItem({
    required this.user,
    required this.content,
    required this.upvotes,
    this.commentStatus = CommentStatus.defaultStatus,
    this.reference,
  });

  CommentItem.fromJson(Map<String, Object?> json)
      : user = json['user'] as String,
        content = json['content'] as String,
        reference = null,
        commentStatus =
            CommentStatus.fromString(json['commentStatus'] as String),
        upvotes = json['upvotes'] as int;

  @override
  Map<String, Object?> toJson() => {
        'user': user,
        'content': content,
        'reference': null,
        'commentStatus': commentStatus.name,
        'upvotes': upvotes,
      };
}
