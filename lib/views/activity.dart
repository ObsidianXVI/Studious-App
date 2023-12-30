part of studious.views;

class ActivityView extends StatelessWidget {
  final List<Activity> activites;

  const ActivityView({
    required this.activites,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shelf(
      title: 'Activity History',
      cards: List<Widget>.generate(
        activites.length,
        (i) => Center(
          child: Container(
            width: 300,
            height: 80,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "${activites[i].activityName}\n${activites[i].timestamp.timeAgo}",
                ),
              ),
            ),
          ),
        ),
      ),
      width: 500,
      height: 800,
    );
  }
}
