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
  @override
  Widget build(BuildContext context) {
    return ViewScaffold(
      viewTitle: widget.assignment.data()!.assignmentName,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.assignment.data()!.description,
              style: const TextStyle(
                color: StudiousTheme.purple,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 10,
              runSpacing: 5,
              children: List<Widget>.generate(
                  widget.assignment.data()!.materials.length, (index) {
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
                    widget.assignment.data()!.materials[index].fileName,
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
                    text: widget.assignment.data()!.deadline.summary,
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
                    text: widget.assignment.data()!.created.summary,
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
            widget.assignment.data()!.allowedFileTypes.isNotEmpty
                ? IconTextButton(
                    label: 'Upload Files',
                    iconData: Icons.add,
                    action: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: [
                          for (final type
                              in widget.assignment.data()!.allowedFileTypes)
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
                : const TextField(),
            const SizedBox(height: 10),
            widget.assignment.data()!.assignmentStatus ==
                    AssignmentStatus.submitted
                ? IconTextButton(
                    label: 'Undo Hand In',
                    iconData: Icons.close,
                    action: () {
                      widget.assignment.data()!.assignmentStatus =
                          AssignmentStatus.attempted;
                      widget.assignment.data()!.feedbackItem = null;
                      setState(() {});
                    },
                    enabled: true,
                  )
                : IconTextButton(
                    label: 'Hand In',
                    iconData: Icons.check,
                    action: () {
                      widget.assignment.data()!.assignmentStatus =
                          AssignmentStatus.submitted;
                      // dev only
                      widget.assignment.data()!.feedbackItem =
                          FeedbackItem(comments: [
                        CommentItem(
                          user: 'Small Sean',
                          content: 'Very insightful insights!',
                          upvotes: 2,
                        ),
                      ]);
                      setState(() {});
                    },
                    enabled: true,
                  ),
            const SizedBox(height: 10),
            IconTextButton(
              label: 'View Feedback',
              iconData: Icons.comment,
              action: () {
                addOverlay(
                  overlay: OverlayEntry(builder: (BuildContext context) {
                    return StudentFeedbackOverlay(
                      feedbackItem: widget.assignment.data()!.feedbackItem!,
                      dismiss: () => removeOverlay(),
                    );
                  }),
                );
              },
              enabled: widget.assignment.data()!.feedbackItem != null,
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
