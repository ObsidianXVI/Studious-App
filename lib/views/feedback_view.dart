part of studious.views;

class FeedbackView extends StatefulWidget {
  final DocumentSnapshot<Submission> subRef;
  final void Function(VoidCallback) refresh;

  const FeedbackView({
    required this.subRef,
    required this.refresh,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => FeedbackViewState();
}

class FeedbackViewState extends State<FeedbackView> {
  final TextEditingController textController = TextEditingController();
  late Submission submission = widget.subRef.data()!;

  @override
  Widget build(BuildContext context) {
    final List<Widget> comCards = [];
    final List<Widget> flaggedCards = [];
    for (int i = 0; i < submission.comments.length; i++) {
      (submission.comments[i].flagged ? flaggedCards : comCards).addAll([
        CommentCard(
          commentItem: submission.comments[i],
          onFlagged: () async {
            final oldList = ((await db
                        .collection('submissions')
                        .doc(widget.subRef.id)
                        .get())
                    .data()!['comments'] as List)
                .cast<Map<String, dynamic>>();
            final List<Map<String, dynamic>> newList = oldList;
            newList[i] = CommentItem(
              user: submission.comments[i].user,
              content: submission.comments[i].content,
              flagged: true,
            ).toJson();
            await db
                .collection('submissions')
                .doc(widget.subRef.id)
                .update({'comments': newList});
            submission =
                (await Database.submissionsColl.doc(widget.subRef.id).get())
                    .data()!;
            setState(() {});
          },
          onUpvote: () async {},
        ),
        const SizedBox(height: 20),
      ]);
    }
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
                flagged: false,
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

              setState(() {
                submission.comments.insert(0, cmItem);
              });
              textController.clear();
            },
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text('FLAGGED'),
                  const SizedBox(height: 10),
                  ...flaggedCards,
                  const SizedBox(height: 30),
                  ...comCards,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
