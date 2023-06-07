part of studious.views;

class Student_Classes_View extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewScaffold(
      viewTitle: 'Classes',
      child: Column(
        children: [
          SearchBox(),
          const SizedBox(height: 20),
          ListView(
            shrinkWrap: true,
            children: [
              ClassCard(
                studentClassData: StudentClass(
                  className: 'Class Name',
                  memberCount: 24,
                  teacherName: 'Mr Tarantino',
                  color: Colors.amber,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
