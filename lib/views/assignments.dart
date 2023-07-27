part of studious.views;

class AssignmentsView extends StatefulWidget {
  final List<Assignment> assignments;

  const AssignmentsView({
    required this.assignments,
  });

  @override
  State<AssignmentsView> createState() => AssignmentsViewState();
}

class AssignmentsViewState extends State<AssignmentsView> {
  final List<Assignment> filteredAssignments = [];

  @override
  void initState() {
    filteredAssignments.addAll(widget.assignments);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> assignmentCards = [];
    for (Assignment assignment in filteredAssignments) {
      assignmentCards.addAll([
        AssignmentCard(assignmentData: assignment),
        const SizedBox(height: 10),
      ]);
    }
    return CardShelf(
      shelfName: 'Assignments',
      children: assignmentCards,
      onChangedCallback: (String value) {
        setState(() {
          filteredAssignments
            ..clear()
            ..addAll(widget.assignments.where((Assignment a) =>
                a.assignmentName.toLowerCase().contains(value.toLowerCase())));
        });
      },
    );
  }
}
