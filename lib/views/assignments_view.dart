part of studious.views;

class AssignmentsView extends StatelessWidget {
  final List<DocumentSnapshot<Assignment>> assignments;

  const AssignmentsView({
    required this.assignments,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CardShelf(
      shelfName: 'Assignments',
      data: assignments,
      createWidget: (DocumentSnapshot<Assignment> assignment) =>
          AssignmentCard(assignmentData: assignment, studentId: studentId!),
      doesMatch: (value, assignment) =>
          assignment.data()!.assignmentName.containsSubset(value),
      sortFn: (List<DocumentSnapshot<Assignment>> assignments) {
        return assignments;
        //..sort((a, b) => a.data()!.deadline.compareTo(b.data()!.deadline));
      },
    );
  }
}
