import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/search_result.dart';
import '../../data/services/global_search_service.dart';

import '../../../../shared/domain/entities/student.dart';
import '../../../tasks/domain/entities/task.dart';


/// 🔎 search text
final searchQueryProvider = StateProvider<String>((ref) {
  return "";
});


/// 👨‍🎓 mock students
final studentsProvider = Provider<List<Student>>((ref) {

  return [

    Student(
      id: "1",
      name: "Ahmed Ali",
      avatarUrl: null,
    ),

    Student(
      id: "2",
      name: "Sara Mohamed",
      avatarUrl: null,
    ),

    Student(
      id: "3",
      name: "Mohamed Hassan",
      avatarUrl: null,
    ),

  ];

});


/// 📚 mock tasks
final tasksProvider = Provider<List<Task>>((ref) {
  return [

    Task(
      id: "1",
      title: "Math Homework",
      subject: "Math",
      status: TaskStatus.pending,
      dueDate: DateTime.now().add(const Duration(days: 2)),
      description: "Solve exercises 1 to 10",
      assignedTo: "1",
    ),

    Task(
      id: "2",
      title: "Science Project",
      subject: "Science",
      status: TaskStatus.pending,
      dueDate: DateTime.now().add(const Duration(days: 4)),
      description: "Prepare volcano model",
      assignedTo: "2",
    ),

    Task(
      id: "3",
      title: "English Essay",
      subject: "English",
      status: TaskStatus.completed,
      dueDate: DateTime.now().add(const Duration(days: 1)),
      description: "Write essay about environment",
      assignedTo: "3",
    ),

  ];
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