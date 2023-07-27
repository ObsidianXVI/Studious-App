part of studious.objects;

enum CommentStatus {
  defaultStatus,
  flagged,
  resolved;
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
}
