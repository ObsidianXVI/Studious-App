part of studious.ds;

class StudentCommentCard extends StatefulWidget {
  final CommentItem commentItem;

  const StudentCommentCard({
    required this.commentItem,
  });

  @override
  createState() => StudentCommentCardState();
}

class StudentCommentCardState extends State<StudentCommentCard> {
  bool hasBeenUpvoted = false;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        height: 120,
        decoration: BoxDecoration(
          color: StudiousTheme.purple.withOpacity(0.2),
          border: Border.all(
            width: 1,
            color: StudiousTheme.purple,
          ),
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
            ],
          ),
        ),
      ),
    );
  }
}
