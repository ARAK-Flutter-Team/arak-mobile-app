import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arak_app/core/network/dio_provider.dart';
import '../../../../core/utils/logger_utils.dart';
import '../../data/datasources/task_remote_data_source.dart';
import '../../data/datasources/task_remote_data_source_impl.dart';
import '../../data/repositories/task_repository_impl.dart';
import '../../domain/repositories/task_repository.dart';
import '../../domain/usecases/get_teacher_tasks.dart';
import '../../domain/usecases/add_task.dart';
import '../../domain/usecases/delete_task.dart';

final taskRemoteDataSourceProvider = Provider<TaskRemoteDataSource>((ref) {
  final Dio dio = ref.watch(dioProvider);
  return TaskRemoteDataSourceImpl(dio);
});

final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  final remoteDataSource = ref.watch(taskRemoteDataSourceProvider);
  return TaskRepositoryImpl(remoteDataSource);
});

final getTeacherTasksProvider = Provider<GetTeacherTasks>((ref) {
  return GetTeacherTasks(ref.watch(taskRepositoryProvider));
});

final addTaskProvider = Provider<AddTask>((ref) {
  return AddTask(ref.watch(taskRepositoryProvider));
});

final deleteTaskProvider = Provider<DeleteTask>((ref) {
  return DeleteTask(ref.watch(taskRepositoryProvider));
});

final teacherClassesProvider = FutureProvider<List<String>>((ref) async {
  final dio = ref.watch(dioProvider);
  try {
    AppLogger.logInfo('🟡 Fetching classes from API...');
    final response = await dio.get("/api/Classes");
    AppLogger.logInfo('🟡 Classes response status: ${response.statusCode}');

    if (response.statusCode == 200 && response.data is List) {
      final classes = (response.data as List)
          .map<String>((classObj) {
        if (classObj is Map && classObj.containsKey('id')) {
          final id = classObj['id'].toString();
          AppLogger.logInfo('🟡 Found class ID: $id');
          return id;
        }
        return '';
      })
          .where((id) => id.isNotEmpty)
          .toList();

      AppLogger.logSuccess('Total classes fetched: ${classes.length}');
      AppLogger.logInfo('Classes list: $classes');
      return classes;
    }
    AppLogger.logWarning('No classes found in response');
    return [];
  } catch (e) {
    AppLogger.logError('Error fetching classes: $e');
    return [];
  }
});