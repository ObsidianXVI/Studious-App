part of studious.ds;

class AssignmentCard extends StatefulWidget {
  final Assignment assignmentData;

  const AssignmentCard({
    required this.assignmentData,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => AssignmentCardState();
}

class AssignmentCardState extends State<AssignmentCard> {
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
                  if (SessionConfigs.studentMode) {
                    return Student_Assignment_Viewer(
                      assignment: widget.assignmentData,
                    );
                  } else {
                    return Teacher_Assignment_Viewer(
                      assignment: widget.assignmentData,
                      className: widget.assignmentData.className,
                    );
                  }
                },
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
                      widget.assignmentData.assignmentName,
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
                      widget.assignmentData.description,
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
                      widget.assignmentData.deadline.summary,
                      style: TextStyle(
                        color: semanticColorBasedOnDeadline(
                          widget.assignmentData.deadline,
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
                          widget.assignmentData.materials.length, (index) {
                        return Chip(
                          avatar: widget.assignmentData.materials[index]
                              .materialType.icon,
                          side: const BorderSide(
                            width: 1,
                            color: StudiousTheme.darkPurple,
                          ),
                          backgroundColor:
                              StudiousTheme.darkPurple.withOpacity(0.3),
                          label: Text(
                            widget.assignmentData.materials[index].fileName,
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
                      widget.assignmentData.assignmentStatus.label,
                      style: TextStyle(
                        color: semanticColorBasedOnDeadline(
                          widget.assignmentData.deadline,
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
  }
}
