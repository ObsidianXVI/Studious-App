part of studious.ds;

class SubmissionCard extends StatefulWidget {
  final DocumentSnapshot<Submission> subData;

  const SubmissionCard({
    required this.subData,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => SubmissionCardState();
}

class SubmissionCardState extends State<SubmissionCard> {
  double elevation = 0;
  late Submission sub = widget.subData.data()!;
  late final studentNameFuture = () async {
    return (await Database.getStudent(widget.subData.data()!.userId)).data()!;
  }();

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
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
                  builder: (_) => FeedbackView(subRef: widget.subData)),
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
                    child: FutureBuilder(
                      future: studentNameFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Text(
                            snapshot.data!.name,
                            style: const TextStyle(
                              color: StudiousTheme.purple,
                              fontSize: 18,
                            ),
                          );
                        } else {
                          return const SizedBox(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                  Positioned(
                    top: 25,
                    left: 0,
                    child: Text(
                      sub.submittedText,
                      softWrap: false,
                      style: const TextStyle(
                        color: StudiousTheme.purple,
                        fontSize: 14,
                        overflow: TextOverflow.ellipsis,
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
