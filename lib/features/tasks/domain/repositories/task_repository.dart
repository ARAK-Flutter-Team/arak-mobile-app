import '../entities/task.dart';
import '../entities/teacher_tasks_result.dart';

abstract class TaskRepository {
  // Teacher
  //Future<List<Task>> getTeacherTasks({
  Future<TeacherTasksResult> getTeacherTasks({
    required String teacherId,
    required String classId,
  });

  Future<void> addTask(Task task);

  Future<double> getTeacherCompletedPercentage(String teacherId);

  // Student
  Future<List<Task>> getStudentTasks(String studentId);

  Future<void> updateTaskStatus(String taskId, TaskStatus status);
}