import '../../domain/entities/task.dart';

class TaskModel extends Task {
  const TaskModel({
    required super.id,
    required super.title,
    required super.description,
    required super.dueDate,
    required super.createdDate,
    required super.status,
    required super.assignedTo,
    super.teacherId,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id']?.toString() ?? "0",
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      dueDate: json['deadLine'] != null
          ? DateTime.parse(json['deadLine'])
          : DateTime.now(),
      createdDate: json['createdDate'] != null
          ? DateTime.parse(json['createdDate'])
          : DateTime.now(),
      status: (json['state']?.toString().toLowerCase() == "completed")
          ? TaskStatus.completed
          : TaskStatus.pending,
      assignedTo: json['classId']?.toString() ?? "0",
      teacherId: json['teacherId']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "deadLine": dueDate.toIso8601String(),
      "classId": int.tryParse(assignedTo) ?? 0,
    };
  }
}