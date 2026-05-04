import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arak_app/core/network/dio_provider.dart';
import 'package:arak_app/features/tasks/presentation/providers/teacher_tasks_notifier.dart';
import 'package:arak_app/features/tasks/domain/entities/task.dart';
import 'package:arak_app/features/search-page/domain/entities/student.dart';
import 'package:arak_app/features/search/domain/entities/search_result.dart';
import 'package:arak_app/features/search/data/services/global_search_service.dart';

/// 1. Service Provider
final globalSearchServiceProvider = Provider<GlobalSearchService>((ref) {
  final dio = ref.watch(dioProvider);
  return GlobalSearchService(dio);
});

/// 2. Search Text
final searchQueryProvider = StateProvider<String>((ref) => "");

/// 3. Students Provider (Fetching real data from API)
final studentsProvider = FutureProvider<List<Student>>((ref) async {
  final dio = ref.watch(dioProvider);
  try {
    // Fetching students for the teacher
    final response = await dio.get('/students');
    
    // Fix: Correctly extracting the 'data' field from the response wrapper
    final rawData = response.data;
    final List<dynamic> studentList = (rawData is Map) 
        ? (rawData['data'] as List? ?? []) 
        : (rawData is List ? rawData : []);

    print('Fetched ${studentList.length} students from API');

    return studentList.map((s) {
      // ✅ استخرج الـ UUID الحقيقي — جرب userId ثم parentId ثم id
      final id = s['userId']?.toString() ??
                 s['parentId']?.toString() ??
                 s['id']?.toString() ??
                 '';
      return Student(
        id: id,
        name: s['name'] ?? s['Name'] ?? 'No Name',
        grade: s['grade']?.toString() ?? '',
        status: s['status'] ?? "Active",
        date: DateTime.now().toString().split(' ')[0],
        checkIn: "--:--",
        checkOut: "--:--",
        attendanceRate: 0.0,
      );
    }).toList();
  } catch (e) {
    print('Error fetching students: $e');
  }
  return [];
});

/// 4. Tasks Provider (Watching real teacher tasks)
final tasksProvider = Provider<List<Task>>((ref) {
  final tasksState = ref.watch(teacherTasksNotifierProvider);
  return tasksState.tasks;
});

/// 5. Global Search Results Provider
final searchResultsProvider = FutureProvider<List<SearchResult>>((ref) async {
  final query = ref.watch(searchQueryProvider);
  if (query.trim().isEmpty) return [];

  final students = ref.watch(studentsProvider).value ?? [];
  final tasks = ref.watch(tasksProvider);

  final service = ref.watch(globalSearchServiceProvider);
  return await service.search(
    query: query,
    students: students,
    tasks: tasks,
  );
});