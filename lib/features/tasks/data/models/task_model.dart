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
    if (json['id'] == null && json['Id'] == null) {
      throw Exception("Task ID is missing in the API response.");
    }
    return TaskModel(
      id: (json['id'] ?? json['Id']).toString(),
      title: json['title'] ?? json['Title'] ?? "",
      description: json['description'] ?? json['Description'] ?? "",
      dueDate: json['deadLine'] != null
          ? DateTime.parse(json['deadLine'])
          : (json['DeadLine'] != null
              ? DateTime.parse(json['DeadLine'])
              : DateTime.now()),
      createdDate: json['createdDate'] != null
          ? DateTime.parse(json['createdDate'])
          : (json['CreatedDate'] != null
              ? DateTime.parse(json['CreatedDate'])
              : DateTime.now()),
      status: (json['state']?.toString().toLowerCase() == "completed" ||
              json['State']?.toString().toLowerCase() == "completed")
          ? TaskStatus.completed
          : TaskStatus.pending,
      assignedTo: (json['classId'] ?? json['ClassId'])?.toString() ?? "0",
      teacherId: (json['teacherId'] ?? json['TeacherId'])?.toString(),
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