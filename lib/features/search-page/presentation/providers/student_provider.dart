import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arak_app/features/parent_home/presentation/providers/parent_home_provider.dart';
import 'package:arak_app/features/parent_home/domain/entities/student_entity.dart';
import '../../domain/entities/student.dart';


// 3. Notifier للتحكم في البيانات (State Management)
class StudentListNotifier extends AsyncNotifier<List<Student>> {
  @override
  Future<List<Student>> build() async {
    final parentHomeAsync = ref.watch(parentHomeProvider);

    return parentHomeAsync.when(
      data: (homeData) {
        return homeData.students.map((StudentEntity s) {
          return Student(
            id: s.id,                          // ✅ UUID من StudentEntity
            name: s.name,
            grade: s.grade.toString(),
            status: "Present",
            date: DateTime.now().toString().split(' ')[0],
            checkIn: "--:--",
            checkOut: "--:--",
            attendanceRate: 0.0,
          );
        }).toList();
      },
      loading: () => [],
      error: (_, __) => [],
    );
  }

  Future<void> refresh() async {
    ref.invalidate(parentHomeProvider);
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
  final query = ref.watch(searchQueryProvider).toLowerCase();
  final studentsAsync = ref.watch(studentListProvider);

  return studentsAsync.when(
    data: (students) {
      if (query.isEmpty) return students;
      return students.where((s) {
        return s.name.toLowerCase().contains(query);
      }).toList();
    },
    loading: () => [],
    error: (_, __) => [],
  );
});
