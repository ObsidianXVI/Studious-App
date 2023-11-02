part of studious.views;

class AssignmentsView extends StatefulWidget {
  final List<DocumentSnapshot<Assignment>> assignments;

  const AssignmentsView({
    required this.assignments,
    super.key,
  });

  @override
  State<AssignmentsView> createState() => AssignmentsViewState();
}

class AssignmentsViewState extends State<AssignmentsView> {
  final List<DocumentSnapshot<Assignment>> filteredAssignments = [];

  @override
  void initState() {
    filteredAssignments.addAll(widget.assignments);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> assignmentCards = [];
    for (DocumentSnapshot<Assignment> assignment in filteredAssignments) {
      assignmentCards.addAll([
        AssignmentCard(assignmentData: assignment),
        const SizedBox(height: 10),
      ]);
    }

    return Material(
      child: CardShelf(
        shelfName: 'Assignments',
        children: assignmentCards,
        onChangedCallback: (String value) {
          setState(() {
            ///filteredAssignments
            /* ..clear()
              ..addAll(widget.assignments.where(
                  (DocumentSnapshot<Assignment> a) => a
                      .data()!
                      .assignmentName
                      .toLowerCase()
                      .contains(value.toLowerCase()))) */
            ;
          });
        },
      ),
    );
  }
}
