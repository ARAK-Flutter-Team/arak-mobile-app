import 'package:dio/dio.dart';
import 'package:arak_app/features/search/domain/entities/search_result.dart';
import 'package:arak_app/features/search/data/models/search_result_model.dart';
import 'package:arak_app/features/tasks/domain/entities/task.dart';
import 'package:arak_app/features/search-page/domain/entities/student.dart';

class GlobalSearchService {
  final Dio dio;

  GlobalSearchService(this.dio);

  Future<List<SearchResult>> search({
    required String query,
    required List<Student> students,
    required List<Task> tasks,
  }) async {
    final List<SearchResult> results = [];
    final lowerQuery = query.toLowerCase();

    // 1. Filter Students
    for (final student in students) {
      if (student.name.toLowerCase().contains(lowerQuery)) {
        results.add(SearchResultModel(
          id: student.id, // ✅ UUID الحقيقي
          title: student.name,
          subtitle: "Student",
          type: SearchType.student,
          route: "/teacher/student-details",
          extra: student,
        ));
      }
    }

    // 2. Filter Tasks
    for (final task in tasks) {
      if (task.title.toLowerCase().contains(lowerQuery)) {
        results.add(SearchResultModel(
          id: task.id,
          title: task.title,
          subtitle: "Task",
          type: SearchType.task,
          route: "/teacher/task-status",
          extra: task,
        ));
      }
    }

    return results;
  }
}
