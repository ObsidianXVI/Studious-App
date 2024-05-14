part of studious.ds;

class CommentCard extends StatefulWidget {
  final CommentItem commentItem;
  final Future<void> Function() onUpvote;
  final Future<void> Function() onFlagged;

  const CommentCard({
    required this.commentItem,
    required this.onFlagged,
    required this.onUpvote,
    super.key,
  });

  @override
  createState() => CommentCardState();
}

class CommentCardState extends State<CommentCard> {
  bool hasBeenUpvoted = false;
  bool hasBeenFlagged = false;

  @override
  void initState() {
    hasBeenFlagged = widget.commentItem.flagged;
    // hasBeenUpvoted = widget.commentItem.upvotes;
    super.initState();
  }

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
              Positioned(
                bottom: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: hasBeenFlagged
                          ? null
                          : () async {
                              setState(() {
                                hasBeenFlagged = true;
                              });
                              await widget.onFlagged();
                            },
                      child: Icon(
                        Icons.flag,
                        color: hasBeenFlagged ? Colors.deepOrange : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
/**
 * Text(
                  widget.commentItem.content,
                  style: const TextStyle(
                    fontSize: 18,
                    color: StudiousTheme.purple,
                  ),
                ),
 */