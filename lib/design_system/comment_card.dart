part of studious.ds;

class StudentCommentCard extends StatefulWidget {
  final CommentItem commentItem;
  final Function(StudentCommentCard) onSelectCallback;
  final Function() onUnselectCallback;

  const StudentCommentCard({
    required this.commentItem,
    required this.onSelectCallback,
    required this.onUnselectCallback,
  });

  @override
  createState() => StudentCommentCardState();
}

class StudentCommentCardState extends State<StudentCommentCard> {
  bool hasBeenUpvoted = false;
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          if (isSelected) {
            isSelected = false;
            setState(() {});
            widget.onUnselectCallback();
          } else {
            isSelected = true;
            setState(() {});
            widget.onSelectCallback(widget);
          }
        },
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        splashRadius: 20,
                        onPressed: () {
                          if (hasBeenUpvoted) {
                            widget.commentItem.upvotes -= 1;
                            hasBeenUpvoted = false;
                          } else {
                            widget.commentItem.upvotes += 1;
                            hasBeenUpvoted = true;
                          }
                          setState(() {});
                        },
                        icon: Icon(
                          Icons.north,
                          size: 18,
                          color: hasBeenUpvoted ? Colors.green : Colors.grey,
                        ),
                      ),
                      Text(
                        widget.commentItem.upvotes.toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          color: StudiousTheme.purple,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        splashRadius: 20,
                        onPressed: () {
                          if (widget.commentItem.commentStatus ==
                              CommentStatus.defaultStatus) {
                            widget.commentItem.commentStatus =
                                CommentStatus.flagged;
                          } else {
                            widget.commentItem.commentStatus =
                                CommentStatus.defaultStatus;
                          }
                          setState(() {});
                        },
                        icon: Icon(
                          Icons.flag,
                          size: 18,
                          color: widget.commentItem.commentStatus ==
                                  CommentStatus.flagged
                              ? Colors.red
                              : Colors.grey,
                        ),
                      ),
                      Text(
                        widget.commentItem.commentStatus ==
                                CommentStatus.flagged
                            ? 'Flagged'
                            : 'Flag',
                        style: const TextStyle(
                          fontSize: 12,
                          color: StudiousTheme.purple,
                        ),
                      ),
                      const SizedBox(width: 20),
                      IconButton(
                        splashRadius: 20,
                        onPressed: () {
                          if (widget.commentItem.commentStatus ==
                              CommentStatus.resolved) {
                            widget.commentItem.commentStatus =
                                CommentStatus.defaultStatus;
                          } else {
                            widget.commentItem.commentStatus =
                                CommentStatus.resolved;
                          }
                          setState(() {});
                        },
                        icon: Icon(
                          Icons.check,
                          size: 18,
                          color: widget.commentItem.commentStatus ==
                                  CommentStatus.resolved
                              ? Colors.green
                              : Colors.grey,
                        ),
                      ),
                      Text(
                        widget.commentItem.commentStatus ==
                                CommentStatus.resolved
                            ? 'Resolved'
                            : 'Resolve',
                        style: const TextStyle(
                          fontSize: 12,
                          color: StudiousTheme.purple,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
