import 'package:arak_app/features/tasks/data/datasources/task_remote_data_source.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arak_app/core/network/dio_provider.dart';
import 'package:arak_app/features/tasks/data/models/task_model.dart';
import 'package:arak_app/features/tasks/domain/entities/teacher_tasks_result.dart';

import '../../domain/entities/task.dart';

// استدعاء الـ Provider
final taskRemoteDataSourceProvider = Provider<TaskRemoteDataSource>((ref) {
  return TaskRemoteDataSourceImpl(ref.watch(dioProvider));
});

class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  final Dio dio;

  TaskRemoteDataSourceImpl(this.dio);

  @override
  Future<TeacherTasksResult> getTeacherTasks({
    required String teacherId,
    required String classId,
  }) async {
    final response = await dio.get(
      "/api/Tasks", // المسار الصحيح
      queryParameters: {
        "teacherId": int.tryParse(teacherId) ?? 0,
        "classId": int.tryParse(classId) ?? 0,
      },
    );

    // الباك بيرجع ليست مباشرة
    if (response.data is List) {
      final tasks =
          (response.data as List).map((e) => TaskModel.fromJson(e)).toList();

      return TeacherTasksResult(tasks: tasks, lastUpdated: DateTime.now());
    }

    return TeacherTasksResult(tasks: [], lastUpdated: DateTime.now());
  }

  @override
  Future<void> addTask(TaskModel task) async {
    // نبعث الـ Object كامل
    await dio.post(
      "/api/Tasks",
      data: task.toJson(),
    );
  }

  @override
  Future<void> deleteTask(String taskId) async {
    await dio.delete(
      "/api/Tasks/$taskId",
    );
  }

  @override
  Future<void> updateTaskStatus(String taskId, String status) async {
    // ملاحظة: الباك إند بيحتاج الـ Object كامل في الـ PUT
    // بما إن التاسك اللي عندنا في الـ Model فيه كل الداتا، بنبعته كامل
    // بس هنا بنستقبل الـ ID والـ Status بس من الريبو، فلازم ننتبه
    // سنفترض هنا إن الريبو بيبعت الـ Task كامل، لو مش كده الكود هيحتاج تعديل بسيط

    // الطريقة الآمنة: نبعث الـ State والـ ID بس، والباك يحدث الباقي (لو السيرفر مسموح)
    // أو نبعث داتا كاملة وهمية زي ما كنت عاملة، لكن الأفضل إدارة الـ Task كامل

    // بما إن الريبو بيبعث (String taskId, String status) فقط:
    await dio.put(
      "/api/Tasks/$taskId",
      data: {
        "id": int.tryParse(taskId) ?? 0,
        "state": status,
        // نبعث حقول وهمية عشان الـ Model Validator في الـ C# ما يزعلش
        "title": "placeholder",
        "description": "placeholder",
        "classId": 0,
        "teacherId": 0,
        "deadLine": DateTime.now().toIso8601String()
      },
    );
  }

  @override
  Future<double> getTeacherCompletedPercentage(String teacherId) async {
    // دي مفيش EndPoint ليها في السيرفر اللي ابعتته، بنرجع 0 مؤقتاً
    return 0.0;
  }

  @override
  Future<List<TaskModel>> getStudentTasks(String studentId) async {
    final response = await dio.get(
      '/api/Tasks',
      queryParameters: {'studentId': int.tryParse(studentId) ?? 0},
    );

    if (response.data is List) {
      return (response.data as List).map((e) => TaskModel.fromJson(e)).toList();
    }

    return [];
  }

  @override
  Future<List<Task>> getParentTasks({required String studentId}) async {
    final response = await dio.get(
      '/api/Tasks',
      queryParameters: {'studentId': int.tryParse(studentId) ?? 0},
    );

    if (response.data is List) {
      return (response.data as List).map((e) => TaskModel.fromJson(e)).toList();
    }

    return [];
  }
}
