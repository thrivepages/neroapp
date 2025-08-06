import 'package:uuid/uuid.dart';

class Task {
  final String id;
  String text;
  bool completed;
  String time;
  DateTime? dueDate;
  String priority; // 'low', 'medium', 'high'

  Task({
    String? id,
    required this.text,
    this.completed = false,
    required this.time,
    this.dueDate,
    this.priority = 'medium',
  }) : id = id ?? const Uuid().v4();

  Task copyWith({
    String? text,
    bool? completed,
    String? time,
    DateTime? dueDate,
    String? priority,
  }) {
    return Task(
      id: id,
      text: text ?? this.text,
      completed: completed ?? this.completed,
      time: time ?? this.time,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'completed': completed,
      'time': time,
      'dueDate': dueDate?.toIso8601String(),
      'priority': priority,
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      text: json['text'],
      completed: json['completed'] ?? false,
      time: json['time'],
      dueDate: json['dueDate'] != null ? DateTime.parse(json['dueDate']) : null,
      priority: json['priority'] ?? 'medium',
    );
  }
}