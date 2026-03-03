import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasources/task_local_data_source.dart';
import '../datasources/task_remote_data_source.dart';
import '../models/task_model.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource remote;
  final TaskLocalDataSource local;

  TaskRepositoryImpl(this.remote, this.local);

  @override
  Future<List<Task>> getTeacherTasks({
    required String teacherId,
    required String classId,
  }) async {
    try {
      final tasks = await remote.getTeacherTasks(
        teacherId: teacherId,
        classId: classId,
      );

      await local.cacheTeacherTasks(tasks, classId);

      return tasks;
    } catch (_) {
      return await local.getCachedTeacherTasks(classId);
    }
  }

  @override
  Future<void> addTask(Task task) async {
    final model = TaskModel(
      id: task.id,
      title: task.title,
      description: task.description,
      subject: task.subject,
      dueDate: task.dueDate,
      status: task.status,
      imageUrl: task.imageUrl,
      assignedTo: task.assignedTo,
    );

    await remote.addTask(model);

    // 🔥 Clear cache for that class so next fetch gets fresh data
    await local.clearTeacherTasks(task.assignedTo);
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
  Future<void> updateTaskStatus(
      String taskId,
      TaskStatus status,
      ) async {

    try {
      await remote.updateTaskStatus(taskId, status.name);
    } catch (_) {
      // ممكن نسجل error في المستقبل
    }

    // Update locally anyway (Optimistic update)
    await local.updateTaskStatusLocally(taskId, status.name);
  }
}