part of studious.objects;

class ReviewConfigs extends StudiousObject {
  final ReviewTemplate? reviewTemplate;
  final bool allowAnonReviewing;

  const ReviewConfigs({
    required this.reviewTemplate,
    required this.allowAnonReviewing,
  });
}

class ReviewTemplate extends StudiousObject {}
