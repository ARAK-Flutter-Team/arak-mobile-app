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
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/task.dart';
import '../../domain/entities/teacher_tasks_result.dart';
import '../models/task_model.dart';
import 'task_remote_data_source.dart';

class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  final Dio dio;

  TaskRemoteDataSourceImpl(this.dio);

  final String baseUrl = "http://192.168.1.9:5000/api/Tasks";

  /// ============================
  /// GET TOKEN
  /// ============================
  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  /// ============================
  /// GET Teacher Tasks
  /// ============================
  @override
  Future<TeacherTasksResult> getTeacherTasks({
    required String teacherId,
    required String classId,
  }) async {
    final token = await _getToken();

    print(" GET TASKS");
    print("TOKEN: $token");

    final response = await dio.get(
      baseUrl,
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

    print(" RESPONSE: ${response.data}");

    final data = response.data as List;

    final tasks = data.map((e) => TaskModel.fromJson(e)).toList();

    return TeacherTasksResult(
      tasks: tasks,
      lastUpdated: DateTime.now(),
    );
  }

  /// ============================
  /// ADD Task
  /// ============================
  @override
  Future<void> addTask(TaskModel task) async {
    final token = await _getToken();

    print(" ADD TASK");
    print(task.toJson());

    final response = await dio.post(
      baseUrl,
      data: task.toJson(),
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );

    print(" ADD RESPONSE: ${response.data}");
  }

  /// ============================
  /// DELETE Task
  /// ============================
  @override
  Future<void> deleteTask(String taskId) async {
    final token = await _getToken();

    await dio.delete(
      "$baseUrl/$taskId",
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );
  }

  /// ============================
  /// UPDATE STATUS
  /// ============================
  @override
  Future<void> updateTaskStatus(String taskId, String status) async {
    final token = await _getToken();

    await dio.put(
      "$baseUrl/$taskId",
      data: {
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
}