import 'package:arak_app/features/tasks/data/datasources/task_remote_data_source.dart';

import '../../domain/entities/task.dart';
import '../models/task_model.dart';

class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  @override
  Future<List<TaskModel>> getTeacherTasks({
    required String teacherId,
    required String classId,
  }) async {
    return [
      TaskModel(
        id: '1',
        title: 'Math Homework',
        description: 'Solve page 10',
        subject: 'Math',
        dueDate: DateTime.now(),
        status: TaskStatus.pending,
        assignedTo: classId,
      ),
    ];
  }

  @override
  Future<void> addTask(TaskModel task) async {}

  @override
  Future<double> getTeacherCompletedPercentage(String teacherId) async {
    return 60;
  }

  @override
  Future<List<TaskModel>> getStudentTasks(String studentId) async {
    return [];
  }

  @override
  Future<void> updateTaskStatus(String taskId, String status) async {}
}