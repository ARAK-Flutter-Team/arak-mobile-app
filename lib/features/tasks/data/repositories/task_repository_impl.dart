import 'package:arak_app/features/tasks/data/datasources/task_remote_data_source.dart';
import 'package:arak_app/features/tasks/data/models/task_model.dart';
import 'package:arak_app/features/tasks/domain/entities/task.dart';
import 'package:arak_app/features/tasks/domain/entities/teacher_tasks_result.dart';
import 'package:arak_app/features/tasks/domain/repositories/task_repository.dart';
import 'package:arak_app/features/tasks/domain/entities/task_student_status.dart';
import 'package:arak_app/features/tasks/data/models/task_student_status_model.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource remote;

  TaskRepositoryImpl(this.remote);

  @override
  Future<TeacherTasksResult> getTeacherTasks({
    required int teacherId,
    required int classId,
  }) async {
    return await remote.getTeacherTasks(
      teacherId: teacherId,
      classId: classId,
    );
  }

  @override
  Future<void> addTask(Task task) async {
    final model = TaskModel(
      id: task.id,
      title: task.title,
      description: task.description,
      dueDate: task.dueDate,
      status: task.status,
      assignedTo: task.assignedTo,
      teacherId: task.teacherId,
    );
    await remote.addTask(model);
  }

  @override
  Future<void> deleteTask(String taskId) async {
    await remote.deleteTask(taskId);
  }

  @override
  Future<void> updateTaskStatus(String taskId, TaskStatus status) async {
    await remote.updateTaskStatus(taskId, status);
  }

  @override
  Future<double> getTeacherCompletedPercentage(String teacherId) {
    return remote.getTeacherCompletedPercentage(teacherId);
  }

  @override
  Future<List<Task>> getStudentTasks(String studentId) {
    return remote.getStudentTasks(studentId);
  }

  @override
  Future<List<Task>> getParentTasks({required String studentId}) {
    return remote.getParentTasks(studentId: studentId);
  }

  // ==================== New Methods ====================
  @override
  Future<List<TaskStudentStatus>> getTaskStatus(int taskId) async {
    return await remote.getTaskStatus(taskId);
  }

  @override
  Future<void> updateTaskStudentStatus(int taskId, List<Map<String, dynamic>> updates) async {
    await remote.updateTaskStudentStatus(taskId, updates);
  }
}