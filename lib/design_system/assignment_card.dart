part of studious.ds;

class AssignmentCard extends StatefulWidget {
  final DocumentSnapshot<Assignment> assignmentData;

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
                      assignment: widget.assignmentData.data()!,
                      className: 'n',
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
                          widget.assignmentData.data()!.materials.length,
                          (index) {
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
                          backgroundColor:
                              StudiousTheme.darkPurple.withOpacity(0.3),
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
                    child: SessionConfigs.studentMode
                        ? Text(
                            widget.assignmentData
                                .data()!
                                .assignmentStatus
                                .label,
                            style: TextStyle(
                              color: semanticColorBasedOnDeadline(
                                widget.assignmentData.data()!.deadline,
                              ),
                              fontSize: 12,
                            ),
                          )
                        : TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return Teacher_Assignment_Editor_View(
                                    assignment: widget.assignmentData,
                                  );
                                }),
                              );
                            },
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.edit,
                                  size: 14,
                                  color: StudiousTheme.darkPurple,
                                ),
                                SizedBox(width: 3),
                                Text(
                                  'Edit',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: StudiousTheme.darkPurple,
                                  ),
                                ),
                              ],
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
