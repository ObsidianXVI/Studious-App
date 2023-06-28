part of studious.views;

class ClassesView extends StatelessWidget {
  final List<Class> classes;

  const ClassesView({
    required this.classes,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> classCards = [];
    for (Class studentClass in classes) {
      classCards.addAll([
        ClassCard(studentClassData: studentClass),
        const SizedBox(height: 10),
      ]);
    }

    return CardShelf(shelfName: 'Classes', children: classCards);
  }
}
