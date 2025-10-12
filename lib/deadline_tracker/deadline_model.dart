// lib/deadline_tracker/deadline_model.dart
class Deadline {
  final String title;
  final String description;
  final String subject;
  final DateTime dueDate;

  Deadline({
    required this.title,
    required this.description,
    required this.subject,
    required this.dueDate,
  });

  // helper to convert to Map for storing in Hive
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'subject': subject,
      'dueDate': dueDate.toIso8601String(),
    };
  }

  // helper to create Deadline from a map loaded from Hive
  factory Deadline.fromMap(Map<dynamic, dynamic> map) {
    return Deadline(
      title: map['title'] as String? ?? '',
      description: map['description'] as String? ?? '',
      subject: map['subject'] as String? ?? '',
      dueDate: DateTime.parse(map['dueDate'] as String),
    );
  }
}
