import '../../../../shared/domain/entities/student.dart';
import '../../../tasks/domain/entities/task.dart';
import '../../domain/entities/search_result.dart';

class GlobalSearchService {

  Future<List<SearchResult>> search({
    required String query,
    required List<Student> students,
    required List<Task> tasks,
  }) async {

    /// لو مفيش نص في السيرش
    if (query.isEmpty) return [];

    final q = query.toLowerCase();

    final List<SearchResult> results = [];

    /// 🔎 Search students
    for (final student in students) {

      if (student.name.toLowerCase().contains(q)) {

        results.add(
          SearchResult(
            id: student.id,
            title: student.name,
            subtitle: "Student",
            type: SearchType.student,
            route: "/student/${student.id}",
          ),
        );

      }

    }

    /// 🔎 Search tasks
    for (final task in tasks) {

      if (task.title.toLowerCase().contains(q)) {

        results.add(
          SearchResult(
            id: task.id,
            title: task.title,
            subtitle: "Task",
            type: SearchType.task,
            route: "/task/${task.id}",
          ),
        );

      }

    }

    return results;
  }
}