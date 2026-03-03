import '../../domain/entities/task.dart';

class TaskModel extends Task {
  TaskModel({
    required super.id,
    required super.title,
    required super.description,
    required super.subject,
    required super.dueDate,
    required super.status,
    super.imageUrl,
    required super.assignedTo,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      subject: json['subject'],
      dueDate: DateTime.parse(json['dueDate']),
      status: json['status'] == 'completed'
          ? TaskStatus.completed
          : TaskStatus.pending,
      imageUrl: json['imageUrl'],
      assignedTo: json['assignedTo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'subject': subject,
      'dueDate': dueDate.toIso8601String(),
      'status': status.name,
      'imageUrl': imageUrl,
      'assignedTo': assignedTo,
    };
  }
}