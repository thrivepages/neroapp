import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class StickyNote {
  final String id;
  String content;
  Color color;
  DateTime createdAt;
  DateTime updatedAt;

  StickyNote({
    String? id,
    required this.content,
    required this.color,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  StickyNote copyWith({
    String? content,
    Color? color,
    DateTime? updatedAt,
  }) {
    return StickyNote(
      id: id,
      content: content ?? this.content,
      color: color ?? this.color,
      createdAt: createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'color': color.value,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory StickyNote.fromJson(Map<String, dynamic> json) {
    return StickyNote(
      id: json['id'],
      content: json['content'],
      color: Color(json['color']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}