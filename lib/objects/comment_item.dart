part of studious.objects;

class CommentItem extends StudiousObject {
  final String user;
  final String content;
  int upvotes;

  CommentItem({
    required this.user,
    required this.content,
    required this.upvotes,
  });
}
