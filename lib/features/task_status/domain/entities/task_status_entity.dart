class TaskStatusEntity {
  final String taskId;
  final String studentId;
  final String studentName;
  final bool isDone;

  TaskStatusEntity({
    required this.taskId,
    required this.studentId,
    required this.studentName,
    required this.isDone,
  });

  Map<String, dynamic> toJson() {
    return {
      'taskId': taskId,
      'studentId': studentId,
      'studentName': studentName,
      'isDone': isDone,
    };
  }

  factory TaskStatusEntity.fromJson(Map<String, dynamic> json) {
    return TaskStatusEntity(
      taskId: json['taskId'],
      studentId: json['studentId'],
      studentName: json['studentName'],
      isDone: json['isDone'],
    );
  }
}