import '../../domain/entities/task_student_status.dart';

class TaskStudentStatusModel extends TaskStudentStatus {
  const TaskStudentStatusModel({
    required super.studentId,
    required super.studentName,
    required super.isDone,
  });

  factory TaskStudentStatusModel.fromJson(Map<String, dynamic> json) {
    return TaskStudentStatusModel(
      studentId: json['studentId']?.toString() ?? "",
      studentName: json['studentName'] ?? "",
      isDone: json['isDone'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "studentId": studentId,
      "studentName": studentName,
      "isDone": isDone,
    };
  }
}