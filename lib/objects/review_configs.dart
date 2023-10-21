part of studious.objects;

class ReviewConfigs extends StudiousObject {
  final ReviewTemplate? reviewTemplate;
  final bool allowAnonReviewing;

  const ReviewConfigs({
    required this.reviewTemplate,
    required this.allowAnonReviewing,
  });

  ReviewConfigs.fromJson(Map<String, Object?> json)
      : reviewTemplate = json.containsKey('reviewTemplate')
            ? ReviewTemplate.fromJson(
                json['reviewTemplate'] as Map<String, Object?>)
            : null,
        allowAnonReviewing = json['allowAnonReviewing'] as bool;

  Map<String, Object?> toJson() => {
        'reviewTemplate': reviewTemplate?.toJson(),
        'allowAnonReviewing': allowAnonReviewing,
      };
}

class ReviewTemplate extends StudiousObject {
  ReviewTemplate.fromJson(Map<String, Object?> json);

  Map<String, Object?> toJson() => {};
}
