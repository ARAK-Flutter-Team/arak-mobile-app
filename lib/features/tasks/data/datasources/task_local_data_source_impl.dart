import 'package:arak_app/features/tasks/data/datasources/task_local_data_source.dart';

import '../../domain/entities/task.dart';
import '../models/task_model.dart';

class TaskLocalDataSourceImpl implements TaskLocalDataSource {
  final Map<String, List<TaskModel>> _cache = {};

  @override
  Future<void> cacheTeacherTasks(
      List<TaskModel> tasks, String classId) async {
    _cache[classId] = tasks;
  }

  @override
  Future<List<TaskModel>> getCachedTeacherTasks(
      String classId) async {
    return _cache[classId] ?? [];
  }

  @override
  Future<void> clearTeacherTasks(String classId) async {
    _cache.remove(classId);
  }

  @override
  Future<void> updateTaskStatusLocally(
      String taskId, String status) async {
    for (var entry in _cache.entries) {
      final index =
      entry.value.indexWhere((task) => task.id == taskId);
      if (index != -1) {
        final task = entry.value[index];
        entry.value[index] = TaskModel(
          id: task.id,
          title: task.title,
          description: task.description,
          subject: task.subject,
          dueDate: task.dueDate,
          status: status == 'completed'
              ? TaskStatus.completed
              : TaskStatus.pending,
          imageUrl: task.imageUrl,
          assignedTo: task.assignedTo,
        );
      }
    }
  }
}