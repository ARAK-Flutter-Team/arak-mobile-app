import 'task.dart';

class TeacherTasksResult {
  final List<Task> tasks;
  final DateTime lastUpdated;

  TeacherTasksResult({
    required this.tasks,
    required this.lastUpdated,
  });
}