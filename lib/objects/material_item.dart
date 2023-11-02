part of studious.objects;

enum MaterialItemType {
  pdf('pdf', Icon(Icons.picture_as_pdf)),
  image('png', Icon(Icons.image)),
  video('mp4', Icon(Icons.video_file)),
  audio('mp3', Icon(Icons.audio_file)),
  docx('docx', Icon(Icons.description)),
  excel('xlsx', Icon(Icons.table_view));

  final String ext;
  final Icon icon;

  const MaterialItemType(this.ext, this.icon);

  static MaterialItemType fromString(String name) {
    switch (name) {
      case 'pdf':
        return MaterialItemType.pdf;
      case 'png':
        return MaterialItemType.image;
      case 'mp4':
        return MaterialItemType.video;
      case 'xlsx':
        return MaterialItemType.excel;
      case 'mp3':
        return MaterialItemType.audio;
      case 'docx':
        return MaterialItemType.docx;
    }
    throw 'No such material type $name found';
  }
}

class MaterialItem extends StudiousObject {
  final String fileName;
  final MaterialItemType materialType;

  const MaterialItem({
    required this.fileName,
    required this.materialType,
  });

  MaterialItem.fromJson(Map<String, Object?> json)
      : fileName = json['fileName'] as String,
        materialType =
            MaterialItemType.fromString(json['materialType'] as String);

  @override
  Map<String, Object?> toJson() => {
        'fileName': fileName,
        'materialType': materialType.ext,
      };
}
