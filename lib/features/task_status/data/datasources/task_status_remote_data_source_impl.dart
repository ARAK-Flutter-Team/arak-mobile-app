/*import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/task_status_entity.dart';
import 'task_status_remote_data_source.dart';

class TaskStatusRemoteDataSourceImpl
    implements TaskStatusRemoteDataSource {

  static const String _key = "task_status";

  ///  تحميل الداتا من SharedPreferences
  Future<Map<String, List<TaskStatusEntity>>> _loadData() async {
    final prefs = await SharedPreferences.getInstance();

    final jsonString = prefs.getString(_key);

    if (jsonString == null) return {};

    final decoded = json.decode(jsonString) as Map<String, dynamic>;

    return decoded.map((taskId, list) {
      final students = (list as List)
          .map((e) => TaskStatusEntity.fromJson(e))
          .toList();

      return MapEntry(taskId, students);
    });
  }

  /// 🔹 حفظ الداتا
  Future<void> _saveData(
      Map<String, List<TaskStatusEntity>> data) async {

    final prefs = await SharedPreferences.getInstance();

    final encoded = data.map((taskId, list) {
      return MapEntry(
        taskId,
        list.map((e) => e.toJson()).toList(),
      );
    });

    await prefs.setString(_key, json.encode(encoded));
  }

  @override
  Future<List<TaskStatusEntity>> getTaskStatuses(String taskId) async {
    final data = await _loadData();

    /// لو مش موجودة → نعمل mock أول مرة
    if (!data.containsKey(taskId)) {
      data[taskId] = [
        TaskStatusEntity(
          taskId: taskId,
          studentId: "1",
          studentName: "Ahmed",
          isDone: false,
        ),
        TaskStatusEntity(
          taskId: taskId,
          studentId: "2",
          studentName: "Sara",
          isDone: true,
        ),
        TaskStatusEntity(
          taskId: taskId,
          studentId: "3",
          studentName: "Ali",
          isDone: false,
        ),
      ];

      await _saveData(data); // 🔥 مهم
    }

    return data[taskId]!;
  }

  @override
  Future<void> updateStatus({
    required String taskId,
    required String studentId,
    required bool isDone,
  }) async {

    final data = await _loadData();

    final list = data[taskId];
    if (list == null) return;

    final index = list.indexWhere((e) => e.studentId == studentId);

    if (index != -1) {
      list[index] = TaskStatusEntity(
        taskId: taskId,
        studentId: studentId,
        studentName: list[index].studentName,
        isDone: isDone,
      );
    }

    data[taskId] = list;

    await _saveData(data);
  }
}*/