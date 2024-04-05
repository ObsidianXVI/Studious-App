part of studious.views;

class ClassesView extends StatefulWidget {
  final List<DocumentSnapshot<Class>> classes;

  const ClassesView({
    required this.classes,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => ClassesViewState();
}

class ClassesViewState extends State<ClassesView> {
  bool hasLoadedNotifs = false;
  late BuildContext currentCtx;
  Future<void> assignmentsDue() async {
    if (hasLoadedNotifs) return;

    final assignments = await Database.getAssignmentsDueSoon();
    hasLoadedNotifs = true;
    if (mounted) {
      ScaffoldMessenger.of(currentCtx).showSnackBar(
        SnackBar(
          content: Text("${assignments.length} assignments due this week"),
          duration: const Duration(seconds: 4),
          action: SnackBarAction(
              label: 'See Names',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Column(
                      children: [
                        for (final a in assignments)
                          Text(a.data()!.assignmentName)
                      ],
                    ),
                    duration: const Duration(seconds: 4),
                  ),
                );
              }),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    currentCtx = context;
    return FutureBuilder(
        future: assignmentsDue(),
        builder: (ctx, snapshot) {
          return CardShelf(
            shelfName: 'Classes',
            data: widget.classes,
            createWidget: (DocumentSnapshot<Class> studentClass) =>
                ClassCard(studentClassData: studentClass),
            doesMatch: (value, studentClass) => studentClass
                .data()!
                .className
                .toLowerCase()
                .contains(value.toLowerCase()),
          );
        });
  }
}
