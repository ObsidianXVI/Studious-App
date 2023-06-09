part of studious.ds;

class ClassCard extends StatefulWidget {
  final Class studentClassData;

  const ClassCard({
    required this.studentClassData,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => ClassCardState();
}

class ClassCardState extends State<ClassCard> {
  double elevation = 0;

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
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return AssignmentsView(
                    assignments: widget.studentClassData.assignments,
                  );
                },
              ),
            );
          },
          child: Container(
            width: 900,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: widget.studentClassData.color.withOpacity(0.1),
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
                      widget.studentClassData.className,
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
                      widget.studentClassData.teacherName.toUpperCase(),
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
                      "${widget.studentClassData.memberCount.toString()} members",
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
