part of studious.ds;

class ClassCard extends StatefulWidget {
  final DocumentSnapshot<Class> studentClassData;

  const ClassCard({
    required this.studentClassData,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => ClassCardState();
}

class ClassCardState extends State<ClassCard> {
  double elevation = 0;
  late final Class cl = widget.studentClassData.data()!;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        elevation = 10;
        setState(() {});
      },
      onExit: (event) {
        elevation = 0;
        setState(() {});
      },
      child: Material(
        elevation: elevation,
        borderRadius: BorderRadius.circular(5),
        child: GestureDetector(
          onTap: () async {
            final List<DocumentSnapshot<Assignment>> assignments =
                await Database.getAssignments(
              cl.assignments,
            );

            if (context.mounted) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return AssignmentsView(
                      assignments: assignments,
                    );
                  },
                ),
              );
            }
          },
          child: Container(
            width: 900,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: cl.color.withOpacity(0.1),
              border: Border.all(
                color: StudiousTheme.purple,
                width: 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Text(
                      cl.className,
                      style: const TextStyle(
                        color: StudiousTheme.purple,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Text(
                      cl.teacherName.toUpperCase(),
                      style: const TextStyle(
                        color: StudiousTheme.purple,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Text(
                      "${cl.memberCount.toString()} members",
                      style: const TextStyle(
                        color: StudiousTheme.purple,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
