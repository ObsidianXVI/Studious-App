part of studious.objects;

class FeedbackItem extends StudiousObject {
  List<CommentItem> comments;

  FeedbackItem({
    required this.comments,
  });

  FeedbackItem.fromJson(Map<String, Object?> json)
      : comments = [
          for (final cmItem
              in (json['comments'] as List).cast<Map<String, Object?>>())
            CommentItem.fromJson(cmItem),
        ];

  @override
  Map<String, Object?> toJson() => {
        'comments': [for (final cmt in comments) cmt.toJson()]
      };
}
