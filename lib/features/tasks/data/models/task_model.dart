/*import '../../domain/entities/task.dart';

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
    super.teacherName,
    super.teacherFeedback,
    super.progress,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      subject: json['subject'],
      dueDate: DateTime.parse(json['dueDate']),
      status: switch (json['status']) {
        'completed' => TaskStatus.completed,
        'pending' => TaskStatus.pending,
        _ => TaskStatus.notStarted,
      },
      imageUrl: json['imageUrl'],
      assignedTo: json['assignedTo'],
      teacherName: json['teacherName'],
      teacherFeedback: json['teacherFeedback'],
      progress: json['progress']?.toDouble(),
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
      'teacherName': teacherName,
      'teacherFeedback': teacherFeedback,
      'progress': progress,
    };
  }
}*/
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
    super.teacherName,
    super.teacherFeedback,
    super.progress,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      subject: json['subject'],
      dueDate: DateTime.parse(json['dueDate']),
      status: TaskStatus.values.firstWhere(
            (e) => e.name == json['status'],
        orElse: () => TaskStatus.pending,
      ),
      imageUrl: json['imageUrl'],
      assignedTo: json['assignedTo'],
      teacherName: json['teacherName'],
      teacherFeedback: json['teacherFeedback'],
      progress: json['progress']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'subject': subject,
      'dueDate': dueDate.toIso8601String(),
      'status': status.name, // 👈 يحول enum إلى String
      'imageUrl': imageUrl,
      'assignedTo': assignedTo,
      'teacherName': teacherName,
      'teacherFeedback': teacherFeedback,
      'progress': progress,
    };
  }
}