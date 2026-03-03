/*import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/task_remote_data_source_impl.dart'; // MOCK NOW
import '../../data/datasources/task_local_data_source_impl.dart';
import '../../data/repositories/task_repository_impl.dart';
import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../../domain/usecases/get_teacher_tasks.dart';
import '../../domain/usecases/get_teacher_stats.dart';


// =====================================================
// --------------------- STATE -------------------------
// =====================================================

class TeacherTasksState {
  final List<Task> tasks;
  final double completedPercentage;
  final bool isLoading;
  final String selectedClass;
  final String? error;
  final DateTime? lastUpdated;

  const TeacherTasksState({
    required this.tasks,
    required this.completedPercentage,
    required this.isLoading,
    required this.selectedClass,
    this.error,
    this.lastUpdated,
  });

  factory TeacherTasksState.initial() {
    return const TeacherTasksState(
      tasks: [],
      completedPercentage: 0,
      isLoading: false,
      selectedClass: '',
      error: null,
      lastUpdated: null,
    );
  }

  TeacherTasksState copyWith({
    List<Task>? tasks,
    double? completedPercentage,
    bool? isLoading,
    String? selectedClass,
    Object? error = _sentinel,
    DateTime? lastUpdated,
  }) {
    return TeacherTasksState(
      tasks: tasks ?? this.tasks,
      completedPercentage:
      completedPercentage ?? this.completedPercentage,
      isLoading: isLoading ?? this.isLoading,
      selectedClass: selectedClass ?? this.selectedClass,
      error: identical(error, _sentinel)
          ? this.error
          : error as String?,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  static const _sentinel = Object();
}


// =====================================================
// -------------------- NOTIFIER -----------------------
// =====================================================

class TeacherTasksNotifier
    extends StateNotifier<TeacherTasksState> {

  final GetTeacherTasks getTeacherTasks;
  final GetTeacherStats getTeacherStats;

  TeacherTasksNotifier({
    required this.getTeacherTasks,
    required this.getTeacherStats,
  }) : super(TeacherTasksState.initial());

  Future<void> fetchTasks({
    required String teacherId,
    required String classId,
  }) async {

    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await getTeacherTasks(
        teacherId: teacherId,
        classId: classId,
      );

      final percentage =
      await getTeacherStats(teacherId);

      state = state.copyWith(
        tasks: result.tasks,
        completedPercentage: percentage,
        isLoading: false,
        lastUpdated: result.lastUpdated, // ✅ من السيرفر
      );

    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> changeClass({
    required String teacherId,
    required String newClassId,
  }) async {
    state = state.copyWith(selectedClass: newClassId);

    await fetchTasks(
      teacherId: teacherId,
      classId: newClassId,
    );
  }
}

// =====================================================
// -------------------- PROVIDERS ----------------------
// =====================================================


/// 🔹 Remote
final taskRemoteDataSourceProvider =
Provider((ref) => TaskRemoteDataSourceImpl());


/// 🔹 Local
final taskLocalDataSourceProvider =
Provider((ref) => TaskLocalDataSourceImpl());


/// 🔹 Repository
final taskRepositoryProvider =
Provider<TaskRepository>((ref) {
  return TaskRepositoryImpl(
    ref.watch(taskRemoteDataSourceProvider),
    ref.watch(taskLocalDataSourceProvider),
  );
});


/// 🔹 UseCases
final getTeacherTasksProvider =
Provider((ref) => GetTeacherTasks(
  ref.watch(taskRepositoryProvider),
));

final getTeacherStatsProvider =
Provider((ref) => GetTeacherStats(
  ref.watch(taskRepositoryProvider),
));


/// 🔹 StateNotifier Provider
final teacherTasksNotifierProvider =
StateNotifierProvider<
    TeacherTasksNotifier,
    TeacherTasksState>((ref) {

  return TeacherTasksNotifier(
    getTeacherTasks:
    ref.watch(getTeacherTasksProvider),
    getTeacherStats:
    ref.watch(getTeacherStatsProvider),
  );
});*/
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/task_remote_data_source_impl.dart'; // MOCK NOW
import '../../data/datasources/task_local_data_source_impl.dart';
import '../../data/repositories/task_repository_impl.dart';
import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../../domain/usecases/get_teacher_tasks.dart';
import '../../domain/usecases/get_teacher_stats.dart';

