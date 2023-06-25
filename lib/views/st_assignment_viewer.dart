part of studious.views;

class Student_Assignment_Viewer extends StatefulWidget {
  final Assignment assignment;

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
      viewTitle: widget.assignment.assignmentName,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.assignment.description,
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
                    text: widget.assignment.deadline.summary,
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
                    text: widget.assignment.created.summary,
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
            IconTextButton(
              label: 'Upload Files',
              iconData: Icons.add,
              action: () {},
              enabled: !widget.assignment.handedIn,
            ),
            const SizedBox(height: 10),
            widget.assignment.handedIn
                ? IconTextButton(
                    label: 'Undo Hand In',
                    iconData: Icons.close,
                    action: () {
                      widget.assignment.handedIn = false;
                      widget.assignment.feedbackItem = null;
                      setState(() {});
                    },
                    enabled: true,
                  )
                : IconTextButton(
                    label: 'Hand In',
                    iconData: Icons.check,
                    action: () {
                      widget.assignment.handedIn = true;
                      // dev only
                      widget.assignment.feedbackItem = FeedbackItem(comments: [
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
                      feedbackItem: widget.assignment.feedbackItem!,
                      dismiss: () => removeOverlay(),
                    );
                  }),
                );
              },
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
 * class Assignment extends StudiousObject {
  final String assignmentName;
  final String description;
  final List<MaterialItem> materials;
  final List<MaterialItemType> allowedFileTypes;
  final ReviewConfigs reviewConfigs;
  final DateTime created;
  final DateTime deadline;
 */
