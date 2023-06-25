part of studious.views;

class Student_Assignment_Viewer extends StatelessWidget {
  final Assignment assignment;

  const Student_Assignment_Viewer({
    required this.assignment,
    super.key,
  });

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
                  avatar: assignment.materials[index].materialType.icon,
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
            IconTextButton(
              label: 'Upload Files',
              iconData: Icons.add,
              action: () {},
              enabled: !assignment.handedIn,
            ),
            const SizedBox(height: 10),
            assignment.handedIn
                ? IconTextButton(
                    label: 'Undo Hand In',
                    iconData: Icons.close,
                    action: () {},
                    enabled: true,
                  )
                : IconTextButton(
                    label: 'Hand In',
                    iconData: Icons.check,
                    action: () {},
                    enabled: true,
                  ),
            const SizedBox(height: 10),
            IconTextButton(
              label: 'View Feedback',
              iconData: Icons.comment,
              action: () {},
              enabled: assignment.hasFeedback,
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
