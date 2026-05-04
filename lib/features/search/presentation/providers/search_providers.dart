import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/search_result.dart';
import '../../data/services/global_search_service.dart';

import '../../../../shared/domain/entities/student.dart';
import '../../../tasks/domain/entities/task.dart';


/// 🔎 search text
final searchQueryProvider = StateProvider<String>((ref) {
  return "";
});


final studentsProvider = Provider<List<Student>>((ref) {
  return [];
});

/// 📚 mock tasks removed
final tasksProvider = Provider<List<Task>>((ref) {
  return [];
});


/// 🔎 search results
final searchResultsProvider =
FutureProvider<List<SearchResult>>((ref) async {

  final query = ref.watch(searchQueryProvider);

  /// لو مفيش كتابة
  if (query.trim().isEmpty) {
    return [];
  }

  final students = ref.watch(studentsProvider);
  final tasks = ref.watch(tasksProvider);

  final service = GlobalSearchService();

  final results = await service.search(
    query: query,
    students: students,
    tasks: tasks,
  );

  return results;
});