part of studious.views;

class ClassesView extends StatefulWidget {
  final List<DocumentSnapshot<Class>> classes;

  const ClassesView({
    required this.classes,
    super.key,
  });

  @override
  State<ClassesView> createState() => ClassesViewState();
}

class ClassesViewState extends State<ClassesView> {
  final List<DocumentSnapshot<Class>> filteredClasses = [];

  @override
  void initState() {
    filteredClasses.addAll(widget.classes);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> classCards = [];
    for (DocumentSnapshot<Class> studentClass in filteredClasses) {
      classCards.addAll([
        ClassCard(studentClassData: studentClass),
        const SizedBox(height: 10),
      ]);
    }

    return CardShelf(
      shelfName: 'Classes',
      children: classCards,
      onChangedCallback: (String value) {
        setState(() {
          filteredClasses
            ..clear()
            ..addAll(widget.classes.where((DocumentSnapshot<Class> c) => c
                .data()!
                .className
                .toLowerCase()
                .contains(value.toLowerCase())));
        });
      },
    );
  }
}
