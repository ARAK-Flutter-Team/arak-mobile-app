import '../../domain/entities/task_student_status.dart';

class TaskStudentStatusModel extends TaskStudentStatus {
  const TaskStudentStatusModel({
    required super.studentId,
    required super.studentName,
    required super.isDone,
  });

  factory TaskStudentStatusModel.fromJson(Map<String, dynamic> json) {
    // Coerce studentId to String
    final rawStudentId = json['studentId'] ?? json['StudentId'];
    final studentId = rawStudentId?.toString() ?? "";

    // Fallback studentName
    final studentName = json['studentName'] ?? json['StudentName'] ?? "";

    // Coerce isDone to bool
    final rawIsDone = json['isDone'] ?? json['IsDone'];
    bool isDone = false;
    if (rawIsDone is bool) {
      isDone = rawIsDone;
    } else if (rawIsDone is int) {
      isDone = rawIsDone == 1;
    } else if (rawIsDone is String) {
      isDone = rawIsDone.toLowerCase() == "true";
    }

    return TaskStudentStatusModel(
      studentId: studentId,
      studentName: studentName,
      isDone: isDone,
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