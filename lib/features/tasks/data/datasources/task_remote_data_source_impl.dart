import 'package:arak_app/features/tasks/data/datasources/task_remote_data_source.dart';

import '../../domain/entities/task.dart';
import '../../domain/entities/teacher_tasks_result.dart';
import '../models/task_model.dart';

class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {

  @override
  Future<TeacherTasksResult> getTeacherTasks({
    required String teacherId,
    required String classId,
  }) async {

    final tasks = [
     TaskModel(
        id: '1',
        title: 'Math Homework',
        description: 'Solve page 10',
        subject: 'Math',
        dueDate: DateTime.now(),
        status: TaskStatus.pending,
        assignedTo: classId,
      ),
      TaskModel(
        id: '2',
        title: 'English Essay',
        description: 'Write 200 words about nature',
        subject: 'English',
        dueDate: DateTime.now().add(const Duration(days: 2)),
        status: TaskStatus.pending, // 👈 مش completed
        assignedTo: classId,
      ),
      TaskModel(
        id: '3',
        title: 'Science Project',
        description: 'Prepare volcano model',
        subject: 'Science',
        dueDate: DateTime.now().add(const Duration(days: 3)),
        status: TaskStatus.completed,
        assignedTo: classId,
      ),
      TaskModel(
        id: '4',
        title: 'History Presentation',
        description: 'Prepare slides about Ancient Egypt',
        subject: 'History',
        dueDate: DateTime.now().add(const Duration(days: 4)),
        status: TaskStatus.pending,
        assignedTo: classId,
      ),
    ];

    return TeacherTasksResult(
      tasks: tasks,
      lastUpdated: DateTime.parse("2026-03-03T10:15:00Z"),
    );
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