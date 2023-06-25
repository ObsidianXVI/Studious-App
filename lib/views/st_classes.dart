part of studious.views;

class Student_Classes_View extends StatelessWidget {
  final List<StudentClass> classes;

  const Student_Classes_View({
    required this.classes,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> classCards = [];
    for (StudentClass studentClass in classes) {
      classCards.addAll([
        ClassCard(studentClassData: studentClass),
        const SizedBox(height: 10),
      ]);
    }

    return ViewScaffold(
      viewTitle: 'Classes',
      child: Column(
        children: [
          SearchBox(),
          const SizedBox(height: 20),
          SingleChildScrollView(
            child: Column(
              children: classCards,
            ),
          ),
        ],
      ),
    );
  }
}
