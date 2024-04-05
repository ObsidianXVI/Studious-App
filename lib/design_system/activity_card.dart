part of studious.ds;

class ActivityCard extends StatefulWidget {
  final Activity activity;

  const ActivityCard({
    required this.activity,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => ActivityCardState();
}

class ActivityCardState extends State<ActivityCard> {
  double elevation = 0;

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
                    widget.activity.activityName,
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
                    widget.activity.timestamp.timeAgo,
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
    );
  }
}
