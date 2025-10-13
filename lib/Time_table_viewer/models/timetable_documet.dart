class TimetableDocument {
  final String id;
  final String title;
  final String subtitle;
  final String filePath;

  TimetableDocument({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.filePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'filePath': filePath,
    };
  }

  factory TimetableDocument.fromMap(Map<String, dynamic> map) {
    return TimetableDocument(
      id: map['id'],
      title: map['title'],
      subtitle: map['subtitle'],
      filePath: map['filePath'],
    );
  }
}
