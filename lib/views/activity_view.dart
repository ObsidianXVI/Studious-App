part of studious.views;

class ActivityView extends StatelessWidget {
  final List<Activity> activites;

  const ActivityView({
    required this.activites,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CardShelf(
      shelfName: 'Activity History',
      data: activites,
      createWidget: (activity) => ActivityCard(activity: activity),
      doesMatch: (term, activity) =>
          activity.activityName.contains(term) ||
          activity.timestamp.timeAgo.contains(term),
    );
  }
}
