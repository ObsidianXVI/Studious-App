part of studious.ds;

class AssignmentCard extends StatefulWidget {
  final String studentId;
  final DocumentSnapshot<Assignment> assignmentData;

  const AssignmentCard({
    required this.studentId,
    required this.assignmentData,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => AssignmentCardState();
}

class AssignmentCardState extends State<AssignmentCard> {
  double elevation = 0;
  late DocumentSnapshot<Student> student;
  late Student studentData;
  late final Future dataFetchFuture;

  @override
  void initState() {
    super.initState();
    dataFetchFuture = () async {
      student = await Database.getStudent(widget.studentId);
      studentData = student.data()!;
    }();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: dataFetchFuture,
      builder: (_, snapshot) {
        return snapshot.connectionState == ConnectionState.waiting
            ? const CircularProgressIndicator()
            : MouseRegion(
                cursor: SystemMouseCursors.click,
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
                          builder: (_) => AssignmentViewer(
                            assignment: widget.assignmentData,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: 900,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: StudiousTheme.purple.withOpacity(0.2),
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
                                widget.assignmentData.data()!.assignmentName,
                                style: const TextStyle(
                                  color: StudiousTheme.purple,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 25,
                              left: 0,
                              child: Text(
                                widget.assignmentData.data()!.description,
                                maxLines: 1,
                                softWrap: false,
                                style: const TextStyle(
                                  color: StudiousTheme.purple,
                                  fontSize: 14,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Text(
                                widget.assignmentData.data()!.deadline.summary,
                                style: TextStyle(
                                  color: semanticColorBasedOnDeadline(
                                    widget.assignmentData.data()!.deadline,
                                  ),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: List<Widget>.generate(
                                    widget.assignmentData
                                        .data()!
                                        .materials
                                        .length, (index) {
                                  return Chip(
                                    avatar: widget.assignmentData
                                        .data()!
                                        .materials[index]
                                        .materialType
                                        .icon,
                                    side: const BorderSide(
                                      width: 1,
                                      color: StudiousTheme.darkPurple,
                                    ),
                                    backgroundColor: StudiousTheme.darkPurple
                                        .withOpacity(0.3),
                                    label: Text(
                                      widget.assignmentData
                                          .data()!
                                          .materials[index]
                                          .fileName,
                                      style: const TextStyle(
                                        fontSize: 10,
                                        color: StudiousTheme.darkPurple,
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Text(
                                studentData
                                    .statusForAssignment(widget.assignmentData)
                                    .label,
                                style: TextStyle(
                                  color: semanticColorBasedOnDeadline(
                                    widget.assignmentData.data()!.deadline,
                                  ),
                                  fontSize: 12,
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
      },
    );
  }
}
