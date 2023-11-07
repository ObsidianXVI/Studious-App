part of studious.views;

class SubmissionsView extends StatelessWidget {
  final List<DocumentSnapshot<Submission>> submissions;

  const SubmissionsView({
    required this.submissions,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CardShelf(
        shelfName: 'Submissions',
        data: submissions,
        createWidget: (DocumentSnapshot<Submission> sub) =>
            SubmissionCard(subData: sub),
        doesMatch: (value, item) =>
            item.data()!.submittedText.containsSubset(value),
      ),
    );
  }
}
