import '../../domain/entities/task.dart';
import '../../domain/entities/teacher_tasks_result.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasources/task_local_data_source.dart';
import '../datasources/task_remote_data_source.dart';
import '../models/task_model.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource remote;
  final TaskLocalDataSource local;

  TaskRepositoryImpl(this.remote, this.local);

  @override
  Future<TeacherTasksResult> getTeacherTasks({
    required String teacherId,
    required String classId,
  }) async {
    try {
      final result = await remote.getTeacherTasks(
        teacherId: teacherId,
        classId: classId,
      );

      // ✅ نحول Task → TaskModel قبل التخزين
      final models = result.tasks.map((task) {
        return TaskModel(
          id: task.id,
          title: task.title,
          description: task.description,
          subject: task.subject,
          dueDate: task.dueDate,
          status: task.status,
          imageUrl: task.imageUrl,
          assignedTo: task.assignedTo,
        );
      }).toList();

      await local.cacheTeacherTasks(models, classId);

      return result;
    } catch (_) {
      final cachedModels = await local.getCachedTeacherTasks(classId);

      return TeacherTasksResult(
        tasks: cachedModels, // هنا غالبًا already Task
        lastUpdated: DateTime.now(),
      );
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
    } catch (_) {}

    await local.updateTaskStatusLocally(taskId, status.name);
  }

  @override
  Future<List<Task>> getParentTasks({required String studentId}) {
    return remote.getParentTasks(studentId: studentId);
  }
}
