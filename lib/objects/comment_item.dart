part of studious.objects;

class CommentItem extends StudiousObject {
  String user;
  String content;

  CommentItem({
    required this.user,
    required this.content,
  });

  CommentItem.fromJson(Map<String, Object?> json)
      : user = json['user'] as String,
        content = json['content'] as String;

  @override
  Map<String, Object?> toJson() => {
        'user': user,
        'content': content,
      };
}
