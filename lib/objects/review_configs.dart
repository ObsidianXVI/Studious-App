part of studious.objects;

class ReviewConfigs extends StudiousObject {
  ReviewTemplate? reviewTemplate;
  bool allowAnonReviewing;

  ReviewConfigs({
    required this.reviewTemplate,
    required this.allowAnonReviewing,
  });

  ReviewConfigs.fromJson(Map<String, Object?> json)
      : reviewTemplate = json.containsKey('reviewTemplate')
            ? ReviewTemplate.fromJson(
                json['reviewTemplate'] as Map<String, Object?>)
            : null,
        allowAnonReviewing = json['allowAnonReviewing'] as bool;

  @override
  Map<String, Object?> toJson() => {
        'reviewTemplate': reviewTemplate?.toJson(),
        'allowAnonReviewing': allowAnonReviewing,
      };
}

class ReviewTemplate extends StudiousObject {
  ReviewTemplate.fromJson(Map<String, Object?> json);

  @override
  Map<String, Object?> toJson() => {};
}
