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
}

class MaterialItem extends StudiousObject {
  final String fileName;
  final MaterialItemType materialType;

  const MaterialItem({
    required this.fileName,
    required this.materialType,
  });
}
