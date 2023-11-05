part of studious.objects;

class Activity extends StudiousObject {
  DateTime timestamp;
  String activityName;

  Activity({
    required this.timestamp,
    required this.activityName,
  });

  Activity.fromJson(Map<String, Object?> json)
      : timestamp =
            DateTime.fromMillisecondsSinceEpoch(json['timestamp']! as int),
        activityName = json['activityName']! as String;

  @override
  Map<String, Object?> toJson() => {
        'activityName': activityName,
        'timestamp': timestamp.millisecondsSinceEpoch,
      };
}
