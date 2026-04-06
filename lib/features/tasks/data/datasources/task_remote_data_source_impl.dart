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
}*/
import 'package:arak_app/features/tasks/data/datasources/task_remote_data_source.dart';
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
          assignedTo: task.assignedTo,
          isDeleted: true,
        );
      }
    }
  }
}
