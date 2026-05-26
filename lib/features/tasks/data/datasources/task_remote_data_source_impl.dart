import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arak_app/core/network/dio_provider.dart';
import 'package:arak_app/features/tasks/data/models/task_model.dart';
import 'package:arak_app/features/tasks/domain/entities/teacher_tasks_result.dart';
import 'package:arak_app/features/tasks/domain/entities/task.dart';
import 'package:arak_app/features/tasks/data/models/task_student_status_model.dart';
import '../../domain/entities/task_student_status.dart';
import 'task_remote_data_source.dart';

final taskRemoteDataSourceProvider = Provider<TaskRemoteDataSource>((ref) {
  return TaskRemoteDataSourceImpl(ref.watch(dioProvider));
});

class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  final Dio dio;

  TaskRemoteDataSourceImpl(this.dio);

  @override
  Future<TeacherTasksResult> getTeacherTasks({
    required int teacherId,
    required int classId,
  }) async {
    final response = await dio.get(
      "/Tasks",
      queryParameters: {
        "teacherId": teacherId,
        "classId": classId,
      },
    );

    if (response.data is List) {
      final tasks =
          (response.data as List).map((e) => TaskModel.fromJson(e)).toList();
      return TeacherTasksResult(tasks: tasks, lastUpdated: DateTime.now());
    }

    return TeacherTasksResult(tasks: [], lastUpdated: DateTime.now());
  }

  @override
  Future<void> addTask(TaskModel task) async {
    await dio.post("/Tasks", data: task.toJson());
  }

  @override
  Future<void> deleteTask(String taskId) async {
    await dio.delete("/Tasks/$taskId");
  }

  @override
  Future<void> updateTaskStatus(String taskId, TaskStatus status) async {
    await dio.put(
      "/Tasks/$taskId",
      data: {
        "id": int.tryParse(taskId) ?? 0,
        "state": status == TaskStatus.completed ? "Completed" : "Pending",
      },
    );
  }

  @override
  Future<double> getTeacherCompletedPercentage(String teacherId) async {
    return 0.0;
  }

  @override
  Future<List<TaskModel>> getStudentTasks(String studentId) async {
    final response = await dio.get(
      '/Tasks',
      queryParameters: {'studentId': int.tryParse(studentId) ?? 0},
    );

    if (response.data is List) {
      // ✅ حط السطرين دول
      for (var item in response.data) {
        print('🔴 RAW TASK: $item');
      }
      return (response.data as List).map((e) => TaskModel.fromJson(e)).toList();
    }

    return [];
  }

  @override
  Future<List<Task>> getParentTasks({required String studentId}) async {
    final response = await dio.get(
      '/Tasks',
      queryParameters: {'studentId': int.tryParse(studentId) ?? 0},
    );

    if (response.data is List) {
      return (response.data as List).map((e) => TaskModel.fromJson(e)).toList();
    }

    return [];
  }

// ==================== New Methods ====================
  @override
  Future<List<TaskStudentStatus>> getTaskStatus(int taskId) async {
    final response = await dio.get("/Tasks/$taskId/status");

    if (response.data is List) {
      return (response.data as List)
          .map(
              (e) => TaskStudentStatusModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  @override
  Future<void> updateTaskStudentStatus(
      int taskId, List<Map<String, dynamic>> updates) async {
    await dio.put("/Tasks/$taskId/status", data: updates);
  }
}