// =====================================================
// --------------------- STATE -------------------------
// =====================================================

class TeacherTasksState {
  final List<Task> tasks;
  final double completedPercentage;
  final bool isLoading;
  final String selectedClass;
  final String? error;
  final DateTime? lastUpdated;

  const TeacherTasksState({
    required this.tasks,
    required this.completedPercentage,
    required this.isLoading,
    required this.selectedClass,
    this.error,
    this.lastUpdated,
  });

  factory TeacherTasksState.initial() {
    return const TeacherTasksState(
      tasks: [],
      completedPercentage: 0,
      isLoading: false,
      selectedClass: '',
      error: null,
      lastUpdated: null,
    );
  }

  TeacherTasksState copyWith({
    List<Task>? tasks,
    double? completedPercentage,
    bool? isLoading,
    String? selectedClass,
    Object? error = _sentinel,
    DateTime? lastUpdated,
  }) {
    return TeacherTasksState(
      tasks: tasks ?? this.tasks,
      completedPercentage: completedPercentage ?? this.completedPercentage,
      isLoading: isLoading ?? this.isLoading,
      selectedClass: selectedClass ?? this.selectedClass,
      error: identical(error, _sentinel) ? this.error : error as String?,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  static const _sentinel = Object();
}

// =====================================================
// -------------------- NOTIFIER -----------------------
// =====================================================

class TeacherTasksNotifier extends StateNotifier<TeacherTasksState> {
  final GetTeacherTasks getTeacherTasks;
  final GetTeacherStats getTeacherStats;

  TeacherTasksNotifier({
    required this.getTeacherTasks,
    required this.getTeacherStats,
  }) : super(TeacherTasksState.initial());

  /// ==============================
  /// Fetch tasks for a class
  /// ==============================
  Future<void> fetchTasks({
    required String teacherId,
    required String classId,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      /// 🔹 لو السيرفر جاهز استخدمي الـ API هنا
      final result = await getTeacherTasks(
        teacherId: teacherId,
        classId: classId,
      );

      final percentage = await getTeacherStats(teacherId);

      state = state.copyWith(
        tasks: result.tasks,
        completedPercentage: percentage,
        isLoading: false,
        lastUpdated: result.lastUpdated, // ✅ من السيرفر
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: "Failed to fetch tasks: ${e.toString()}",
      );
    }
  }

  /// ==============================
  /// Change class & reload tasks
  /// ==============================
  Future<void> changeClass({
    required String teacherId,
    required String newClassId,
  }) async {
    state = state.copyWith(selectedClass: newClassId);

    await fetchTasks(
      teacherId: teacherId,
      classId: newClassId,
    );
  }
}

// =====================================================
// -------------------- PROVIDERS ----------------------
// =====================================================

/// 🔹 Remote data source
final taskRemoteDataSourceProvider = Provider((ref) => TaskRemoteDataSourceImpl());

/// 🔹 Local data source
final taskLocalDataSourceProvider = Provider((ref) => TaskLocalDataSourceImpl());

/// 🔹 Repository
final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  return TaskRepositoryImpl(
    ref.watch(taskRemoteDataSourceProvider),
    ref.watch(taskLocalDataSourceProvider),
  );
});

/// 🔹 UseCases
final getTeacherTasksProvider = Provider((ref) => GetTeacherTasks(
  ref.watch(taskRepositoryProvider),
));

final getTeacherStatsProvider = Provider((ref) => GetTeacherStats(
  ref.watch(taskRepositoryProvider),
));

/// 🔹 StateNotifier Provider
final teacherTasksNotifierProvider =
StateNotifierProvider<TeacherTasksNotifier, TeacherTasksState>((ref) {
  return TeacherTasksNotifier(
    getTeacherTasks: ref.watch(getTeacherTasksProvider),
    getTeacherStats: ref.watch(getTeacherStatsProvider),
  );
});