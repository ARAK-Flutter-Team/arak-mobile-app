/*import 'package:arak_app/features/tasks/data/datasources/task_remote_data_source.dart';
import '../../domain/entities/task.dart';
import '../../domain/entities/teacher_tasks_result.dart';
import '../models/task_model.dart';

class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  /// تخزين التاسكات لكل Class
  final Map<String, List<TaskModel>> _tasksByClass = {};

  /// ==============================
  /// جلب التاسكات للمعلم حسب الكلاس
  /// ==============================
  @override
  Future<TeacherTasksResult> getTeacherTasks({
    required String teacherId,
    required String classId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 400));

    final tasks = _tasksByClass[classId] ?? [];

    return TeacherTasksResult(
      tasks: tasks,
      lastUpdated: DateTime.now(),
    );
  }

  /// ==============================
  /// إضافة مهمة جديدة
  /// ==============================
  @override
  Future<void> addTask(TaskModel task) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final classId = task.assignedTo;

    // لو الكلاس مش موجود، اعمله
    if (!_tasksByClass.containsKey(classId)) {
      _tasksByClass[classId] = [];
    }

    _tasksByClass[classId]!.add(task);
  }

  /// ==============================
  /// الحصول على نسبة الانتهاء (Mock)
  /// ==============================
  @override
  Future<double> getTeacherCompletedPercentage(String teacherId) async {
    return 0; // Mock data
  }

  /// ==============================
  /// جلب المهام للطالب (Mock)
  /// ==============================
  @override
  Future<List<TaskModel>> getStudentTasks(String studentId) async {
    return [];
  }

  /// ==============================
  /// تحديث حالة المهمة
  /// ==============================
  @override
  Future<void> updateTaskStatus(String taskId, String status) async {
    for (var entry in _tasksByClass.entries) {
      final index = entry.value.indexWhere((task) => task.id == taskId);
      if (index != -1) {
        final task = entry.value[index];
        entry.value[index] = TaskModel(
          id: task.id,
          title: task.title,
          description: task.description,
          subject: task.subject,
          dueDate: task.dueDate,
          status:
          status == 'completed' ? TaskStatus.completed : TaskStatus.pending,
          imageUrl: task.imageUrl,
          assignedTo: task.assignedTo,
        );
      }
    }
  }

  /// ==============================
  /// جلب المهام لأولياء الأمور (Mock)
  /// ==============================
  @override
  Future<List<Task>> getParentTasks({required String studentId}) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final allTasks = _tasksByClass.values.expand((list) => list).toList();
    return allTasks.where((task) => task.assignedTo == studentId).toList();
  }
  @override
  Future<void> deleteTask(String taskId) async {
    for (var entry in _tasksByClass.entries) {
      final index = entry.value.indexWhere((task) => task.id == taskId);
      if (index != -1) {
        final task = entry.value[index];

        entry.value[index] = TaskModel(
          id: task.id,
          title: task.title,
          description: task.description,
          subject: task.subject,
          dueDate: task.dueDate,
          status: task.status,
          imageUrl: task.imageUrl,
          assignedTo:
import 'package:shared_preferences/shared_preferences.dart'; task.assignedTo,
          isDeleted: true,
        );
      }
    }
  }
}*/
/*import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/task.dart';
import '../../domain/entities/teacher_tasks_result.dart';
import '../models/task_model.dart';
import 'task_remote_data_source.dart';

class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  final Dio dio;

  TaskRemoteDataSourceImpl(this.dio);

  /*@override
  Future<TeacherTasksResult> getTeacherTasks({
    required String teacherId,
    required String classId,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await dio.get(
      "/api/tasks",
      queryParameters: {
        "teacherId": int.parse(teacherId),
        "classId": int.parse(classId),
      },
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );

   // final List data = response.data;
    final data = response.data;

    print("API RESPONSE = $data");

    final List tasksJson = data["tasks"]; // لو الباك بيرجع object

    final tasks = tasksJson.map((e) => TaskModel.fromJson(e)).toList();

    return TeacherTasksResult(
      tasks: tasks,
      lastUpdated: DateTime.now(),
    );
  }*/
  /*@override
  Future<TeacherTasksResult> getTeacherTasks({
    required String teacherId,
    required String classId,
  }) async {

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      print(" TOKEN NULL → user not logged in");
      throw Exception("No token found");
    }

    print("TOKEN = $token");
    print("CALL API teacherId=$teacherId classId=$classId");

    final safeTeacherId = int.tryParse(teacherId);
    if (safeTeacherId == null) {
      print(" INVALID teacherId: $teacherId");
      throw Exception("Invalid teacherId");
    }

    final safeClassId = int.tryParse(classId);
    if (safeClassId == null) {
      print(" INVALID classId: $classId");
      throw Exception("Invalid classId");
    }
    final response = await dio.get(
      "/api/tasks",
      queryParameters: {
        "teacherId": safeTeacherId,
        "classId": safeClassId,
      },
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );

    print("API RESPONSE = ${response.data}");

    final data = response.data;
    if (data == null) {
      print(" RESPONSE NULL");
      return TeacherTasksResult(tasks: [], lastUpdated: DateTime.now());
    }
    print("RAW RESPONSE = $data");

    final tasksJson = (data is List)
        ? data
        : (data["tasks"] ?? data["data"]?["tasks"] ?? []);

    if (tasksJson is! List) {
      print(" tasksJson NOT LIST: $tasksJson");
      return TeacherTasksResult(tasks: [], lastUpdated: DateTime.now());
    }

    final tasks = tasksJson
        .where((e) => e is Map)
        .map((e) => TaskModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();

    print("TASKS COUNT = ${tasks.length}");

    return TeacherTasksResult(
      tasks: tasks,
      lastUpdated: DateTime.now(),
    );
  }*/
  @override
  Future<TeacherTasksResult> getTeacherTasks({
    required String teacherId,
    required String classId,
  }) async {

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      print("TOKEN NULL");
      throw Exception("No token found");
    }

    print("TOKEN = $token");
    print("CALL API teacherId=$teacherId classId=$classId");

    final response = await dio.get(
      "/api/tasks",
      queryParameters: {
        "teacherId": int.parse(teacherId),
        "classId": int.parse(classId),
      },
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );

    print("API RESPONSE = ${response.data}");

    final List data = response.data as List;

    final tasks = data
        .map((e) => TaskModel.fromJson(e))
        .toList();

    print("TASKS COUNT = ${tasks.length}");

    return TeacherTasksResult(
      tasks: tasks,
      lastUpdated: DateTime.now(),
    );
  }
  @override
  Future<void> addTask(TaskModel task) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print("TOKEN (ADD TASK) = $token");
    await dio.post(
      "/api/tasks",
      data: task.toJson(),
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );
  }

  @override
  Future<void> deleteTask(String taskId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print("TOKEN (DELETE TASK) = $token");
    await dio.delete(
      "/api/tasks/$taskId",
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );
  }

 /* @override
  Future<void> updateTaskStatus(String taskId, String status) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print("TOKEN (UPDATE TASK) = $token");
    /*await dio.put(
      "/api/tasks/$taskId",
      data: {
        "id": int.parse(taskId),
        "title": "temp",
        "description": "temp",
        "subject": "math",
        "dueDate": DateTime.now().toIso8601String(),
        "classId": 1,
        "teacherId": 1,
        "state": status,
      },*/
    await dio.put(
      "/api/tasks/$taskId",
      data: {
        "state": status,
      },
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );
  }*/
  @override
  Future<void> updateTaskStatus(String taskId, String status) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) throw Exception("No token");

    await dio.put(
      "/api/tasks/$taskId",
      data: {
        "id": int.parse(taskId),
        "title": "temp",
        "description": "temp",
        "subject": "math",
        "dueDate": DateTime.now().toIso8601String(),
        "classId": 1,
        "teacherId": 1,
        "state": status,
      },
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );
  }
  @override
  Future<double> getTeacherCompletedPercentage(String teacherId) async {
    return 0;
  }

  @override
  Future<List<TaskModel>> getStudentTasks(String studentId) async {
    return [];
  }

  @override
  Future<List<Task>> getParentTasks({required String studentId}) async {
    return [];
  }
}*/
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
      final tasks = (response.data as List)
          .map((e) => TaskModel.fromJson(e))
          .toList();

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
    final getResp = await dio.get("/api/tasks/$taskId");
    final existing = Map<String, dynamic>.from(getResp.data as Map);
    final normalizedState =
        status.toLowerCase() == "completed" ? "Completed" : "Pending";
    final payload = Map<String, dynamic>.from(existing)
      ..remove("subject")
      ..remove("dueDate")
      ..["id"] = int.tryParse(taskId) ?? existing["id"]
      ..["state"] = normalizedState;
    if (!payload.containsKey("deadLine") && existing["dueDate"] != null) {
      payload["deadLine"] = existing["dueDate"];
    }
    await dio.put("/api/tasks/$taskId", data: payload);
  }

  @override
  Future<double> getTeacherCompletedPercentage(String teacherId) async {
    // دي مفيش EndPoint ليها في السيرفر اللي ابعتته، بنرجع 0 مؤقتاً
    return 0.0;
  }

  @override
  Future<List<TaskModel>> getStudentTasks(String studentId) async {
    // مفيش EndPoint
    return [];
  }

  @override
  Future<List<Task>> getParentTasks({required String studentId}) async {
    // مفيش EndPoint
    return [];
  }
}
