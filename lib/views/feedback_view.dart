part of studious.views;

class FeedbackView extends StatefulWidget {
  final DocumentSnapshot<Submission> subRef;

  const FeedbackView({
    required this.subRef,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => FeedbackViewState();
}

class FeedbackViewState extends State<FeedbackView> {
  final TextEditingController textController = TextEditingController();
  late final Submission submission = widget.subRef.data()!;

  @override
  Widget build(BuildContext context) {
    return ViewScaffold(
      viewTitle: 'Feedback View',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(submission.submittedText),
          const SizedBox(height: 10),
          TextField(controller: textController),
          const SizedBox(height: 10),
          RectTextButton(
            label: 'Add Comment',
            action: () async {
              final CommentItem cmItem = CommentItem(
                user: (await Database.getStudent(studentId!)).data()!.username,
                content: textController.text,
              );
              await Database.update(
                Database.submissionsColl,
                widget.subRef.id,
                {
                  'comments': [
                    cmItem.toJson(),
                    for (final cm in submission.comments) cm.toJson()
                  ],
                },
              );
              final String username =
                  (await Database.getStudent(studentId!)).data()!.username;
              setState(() {
                submission.comments.insert(
                  0,
                  CommentItem(
                    user: username,
                    content: textController.text,
                  ),
                );
              });
              textController.clear();
            },
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (final cmItem in submission.comments) ...[
                    CommentCard(
                      commentItem: cmItem,
                    ),
                    const SizedBox(height: 10),
                  ]
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
