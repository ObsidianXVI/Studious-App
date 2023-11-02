part of studious.objects;

class Person extends StudiousObject {
  final String name;
  final String formClass;

  const Person({
    required this.name,
    required this.formClass,
  });

  @override
  Map<String, Object?> toJson() => {
        'name': name,
        'formClass': formClass,
      };
}
