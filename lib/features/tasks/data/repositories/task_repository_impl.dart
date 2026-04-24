/*import '../../domain/entities/task.dart';
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

      //  نحول Task → TaskModel قبل التخزين
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

  @override
  Future<void> deleteTask(String taskId) async {
    await remote.deleteTask(taskId);
  }
}*/
/*import '../../domain/entities/task.dart';
import '../../domain/entities/teacher_tasks_result.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasources/task_remote_data_source.dart';
import '../models/task_model.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource remote;
  //final TaskLocalDataSource local;

  TaskRepositoryImpl(this.remote, /*this.local*/);

  /*@override
  Future<TeacherTasksResult> getTeacherTasks({
    required String teacherId,
    required String classId,
  }) async {
    try {
      final result = await remote.getTeacherTasks(
        teacherId: teacherId,
        classId: classId,
      );

      final models = result.tasks.map((task) {
        return TaskModel(
          id: task.id,
          title: task.title,
          description: task.description,
          subject: task.subject,
          dueDate: task.dueDate,
          status: task.status,
          assignedTo: task.assignedTo,
          teacherName: task.teacherName,
        );
      }).toList();

      await local.cacheTeacherTasks(models, classId);

      return result;
    } catch (_) {
      final cached = await local.getCachedTeacherTasks(classId);

      return TeacherTasksResult(
        tasks: cached,
        lastUpdated: DateTime.now(),
      );
    }
  }*/
  @override
  Future<TeacherTasksResult> getTeacherTasks({
    required String teacherId,
    required String classId,
  }) async {
    return await remote.getTeacherTasks(
      teacherId: teacherId,
      classId: classId,
    );
  }
  /*@override
  Future<void> addTask(Task task) async {
    final model = TaskModel(
      id: task.id,
      title: task.title,
      description: task.description,
      subject: task.subject,
      dueDate: task.dueDate,
      status: task.status,
      assignedTo: task.assignedTo,
      teacherName: task.teacherName,
    );

    await remote.addTask(model);
    await local.clearTeacherTasks(task.assignedTo);
  }*/
  @override
  Future<void> addTask(Task task) async {
    final model = TaskModel(
      id: task.id,
      title: task.title,
      description: task.description,
      subject: task.subject,
      dueDate: task.dueDate,
      status: task.status,
      assignedTo: task.assignedTo,
      teacherName: task.teacherName,
    );

    await remote.addTask(model);
  }
  @override
  Future<void> deleteTask(String taskId) async {
    await remote.deleteTask(taskId);
  }

  /*@override
  Future<void> updateTaskStatus(String taskId, TaskStatus status) async {
    await remote.updateTaskStatus(taskId, status.name);
    await local.updateTaskStatusLocally(taskId, status.name);
  }*/
  @override
  Future<void> updateTaskStatus(String taskId, TaskStatus status) async {
    await remote.updateTaskStatus(taskId, status.name);
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
}*/
import 'package:arak_app/features/tasks/data/datasources/task_remote_data_source.dart';
import 'package:arak_app/features/tasks/data/models/task_model.dart';
import 'package:arak_app/features/tasks/domain/entities/task.dart';
import 'package:arak_app/features/tasks/domain/entities/teacher_tasks_result.dart';
import 'package:arak_app/features/tasks/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource remote;

  TaskRepositoryImpl(this.remote);

  @override
  Future<TeacherTasksResult> getTeacherTasks({
    required String teacherId,
    required String classId,
  }) async {
    return await remote.getTeacherTasks(
      teacherId: teacherId,
      classId: classId,
    );
  }

  @override
  Future<void> addTask(Task task) async {
    final model = TaskModel(
      id: task.id, // عادة بيكون 0 عند الإضافة
      title: task.title,
      description: task.description,
      subject: task.subject,
      dueDate: task.dueDate,
      status: task.status,
      assignedTo: task.assignedTo,
      teacherName: task.teacherName,
    );
    await remote.addTask(model);
  }

  @override
  Future<void> deleteTask(String taskId) async {
    await remote.deleteTask(taskId);
  }

  @override
  Future<void> updateTaskStatus(String taskId, TaskStatus status) async {
    await remote.updateTaskStatus(taskId, status.name);
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
}