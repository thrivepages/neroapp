import 'package:uuid/uuid.dart';

class JournalEntry {
  final String id;
  String title;
  String content;
  String mood; // emoji string
  DateTime createdAt;
  DateTime updatedAt;
  List<String> tags;

  JournalEntry({
    String? id,
    required this.title,
    required this.content,
    this.mood = '😐',
    DateTime? createdAt,
    DateTime? updatedAt,
    this.tags = const [],
  }) : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  JournalEntry copyWith({
    String? title,
    String? content,
    String? mood,
    DateTime? updatedAt,
    List<String>? tags,
  }) {
    return JournalEntry(
      id: id,
      title: title ?? this.title,
      content: content ?? this.content,
      mood: mood ?? this.mood,
      createdAt: createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
      tags: tags ?? this.tags,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'mood': mood,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'tags': tags,
    };
  }

  factory JournalEntry.fromJson(Map<String, dynamic> json) {
    return JournalEntry(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      mood: json['mood'] ?? '😐',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      tags: List<String>.from(json['tags'] ?? []),
    );
  }
}