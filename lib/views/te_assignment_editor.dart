part of studious.views;

class Teacher_Assignment_Editor_View extends StatefulWidget {
  final Assignment assignment;

  const Teacher_Assignment_Editor_View({
    required this.assignment,
  });

  @override
  createState() => Teacher_Assignment_Editor_ViewState();
}

class Teacher_Assignment_Editor_ViewState
    extends State<Teacher_Assignment_Editor_View> {
  late final TextEditingController descTextController = TextEditingController(
    text: widget.assignment.description,
  );
  DateTime? deadline;

  @override
  void initState() {
    deadline = widget.assignment.deadline;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewScaffold(
      viewTitle: widget.assignment.assignmentName,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EditableText(
              controller: descTextController,
              focusNode: FocusNode(),
              cursorColor: StudiousTheme.darkPurple,
              backgroundCursorColor: Colors.white,
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
                  widget.assignment.materials.length, (index) {
                return Chip(
                  avatar: widget.assignment.materials[index].materialType.icon,
                  side: const BorderSide(
                    width: 1,
                    color: StudiousTheme.darkPurple,
                  ),
                  backgroundColor: StudiousTheme.darkPurple.withOpacity(0.3),
                  label: Text(
                    widget.assignment.materials[index].fileName,
                    style: const TextStyle(
                      fontSize: 10,
                      color: StudiousTheme.darkPurple,
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text(
                  'Due: ',
                  style: TextStyle(
                    color: StudiousTheme.purple,
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    final DateTime now = DateTime.now();
                    final DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: now,
                      firstDate: now,
                      lastDate: now.add(const Duration(days: 365)),
                    );
                    if (date != null) deadline = date;
                    setState(() {});
                    snackbarKey.currentState?.showSnackBar(
                      SnackBar(
                        content: const Text('Submission deadline changed!'),
                        backgroundColor: Colors.green.shade800,
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: StudiousTheme.lightPurple.withOpacity(0.2),
                  ),
                  child: Text(
                    deadline!.summary,
                    style: const TextStyle(
                      color: StudiousTheme.purple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text(
                  'Created: ',
                  style: TextStyle(
                    color: StudiousTheme.purple,
                  ),
                ),
                Text(
                  widget.assignment.created.summary,
                  style: const TextStyle(
                    color: StudiousTheme.purple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
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
            IconTextButton(
              label: 'Upload Files',
              iconData: Icons.add,
              action: () {},
              enabled: !(widget.assignment.assignmentStatus ==
                  AssignmentStatus.submitted),
            ),
            const SizedBox(height: 10),
            widget.assignment.assignmentStatus == AssignmentStatus.submitted
                ? IconTextButton(
                    label: 'Undo Hand In',
                    iconData: Icons.close,
                    action: () {
                      widget.assignment.assignmentStatus =
                          AssignmentStatus.attempted;
                      widget.assignment.feedbackItem = null;
                    },
                    enabled: true,
                  )
                : IconTextButton(
                    label: 'Hand In',
                    iconData: Icons.check,
                    action: () {
                      widget.assignment.assignmentStatus =
                          AssignmentStatus.submitted;
                      // dev only
                      widget.assignment.feedbackItem = FeedbackItem(comments: [
                        CommentItem(
                          user: 'Small Sean',
                          content: 'Very insightful insights!',
                          upvotes: 2,
                        ),
                      ]);
                    },
                    enabled: true,
                  ),
            const SizedBox(height: 10),
            IconTextButton(
              label: 'View Feedback',
              iconData: Icons.comment,
              action: () {},
              enabled: widget.assignment.feedbackItem != null,
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

 /**
  *  

  */
