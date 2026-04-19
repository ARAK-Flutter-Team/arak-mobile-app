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
    super.isDeleted
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
      isDeleted: json['isDeleted'] ?? false, // 👈 جديد
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
      'isDeleted': isDeleted,
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
    super.isDeleted,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'].toString(),

      ///  IMPORTANT mapping from backend
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      subject: json['subject'] ?? "",

      ///  backend ممكن يبعت DateTime string
      dueDate: DateTime.tryParse(json['dueDate'] ?? "") ??
          DateTime.now(),

      ///  backend uses "state"
      status: (json['state'] ?? "Pending") == "Completed"
          ? TaskStatus.completed
          : TaskStatus.pending,

      imageUrl: json['imageUrl'],

      ///  غالبًا ClassId
      assignedTo: json['classId']?.toString() ?? "",

      teacherName: json['teacherId']?.toString(),

      isDeleted: json['isDeleted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": int.tryParse(id),
      "title": title,
      "description": description,
      "subject": subject,
      "dueDate": dueDate.toIso8601String(),

      ///  IMPORTANT
      "state": status == TaskStatus.completed
          ? "Completed"
          : "Pending",

      "classId": int.tryParse(assignedTo),
      "teacherId": int.tryParse(teacherName ?? "0"),
    };
  }
}