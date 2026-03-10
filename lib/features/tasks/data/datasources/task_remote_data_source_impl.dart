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
          assignedTo: classId),
      TaskModel(
          id: '2',
          title: 'English Essay',
          description: 'Write 200 words about nature',
          subject: 'English',
          dueDate: DateTime.now().add(const Duration(days: 2)),
          status: TaskStatus.pending,
          assignedTo: classId),
      TaskModel(
          id: '3',
          title: 'Science Project',
          description: 'Prepare volcano model',
          subject: 'Science',
          dueDate: DateTime.now().add(const Duration(days: 3)),
          status: TaskStatus.completed,
          assignedTo: classId),
      TaskModel(
          id: '4',
          title: 'History Presentation',
          description: 'Prepare slides about Ancient Egypt',
          subject: 'History',
          dueDate: DateTime.now().add(const Duration(days: 4)),
          status: TaskStatus.pending,
          assignedTo: classId),
    ];

    return TeacherTasksResult(
      tasks: tasks,
      lastUpdated: DateTime.parse("2026-03-03T10:15:00Z"),
    );
  }

  @override
  Future<void> addTask(TaskModel task) async {}

  @override
  Future<double> getTeacherCompletedPercentage(String teacherId) async => 60;

  @override
  Future<List<TaskModel>> getStudentTasks(String studentId) async => [];

  @override
  Future<void> updateTaskStatus(String taskId, String status) async {}

  @override
  Future<List<Task>> getParentTasks({required String studentId}) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return [
      Task(
        id: '1',
        title: 'Count 1 - 3',
        description: 'Learn to count from 1 to 3',
        subject: 'Math',
        dueDate: DateTime(2024, 10, 18),
        status: TaskStatus.notStarted,
        assignedTo: studentId,
        teacherName: "Mr. Ali Ahmed",
        teacherFeedback: 'Great effort!',
        progress: 0.0,
      ),
      Task(
        id: '2',
        title: 'Drawing shapes',
        description: 'Draw basic shapes',
        subject: 'Art',
        dueDate: DateTime(2024, 10, 16),
        status: TaskStatus.completed,
        assignedTo: studentId,
        teacherName: 'Ms. Sara',
        teacherFeedback: 'Well done!',
        progress: 1.0,
      ),
      Task(
        id: '3',
        title: 'Learn 3 letters',
        description: 'Learn the letters A, B, C',
        subject: 'Arabic',
        dueDate: DateTime(2024, 10, 17),
        status: TaskStatus.pending,
        assignedTo: studentId,
        teacherName: 'Mr. Hassan',
        teacherFeedback: 'Keep going!',
        progress: 0.5,
      ),
      Task(
        id: '4',
        title: 'Science',
        description: 'Read chapter 2',
        subject: 'Science',
        dueDate: DateTime(2024, 10, 19),
        status: TaskStatus.pending,
        assignedTo: studentId,
        teacherName: 'Mr. Kamal',
        teacherFeedback: 'Almost there!',
        progress: 0.3,
      ),
    ];
  }
}
