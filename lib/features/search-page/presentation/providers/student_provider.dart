import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/student_remote_data_source.dart';
import '../../data/repositories/student_repository_impl.dart';
import '../../domain/entities/student.dart';
import '../../domain/repositories/student_repository.dart';

// 1. Provider للـ DataSource
final studentRemoteDataSourceProvider =
    Provider<StudentRemoteDataSource>((ref) {
  return StudentRemoteDataSourceImpl();
});

// 2. Provider للـ Repository
final studentRepositoryProvider = Provider<StudentRepository>((ref) {
  return StudentRepositoryImpl(
      remoteDataSource: ref.watch(studentRemoteDataSourceProvider));
});

// 3. Notifier للتحكم في البيانات (State Management)
class StudentListNotifier extends AsyncNotifier<List<Student>> {
  @override
  Future<List<Student>> build() async {
    // بتجيب الداتا أول ما يشتغل
    return _fetchStudents();
  }

  Future<List<Student>> _fetchStudents() async {
    final repo = ref.read(studentRepositoryProvider);
    return await repo.getStudents();
  }

  // فانكشن للـ Refresh
  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchStudents());
  }
}

// 4. Provider للـ Notifier
final studentListProvider =
    AsyncNotifierProvider<StudentListNotifier, List<Student>>(() {
  return StudentListNotifier();
});

// 5. Provider للبحث (Filter)
final searchQueryProvider = StateProvider<String>((ref) => '');

// 6. Provider لتطبيق الفلترة (Combining Data + Query)
final filteredStudentsProvider = Provider<List<Student>>((ref) {
  final query = ref.watch(searchQueryProvider);
  final studentsAsync = ref.watch(studentListProvider);

  return studentsAsync.when(
    data: (students) {
      if (query.isEmpty) return students;
      return students
          .where((s) => s.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    },
    loading: () => [],
    error: (_, __) => [],
  );
});
