part of studious.views;

class Student_Assignments_View extends StatelessWidget {
  final List<Assignment> assignments;

  const Student_Assignments_View({
    required this.assignments,
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> assignmentCards = [];
    for (Assignment assignment in assignments) {
      assignmentCards.addAll([
        AssignmentCard(assignmentData: assignment),
        const SizedBox(height: 10),
      ]);
    }
    return ViewScaffold(
      viewTitle: 'Assignments',
      child: Column(
        children: [
          SearchBox(),
          const SizedBox(height: 20),
          SingleChildScrollView(
            child: Column(
              children: assignmentCards,
            ),
          ),
        ],
      ),
    );
  }
}
