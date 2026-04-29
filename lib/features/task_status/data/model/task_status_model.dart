/*import '../../domain/entities/task_status_entity.dart';

class TaskStatusModel extends TaskStatusEntity {
  TaskStatusModel({
    required super.taskId,
    required super.studentId,
    required super.studentName,
    required super.isDone,
  });

  factory TaskStatusModel.fromJson(Map<String, dynamic> json) {
    return TaskStatusModel(
      taskId: json['taskId'],
      studentId: json['studentId'],
      studentName: json['studentName'],
      isDone: json['isDone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'taskId': taskId,
      'studentId': studentId,
      'studentName': studentName,
      'isDone': isDone,
    };
  }
}*/