part of studious.ds;

class CommentCard extends StatefulWidget {
  final CommentItem commentItem;

  const CommentCard({
    required this.commentItem,
    super.key,
  });

  @override
  createState() => CommentCardState();
}

class CommentCardState extends State<CommentCard> {
  bool hasBeenUpvoted = false;
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        height: 120,
        decoration: BoxDecoration(
          color: StudiousTheme.purple.withOpacity(0.2),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                child: Text(
                  widget.commentItem.user.toUpperCase(),
                  style: const TextStyle(
                    color: StudiousTheme.lightPurple,
                    fontSize: 14,
                  ),
                ),
              ),
              Positioned(
                top: 30,
                left: 0,
                child: Text(
                  widget.commentItem.content,
                  style: const TextStyle(
                    fontSize: 18,
                    color: StudiousTheme.purple,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
