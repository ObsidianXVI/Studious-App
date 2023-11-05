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
    return Material(
      child: CardShelf(
        shelfName: 'Assignments',
        children: createAssignmentCards(filteredAssignments),
        onChangedCallback: (String value) {
          setState(() {
            filteredAssignments
              ..clear()
              ..addAll(widget.assignments
                  .where((DocumentSnapshot<Assignment> c) => c
                      .data()!
                      .assignmentName
                      .toLowerCase()
                      .contains(value.toLowerCase()))
                  .toList());
          });
        },
      ),
    );
  }

  List<Widget> createAssignmentCards(
      List<DocumentSnapshot<Assignment>> assignments) {
    final List<Widget> assignmentCards = [];
    for (DocumentSnapshot<Assignment> assignment in filteredAssignments) {
      assignmentCards.addAll([
        AssignmentCard(assignmentData: assignment, studentId: studentId!),
        const SizedBox(height: 10),
      ]);
    }
    return assignmentCards;
  }
}
