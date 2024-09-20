import 'dart:convert';

import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 1)
class Task {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String taskName;
  @HiveField(2)
  String? taskDescription;
  @HiveField(3)
  String? taskCreatedDate;
  @HiveField(4)
  String? assignedTo;
  Task({
    this.id,
    required this.taskName,
    this.taskDescription,
    this.taskCreatedDate,
    this.assignedTo,
  });

  Task copyWith({
    int? id,
    String? taskName,
    String? taskDescription,
    String? taskCreatedDate,
    String? assignedTo,
  }) {
    return Task(
      id: id ?? this.id,
      taskName: taskName ?? this.taskName,
      taskDescription: taskDescription ?? this.taskDescription,
      taskCreatedDate: taskCreatedDate ?? this.taskCreatedDate,
      assignedTo: assignedTo ?? this.assignedTo,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    result.addAll({'taskName': taskName});
    if (taskDescription != null) {
      result.addAll({'taskDescription': taskDescription});
    }
    if (taskCreatedDate != null) {
      result.addAll({'taskCreatedDate': taskCreatedDate});
    }
    if (assignedTo != null) {
      result.addAll({'assignedTo': assignedTo});
    }

    return result;
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] ?? 0,
      taskName: map['taskName'] ?? '',
      taskDescription: map['taskDescription'],
      taskCreatedDate: map['taskCreatedDate'],
      assignedTo: map['assignedTo'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Task(id:$id   taskName: $taskName, taskDescription: $taskDescription, taskCreatedDate: $taskCreatedDate, assignedTo: $assignedTo)';
  }
}
