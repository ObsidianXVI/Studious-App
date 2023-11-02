part of studious.views;

class Student_Assignment_Viewer extends StatefulWidget {
  final DocumentSnapshot<Assignment> assignment;

  const Student_Assignment_Viewer({
    required this.assignment,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => Student_Assignment_ViewerState();
}

class Student_Assignment_ViewerState extends State<Student_Assignment_Viewer>
    with OverlayTools {
  final TextEditingController textController = TextEditingController();
  late final Assignment assignment = widget.assignment.data()!;

  @override
  Widget build(BuildContext context) {
    return ViewScaffold(
      viewTitle: assignment.assignmentName,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              assignment.description,
              style: const TextStyle(
                color: StudiousTheme.purple,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 10,
              runSpacing: 5,
              children:
                  List<Widget>.generate(assignment.materials.length, (index) {
                return Chip(
                  avatar: widget.assignment
                      .data()!
                      .materials[index]
                      .materialType
                      .icon,
                  side: const BorderSide(
                    width: 1,
                    color: StudiousTheme.darkPurple,
                  ),
                  backgroundColor: StudiousTheme.darkPurple.withOpacity(0.3),
                  label: Text(
                    assignment.materials[index].fileName,
                    style: const TextStyle(
                      fontSize: 10,
                      color: StudiousTheme.darkPurple,
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: 'Due: ',
                    style: TextStyle(
                      color: StudiousTheme.purple,
                    ),
                  ),
                  TextSpan(
                    text: assignment.deadline.summary,
                    style: const TextStyle(
                      color: StudiousTheme.purple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: 'Created: ',
                    style: TextStyle(
                      color: StudiousTheme.purple,
                    ),
                  ),
                  TextSpan(
                    text: assignment.created.summary,
                    style: const TextStyle(
                      color: StudiousTheme.purple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Submission',
              style: TextStyle(
                color: StudiousTheme.purple,
                fontWeight: FontWeight.w600,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 20),
            assignment.allowedFileTypes.isNotEmpty
                ? IconTextButton(
                    label: 'Upload Files',
                    iconData: Icons.add,
                    action: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: [
                          for (final type in assignment.allowedFileTypes)
                            type.ext
                        ],
                      );
                      if (result != null) {
                        Database.insert(
                          Database.submissionsColl,
                          Submission(
                            assignmentId: widget.assignment.id,
                            submittedFiles: [],
                            submittedText: '',
                          ),
                        );
                      }
                    },
                    enabled: !(widget.assignment.data()!.assignmentStatus ==
                        AssignmentStatus.submitted),
                  )
                : TextField(
                    controller: textController,
                  ),
            const SizedBox(height: 10),
            assignment.assignmentStatus == AssignmentStatus.submitted
                ? IconTextButton(
                    label: 'Undo Hand In',
                    iconData: Icons.close,
                    action: () {
                      assignment.assignmentStatus = AssignmentStatus.attempted;
                      assignment.comments.clear();
                      setState(() {});
                    },
                    enabled: true,
                  )
                : IconTextButton(
                    label: 'Hand In',
                    iconData: Icons.check,
                    action: () async {
                      await Database.insert(
                        Database.submissionsColl,
                        Submission(
                          assignmentId: widget.assignment.id,
                          submittedFiles: [],
                          submittedText: textController.text,
                        ),
                      );
                      assignment.assignmentStatus = AssignmentStatus.submitted;
                      // dev only
                      assignment.comments.add(
                        CommentItem(
                          user: 'Small Sean',
                          content: 'Very insightful insights!',
                          upvotes: 2,
                        ),
                      );
                      setState(() {});
                    },
                    enabled: assignment.assignmentStatus !=
                        AssignmentStatus.submitted,
                  ),
            const SizedBox(height: 10),
            IconTextButton(
              label: 'View Feedback',
              iconData: Icons.comment,
              action: () {
                addOverlay(
                  overlay: OverlayEntry(builder: (BuildContext context) {
                    return StudentFeedbackOverlay(
                      comments: assignment.comments,
                      dismiss: () => removeOverlay(),
                    );
                  }),
                );
              },
              enabled: assignment.comments.isNotEmpty,
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
