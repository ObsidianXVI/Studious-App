part of studious.ds;

class CommentCard extends StatefulWidget {
  final CommentItem commentItem;
  final Future<void> Function(int newCount) onUpvote;
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
  int upvoteCount = 0;

  @override
  void initState() {
    hasBeenFlagged = widget.commentItem.flagged;
    upvoteCount = widget.commentItem.upvoteCount;
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
                    const SizedBox(width: 8),
                    Text(upvoteCount.toString()),
                    TextButton(
                      onPressed: () async {
                        setState(() {
                          upvoteCount = hasBeenUpvoted
                              ? upvoteCount - 1
                              : upvoteCount + 1;
                          hasBeenUpvoted = !hasBeenUpvoted;
                        });

                        // let DB know if needs to increment or decrement
                        await widget.onUpvote(upvoteCount);
                      },
                      child: Icon(
                        Icons.arrow_upward,
                        color: hasBeenUpvoted ? Colors.green : Colors.grey,
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