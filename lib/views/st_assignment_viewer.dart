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
  late DocumentSnapshot<Student> student;
  late Student studentData;

  late final Future dataFetchFuture;

  @override
  void initState() {
    super.initState();
    dataFetchFuture = updateStudentData();
  }

  Future<void> updateStudentData() async {
    student = await Database.getStudent(studentId!);
    studentData = student.data()!;
    print(studentData.submissions.containsKey(widget.assignment.id));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: dataFetchFuture,
      builder: (_, snapshot) {
        return snapshot.connectionState == ConnectionState.waiting
            ? const CircularProgressIndicator()
            : ViewScaffold(
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
                        children: List<Widget>.generate(
                            assignment.materials.length, (index) {
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
                            backgroundColor:
                                StudiousTheme.darkPurple.withOpacity(0.3),
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
                                    for (final type
                                        in assignment.allowedFileTypes)
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
                              enabled: !(studentData
                                      .statusForAssignment(widget.assignment) ==
                                  AssignmentStatus.submitted),
                            )
                          : TextField(
                              controller: textController,
                            ),
                      const SizedBox(height: 10),
                      studentData.statusForAssignment(widget.assignment) ==
                              AssignmentStatus.submitted
                          ? IconTextButton(
                              label: 'Undo Hand In',
                              iconData: Icons.close,
                              action: () async {
                                // Delete the submission object
                                await Database.delete(
                                    Database.submissionsColl,
                                    studentData
                                        .submissions[widget.assignment.id]!);
                                assignment.comments.clear();
                                // delete the associated submission for this assignment
                                await Database.update(
                                  Database.usersColl,
                                  studentId!,
                                  {
                                    'submissions': studentData.submissions
                                      ..remove(widget.assignment.id)
                                  },
                                );
                                await updateStudentData();
                                setState(() {});
                              },
                              enabled: true,
                            )
                          : IconTextButton(
                              label: 'Hand In',
                              iconData: Icons.check,
                              action: () async {
                                final Submission submission = Submission(
                                  assignmentId: widget.assignment.id,
                                  submittedFiles: [],
                                  submittedText: textController.text,
                                );
                                // create a new submission
                                final DocumentReference<Submission> subRef =
                                    await Database.insert(
                                        Database.submissionsColl, submission);
                                // check if there is an existing submission for this assignment
                                if (studentData.submissions
                                    .containsKey(widget.assignment.id)) {
                                  // update the submission reference
                                  final Map newMap = studentData.submissions;
                                  final String oldSubRef =
                                      newMap[widget.assignment.id];
                                  newMap[widget.assignment.id] = subRef.id;
                                  await Database.update(
                                    Database.usersColl,
                                    studentId!,
                                    {'submissions': newMap},
                                  );
                                  // delete the old submission
                                  await Database.delete(
                                      Database.submissionsColl, oldSubRef);
                                } else {
                                  // create a new entry for submission for this assignment
                                  await Database.update(
                                    Database.usersColl,
                                    studentId!,
                                    {
                                      'submissions': studentData.submissions
                                        ..addAll(
                                            {widget.assignment.id: subRef.id})
                                    },
                                  );
                                }

                                // dev only
                                assignment.comments.add(
                                  CommentItem(
                                    user: 'Small Sean',
                                    content: 'Very insightful insights!',
                                    upvotes: 2,
                                  ),
                                );
                                await updateStudentData();
                                setState(() {});
                              },
                              enabled: studentData
                                      .statusForAssignment(widget.assignment) !=
                                  AssignmentStatus.submitted,
                            ),
                      const SizedBox(height: 10),
                      IconTextButton(
                        label: 'View Feedback',
                        iconData: Icons.comment,
                        action: () {
                          addOverlay(
                            overlay:
                                OverlayEntry(builder: (BuildContext context) {
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
      },
    );
  }
}
