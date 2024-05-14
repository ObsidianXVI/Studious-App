part of studious.views;

class AssignmentViewer extends StatefulWidget {
  final DocumentSnapshot<Assignment> assignment;

  const AssignmentViewer({
    required this.assignment,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => AssignmentViewerState();
}

class AssignmentViewerState extends State<AssignmentViewer> with OverlayTools {
  final TextEditingController textController = TextEditingController();
  late final Assignment assignment = widget.assignment.data()!;
  late DocumentSnapshot<Student> student;
  late Student studentData;
  late final Future<DocumentSnapshot<Submission>> submissionDataFuture =
      Database.getSubmission(studentData.submissions[widget.assignment.id]!);

  late final Future dataFetchFuture;

  @override
  void initState() {
    super.initState();
    dataFetchFuture = updateStudentData();
  }

  Future<void> updateStudentData() async {
    student = await Database.getStudent(studentId!);
    studentData = student.data()!;
  }

  bool get assignmentIsSubmitted =>
      studentData.statusForAssignment(widget.assignment) ==
      AssignmentStatus.submitted;

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
                      assignmentIsSubmitted
                          ? FutureBuilder(
                              future: submissionDataFuture,
                              builder: (context, snapshot) {
                                return snapshot.connectionState ==
                                        ConnectionState.done
                                    ? Text(snapshot.data!.data()!.submittedText)
                                    : const CircularProgressIndicator();
                              })
                          : TextField(
                              controller: textController,
                            ),
                      const SizedBox(height: 10),
                      assignmentIsSubmitted
                          ? IconTextButton(
                              label: 'Undo Hand In',
                              iconData: Icons.close,
                              action: () async {
                                final String oldSubRef = studentData
                                    .submissions[widget.assignment.id]!;
                                // Delete the submission object
                                await Database.delete(
                                  Database.submissionsColl,
                                  oldSubRef,
                                );
                                // delete the associated submission for this assignment
                                await Database.update(
                                  Database.usersColl,
                                  studentId!,
                                  {
                                    'submissions': studentData.submissions
                                      ..remove(widget.assignment.id)
                                  },
                                );

                                // delete the old submission from the assignment's document
                                await Database.update(Database.assignmentsColl,
                                    widget.assignment.id, {
                                  'submissions': assignment.submissions
                                    ..remove(oldSubRef),
                                });

                                // record this in activity history
                                await Database.update(
                                  Database.usersColl,
                                  studentId!,
                                  {
                                    'activities': [
                                      for (var a in studentData.activities
                                        ..add(Activity(
                                          timestamp: DateTime.now(),
                                          activityName:
                                              'UNDO HAND IN: ${assignment.assignmentName}',
                                        )))
                                        a.toJson()
                                    ],
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
                              enabled: !assignmentIsSubmitted,
                              action: () async {
                                final Submission submission = Submission(
                                  userId: studentId!,
                                  assignmentId: widget.assignment.id,
                                  submittedFiles: [],
                                  submittedText: textController.text,
                                  comments: [],
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
                                  // delete the old submission from the Submissions collection
                                  await Database.delete(
                                      Database.submissionsColl, oldSubRef);
                                  // delete the old submission from the assignment's document
                                  // and inserts the new id
                                  await Database.update(
                                      Database.assignmentsColl,
                                      widget.assignment.id, {
                                    'submissions': assignment.submissions
                                      ..remove(oldSubRef)
                                      ..add(subRef.id),
                                  });
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
                                  // updates the assignment's submissions field
                                  await Database.update(
                                      Database.assignmentsColl,
                                      widget.assignment.id, {
                                    'submissions': assignment.submissions
                                      ..add(subRef.id),
                                  });
                                }

                                // record this in activity history
                                await Database.update(
                                  Database.usersColl,
                                  studentId!,
                                  {
                                    'activities': [
                                      for (var a in studentData.activities
                                        ..add(Activity(
                                          timestamp: DateTime.now(),
                                          activityName:
                                              'HAND IN: ${assignment.assignmentName}',
                                        )))
                                        a.toJson()
                                    ],
                                  },
                                );

                                await updateStudentData();
                                setState(() {});
                              },
                            ),
                      const SizedBox(height: 10),
                      IconTextButton(
                        label: 'View Feedback',
                        iconData: Icons.comment,
                        enabled: studentData.submissions
                            .containsKey(widget.assignment.id),
                        action: () async {
                          final DocumentSnapshot<Submission> submission =
                              await Database.getSubmission(
                            studentData.submissions[widget.assignment.id]!,
                          );
                          addOverlay(
                            overlay:
                                OverlayEntry(builder: (BuildContext context) {
                              return FeedbackOverlay(
                                refresh: setState,
                                comments: submission.data()!.comments,
                                subRef: submission.id,
                                dismiss: () => removeOverlay(),
                              );
                            }),
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      IconTextButton(
                        label: "View Others' Work",
                        iconData: Icons.groups,
                        enabled: assignmentIsSubmitted,
                        action: () async {
                          final List<DocumentSnapshot<Submission>> submissions =
                              await Database.getAll(Database.submissionsColl,
                                  assignment.submissions);
                          if (mounted) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) =>
                                    SubmissionsView(submissions: submissions),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
