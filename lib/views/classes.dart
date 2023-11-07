part of studious.views;

class ClassesView extends StatelessWidget {
  final List<DocumentSnapshot<Class>> classes;

  const ClassesView({
    required this.classes,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CardShelf(
      shelfName: 'Classes',
      data: classes,
      createWidget: (DocumentSnapshot<Class> studentClass) =>
          ClassCard(studentClassData: studentClass),
      doesMatch: (value, studentClass) => studentClass
          .data()!
          .className
          .toLowerCase()
          .contains(value.toLowerCase()),
    );
  }
}
