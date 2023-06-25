part of studious.objects;

class FeedbackItem extends StudiousObject {
  List<CommentItem> comments;

  FeedbackItem({
    required this.comments,
  });
}
