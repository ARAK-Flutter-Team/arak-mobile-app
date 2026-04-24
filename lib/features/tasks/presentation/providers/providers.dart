import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
// استيراد Dio من الكور
import 'package:arak_app/core/network/dio_provider.dart';
// استيراد طبقة الـ Data
import 'package:arak_app/features/tasks/data/datasources/task_remote_data_source_impl.dart';
import 'package:arak_app/features/tasks/data/repositories/task_repository_impl.dart';
// استيراد طبقة الـ Domain
import 'package:arak_app/features/tasks/domain/repositories/task_repository.dart';
import 'package:arak_app/features/tasks/domain/usecases/get_teacher_tasks.dart';
import 'package:arak_app/features/tasks/domain/usecases/get_teacher_stats.dart';
import 'package:arak_app/features/tasks/domain/usecases/add_task.dart';
import 'package:arak_app/features/tasks/domain/usecases/delete_task.dart';

import '../../data/datasources/task_remote_data_source.dart';

/// ==========================================
/// 1. Data Layer Providers
/// ==========================================

/// Provider للـ Data Source (اللي بيحمل Dio من الكور)
final taskRemoteDataSourceProvider = Provider<TaskRemoteDataSource>((ref) {
  final Dio dio = ref.watch(dioProvider);
  return TaskRemoteDataSourceImpl(dio);
});

/// Provider للـ Repository (اللي بيحمل Data Source)
final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  final remoteDataSource = ref.watch(taskRemoteDataSourceProvider);
  return TaskRepositoryImpl(remoteDataSource);
});

/// ==========================================
/// 2. Domain Layer Providers (Use Cases)
/// ==========================================

final getTeacherTasksProvider = Provider<GetTeacherTasks>((ref) {
  return GetTeacherTasks(ref.watch(taskRepositoryProvider));
});

final getTeacherStatsProvider = Provider<GetTeacherStats>((ref) {
  return GetTeacherStats(ref.watch(taskRepositoryProvider));
});

final addTaskProvider = Provider<AddTask>((ref) {
  return AddTask(ref.watch(taskRepositoryProvider));
});

final deleteTaskProvider = Provider<DeleteTask>((ref) {
  return DeleteTask(ref.watch(taskRepositoryProvider));
});

/// ==========================================
/// 3. API Specific Providers (Data Calls)
/// ==========================================

/// Provider لجلب الكلاسات (Classes) الخاصة بالمدرس
/// نفترض إن الباك بيرجع ليست فيها id و name، وهنا بنرجع id كـ String عشان الدروب داون
final teacherClassesProvider = FutureProvider.family<List<String>, String>((ref, teacherId) async {
  final dio = ref.watch(dioProvider);

  try {
    // جلب الكلاسات (يفترض EndPoint موجود /api/Classes)
    final response = await dio.get("/api/Classes");

    if (response.statusCode == 200 && response.data is List) {
      // بنأخذ الـ ID ونحوله لـ String عشان نبعته للباك في إنشاء التاسك
      return (response.data as List)
          .map<String>((classObj) => classObj['id'].toString())
          .toList();
    }
    return [];
  } catch (e) {
    print("Error fetching classes: $e");
    return [];
  }
});

/// Provider لجلب المواد (Subjects) من الباك إند
/// بناءً على الـ Swagger: GET /api/Subjects
final subjectsProvider = FutureProvider.autoDispose<List<String>>((ref) async {
  final dio = ref.watch(dioProvider);

  try {
    final response = await dio.get("/api/Subjects");

    // التحقق من الـ Response
    if (response.statusCode == 200 && response.data is List) {
      // السيرفر بيرجع ليست من أوبجكتس: [ {id: 1, name: "Math"}, ... ]
      return (response.data as List)
          .map<String>((subjectObj) => subjectObj['name'].toString()) // نجيب حقل الاسم بس
          .toList();
    }

    return [];
  } catch (e) {
    print("Error fetching subjects: $e");
    return []; // نرجع ليست فاضية لو حصلت مشكلة
  }
});