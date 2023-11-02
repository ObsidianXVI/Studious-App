part of studious.ds;

class StatusCard extends StatefulWidget {
  final Student person;
  final Assignment assignmentData;
  final Color? color;

  const StatusCard({
    required this.person,
    required this.assignmentData,
    this.color,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => StatusCardState();
}

class StatusCardState extends State<StatusCard> {
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
      child: Align(
        alignment: Alignment.topLeft,
        child: Material(
          elevation: elevation,
          borderRadius: BorderRadius.circular(5),
          child: Container(
            width: double.infinity,
            height: 50,
            child: Center(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: widget.color?.withOpacity(0.09) ??
                      StudiousTheme.purple.withOpacity(0.09),
                  border: Border.all(
                    color: widget.color?.withOpacity(0.2) ??
                        StudiousTheme.purple.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Text(
                          widget.person.name,
                          style: const TextStyle(
                            color: StudiousTheme.purple,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Text(
                          widget.person.formClass,
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
        ),
      ),
    );
  }
}
