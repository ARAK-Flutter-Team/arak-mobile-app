/*import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

import '../../data/datasources/task_remote_data_source_impl.dart';
import '../../data/repositories/task_repository_impl.dart';
import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../../domain/usecases/get_teacher_tasks.dart';
import '../../domain/usecases/get_teacher_stats.dart';

/// ===============================
/// Providers for DataSources
/// ===============================
/*final taskRemoteDataSourceProvider =
Provider((ref) => TaskRemoteDataSourceImpl());*/
/*final dioProvider = Provider((ref) {
  return Dio(
    BaseOptions(
      baseUrl: "http://192.168.1.9:5000",//   اللينك بتاع الباك
      headers: {
        "Content-Type": "application/json",
      },
    ),
  );
});

final taskRemoteDataSourceProvider =
Provider((ref) => TaskRemoteDataSourceImpl(ref.watch(dioProvider)));
final taskLocalDataSourceProvider =
Provider((ref) => TaskLocalDataSourceImpl());*/
final dioProvider = Provider((ref) {
  return Dio(
    BaseOptions(
      baseUrl: "http://192.168.1.9:5000",
      headers: {
        "Content-Type": "application/json",
      },
    ),
  );
});

final taskRemoteDataSourceProvider =
Provider((ref) => TaskRemoteDataSourceImpl(ref.watch(dioProvider)));

/*final taskLocalDataSourceProvider =
Provider((ref) => TaskLocalDataSourceImpl());*/
/// ===============================
/// Provider for Repository
/// ===============================
final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  return TaskRepositoryImpl(
    ref.watch(taskRemoteDataSourceProvider),
    //ref.watch(taskLocalDataSourceProvider),
  );
});

/// ===============================
/// UseCases
/// ===============================
final getTeacherTasksProvider =
Provider((ref) => GetTeacherTasks(ref.watch(taskRepositoryProvider)));

final getTeacherStatsProvider =
Provider((ref) => GetTeacherStats(ref.watch(taskRepositoryProvider)));

/// ===============================
/// State
/// ===============================
class TeacherTasksState {
  final List<Task> allTasks;
  final List<Task> tasks;
  final bool isLoading;
  final String selectedClass;
  final String? error;
  final DateTime? lastUpdated;
  final String teacherId;
  const TeacherTasksState({
    required this.allTasks,
    required this.tasks,
    required this.isLoading,
    required this.selectedClass,
    this.error,
    this.lastUpdated,
    required this.teacherId,
  });

  factory TeacherTasksState.initial() => const TeacherTasksState(
    allTasks: [],
    tasks: [],
    isLoading: true,
    selectedClass: '',
    error: null,
    lastUpdated: null,
    teacherId: '',
  );

TeacherTasksState copyWith({
  List<Task>? allTasks,
  List<Task>? tasks,
  bool? isLoading,
  String? selectedClass,
  String? error,
  DateTime? lastUpdated,
  String? teacherId,
}) {
  return TeacherTasksState(
    allTasks: allTasks ?? this.allTasks,
    tasks: tasks ?? this.tasks,
    isLoading: isLoading ?? this.isLoading,
    selectedClass: selectedClass ?? this.selectedClass,
    error: error ?? this.error,
    lastUpdated: lastUpdated ?? this.lastUpdated,
    teacherId: teacherId ?? this.teacherId, 
  );
}
}

/// ===============================
/// Notifier
/// ===============================
class TeacherTasksNotifier extends StateNotifier<TeacherTasksState> {
  final GetTeacherTasks getTeacherTasks;
  final GetTeacherStats getTeacherStats;
  final Ref ref;

  TeacherTasksNotifier({
    required this.getTeacherTasks,
    required this.getTeacherStats,
    required this.ref,
  }) : super(TeacherTasksState.initial()) {
 //   _init();
  }

  /// ===============================
  /// Save locally
  /// ===============================
  /*Future<void> saveTasksLocally(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();

    final encoded = tasks.map((task) {
      final model = task is TaskModel
          ? task
          : TaskModel(
        id: task.id,
        title: task.title,
        description: task.description,
        subject: task.subject,
        dueDate: task.dueDate,
        status: task.status,
        imageUrl: task.imageUrl,
        assignedTo: task.assignedTo,
        teacherName: task.teacherName,
        teacherFeedback: task.teacherFeedback,
        progress: task.progress,
        isDeleted: task.isDeleted,
      );

      return jsonEncode(model.toJson());
    }).toList();

    await prefs.setStringList("teacher_tasks", encoded);
  }*/

  /// ===============================
  /// Load from local
  /// ===============================
  /*Future<void> loadSavedTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTasks = prefs.getStringList("teacher_tasks");

    if (savedTasks == null) {
      state = state.copyWith(isLoading: false);
      return;
    }

    final tasks = savedTasks.map<Task>((taskString) {
      final json = jsonDecode(taskString);
      return TaskModel.fromJson(json);
    }).toList();

    final filteredTasks = state.selectedClass.isEmpty
        ? <Task>[]
        : tasks
        .where((t) =>
    t.assignedTo == state.selectedClass && !t.isDeleted)
        .toList();

    state = state.copyWith(
      allTasks: tasks,
      tasks: filteredTasks,
      isLoading: false,
    );
  }*/

  /// ===============================
  /// Fetch tasks
  /// ===============================
  /*Future<void> fetchTasks({
    required String teacherId,
    required String classId,
  }) async {
    state = state.copyWith(isLoading: true);

    final filteredTasks = state.allTasks
        .where((task) =>
    task.assignedTo == classId && !task.isDeleted)
        .toList();

    state = state.copyWith(
      tasks: filteredTasks,
      selectedClass: classId,
      isLoading: false,
    );
  }*/
  /*Future<void> fetchTasks({
    required String teacherId,
    required String classId,
  }) async {
    state = state.copyWith(isLoading: true, teacherId: '');

    try {
      print("CALL API with teacherId: $teacherId , classId: $classId");
      final result = await getTeacherTasks(
        teacherId: teacherId,
        classId: classId,
      );

      final tasks = result.tasks
          .where((t) => !t.isDeleted)
          .toList();
      print("TASKS COUNT = ${tasks.length}");
      state = state.copyWith(
        allTasks: tasks,
        tasks: tasks,
        selectedClass: classId,
        isLoading: false,
        lastUpdated: result.lastUpdated,
        teacherId: teacherId,
      );

      //await saveTasksLocally(tasks);

    } catch (e) {
     state = state.copyWith(isLoading: true, teacherId: teacherId);
    }
  }*/
  Future<void> fetchTasks({
    required String teacherId,
    required String classId,
  }) async {

    state = state.copyWith(isLoading: true);

    try {
      print("CALL API with teacherId: $teacherId , classId: $classId");

      final result = await getTeacherTasks(
        teacherId: teacherId,
        classId: classId,
      );

      final tasks = result.tasks
          .where((t) => !t.isDeleted)
          .toList();

      print("TASKS COUNT = ${tasks.length}");

      state = state.copyWith(
        allTasks: tasks,
        tasks: tasks,
        selectedClass: classId,
        isLoading: false,
        lastUpdated: result.lastUpdated,
        teacherId: teacherId,
      );

    } catch (e) {
      print("FETCH ERROR = $e");

      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
        teacherId: teacherId,
      );
    }
  }
  /// ===============================
  /// Change class
  /// ===============================
  /*Future<void> changeClass({
    required String teacherId,
    required String newClassId,
  }) async {
    state = state.copyWith(selectedClass: newClassId);

    await fetchTasks(
      teacherId: teacherId,
      classId: newClassId,
    );
  }*/
  Future<void> changeClass({
    required String teacherId,
    required String newClassId,
  }) async {
    await fetchTasks(
      teacherId: teacherId,
      classId: newClassId,
    );
  }
  /// ===============================
  /// Add task
  /// ===============================
  /*Future<void> addTask(Task task) async {
    final updatedAllTasks = [...state.allTasks, task];

    final filteredTasks = updatedAllTasks
        .where((t) =>
    t.assignedTo == state.selectedClass && !t.isDeleted)
        .toList();

    state = state.copyWith(
      allTasks: updatedAllTasks,
      tasks: filteredTasks,
    );

   // await saveTasksLocally(updatedAllTasks);
  }*/

  /*Future<void> _init() async {
    await loadSavedTasks();
  }*/

  /// ===============================
  /// Delete task (Soft Delete)
  /// ===============================
  /*Future<void> deleteTask(String taskId) async {
    final updatedAllTasks = state.allTasks.map((task) {
      if (task.id == taskId) {
        return TaskModel(
          id: task.id,
          title: task.title,
          description: task.description,
          subject: task.subject,
          dueDate: task.dueDate,
          status: task.status,
          imageUrl: task.imageUrl,
          assignedTo: task.assignedTo,
          teacherName: task.teacherName,
          teacherFeedback: task.teacherFeedback,
          progress: task.progress,
          isDeleted: true,
        );
      }

      return task is TaskModel
          ? task
          : TaskModel(
        id: task.id,
        title: task.title,
        description: task.description,
        subject: task.subject,
        dueDate: task.dueDate,
        status: task.status,
        imageUrl: task.imageUrl,
        assignedTo: task.assignedTo,
        teacherName: task.teacherName,
        teacherFeedback: task.teacherFeedback,
        progress: task.progress,
        isDeleted: task.isDeleted,
      );
    }).toList();

    final filteredTasks = updatedAllTasks
        .where((t) =>
    t.assignedTo == state.selectedClass && !t.isDeleted)
        .toList();

    state = state.copyWith(
      allTasks: updatedAllTasks,
      tasks: filteredTasks,
    );

    //await saveTasksLocally(updatedAllTasks);
  }*/
  Future<void> deleteTask(String taskId) async {
    try {
      await ref.read(taskRepositoryProvider).deleteTask(taskId);

      await fetchTasks(
        teacherId: state.teacherId,
        classId: state.selectedClass,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString(), teacherId: '');
    }
  }
}

/// ===============================
/// Provider
/// ===============================
final teacherTasksNotifierProvider =
StateNotifierProvider<TeacherTasksNotifier, TeacherTasksState>((ref) {
  return TeacherTasksNotifier(
    getTeacherTasks: ref.watch(getTeacherTasksProvider),
    getTeacherStats: ref.watch(getTeacherStatsProvider),
    ref: ref,
  );
});*/
// ... imports ...
// تأكدي من استدعاء taskRepositoryProvider من الـ providers.dart اللي فوق
/*import 'package:arak_app/features/tasks/providers/providers.dart';

class TeacherTasksNotifier extends StateNotifier<TeacherTasksState> {
  // ... الكود زي ما هو بس غيري الـ dependency injection
  TeacherTasksNotifier({
    required this.getTeacherTasks,
    required this.getTeacherStats,
    required this.ref,
  }) : super(TeacherTasksState.initial());

  // ... الـ function اللي جوا زي ما هي، بس متعمليش new Dio()

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

      final tasks = result.tasks
          .where((t) => !t.isDeleted)
          .toList();

      state = state.copyWith(
        allTasks: tasks,
        tasks: tasks,
        selectedClass: classId,
        isLoading: false,
        lastUpdated: result.lastUpdated,
        teacherId: teacherId,
      );

    } catch (e) {
      print("FETCH ERROR = $e");
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
        teacherId: teacherId,
      );
    }
  }
}*/
import 'package:arak_app/features/tasks/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arak_app/features/tasks/domain/entities/task.dart';
import 'package:arak_app/features/tasks/domain/entities/teacher_tasks_result.dart';
import 'package:arak_app/features/tasks/domain/usecases/get_teacher_tasks.dart';
import 'package:arak_app/features/tasks/domain/usecases/get_teacher_stats.dart';

/// =============================
/// State
/// =============================
class TeacherTasksState {
  final List<Task> allTasks;
  final List<Task> tasks;
  final bool isLoading;
  final String selectedClass;
  final String? error;
  final DateTime? lastUpdated;
  final String teacherId;

  const TeacherTasksState({
    required this.allTasks,
    required this.tasks,
    required this.isLoading,
    required this.selectedClass,
    this.error,
    this.lastUpdated,
    required this.teacherId,
  });

  factory TeacherTasksState.initial() => const TeacherTasksState(
    allTasks: [],
    tasks: [],
    isLoading: true,
    selectedClass: '',
    error: null,
    lastUpdated: null,
    teacherId: '',
  );

  TeacherTasksState copyWith({
    List<Task>? allTasks,
    List<Task>? tasks,
    bool? isLoading,
    String? selectedClass,
    String? error,
    DateTime? lastUpdated,
    String? teacherId,
  }) {
    return TeacherTasksState(
      allTasks: allTasks ?? this.allTasks,
      tasks: tasks ?? this.tasks,
      isLoading: isLoading ?? this.isLoading,
      selectedClass: selectedClass ?? this.selectedClass,
      error: error ?? this.error,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      teacherId: teacherId ?? this.teacherId,
    );
  }
}

/// =============================
/// Notifier
/// =============================
class TeacherTasksNotifier extends StateNotifier<TeacherTasksState> {
  final GetTeacherTasks getTeacherTasks;
  final GetTeacherStats getTeacherStats;
  final Ref ref;

  TeacherTasksNotifier({
    required this.getTeacherTasks,
    required this.getTeacherStats,
    required this.ref,
  }) : super(TeacherTasksState.initial());

  /// Fetch Tasks من الباك إند
  Future<void> fetchTasks({
    required String teacherId,
    required String classId,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      print("CALL API with teacherId: $teacherId , classId: $classId");

      final result = await getTeacherTasks(
        teacherId: teacherId,
        classId: classId,
      );

      // فلترة التاسكات المش محذوفة
      final tasks = result.tasks
          .where((t) => !t.isDeleted)
          .toList();

      print("TASKS COUNT = ${tasks.length}");

      state = state.copyWith(
        allTasks: tasks,
        tasks: tasks,
        selectedClass: classId,
        isLoading: false,
        lastUpdated: result.lastUpdated,
        teacherId: teacherId,
      );

    } catch (e) {
      print("FETCH ERROR = $e");
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
        teacherId: teacherId,
      );
    }
  }

  /// Change Class: تستدعي fetchTasks تاني
  Future<void> changeClass({
    required String teacherId,
    required String newClassId,
  }) async {
    await fetchTasks(
      teacherId: teacherId,
      classId: newClassId,
    );
  }

  /// Delete Task: تحذف من الباك ثم تحدث الليست
  Future<void> deleteTask(String taskId) async {
    try {
      // 1. استدعاء الريبو للحذف
      await ref.read(taskRepositoryProvider).deleteTask(taskId);

      // 2. تحديث البيانات فوراً (Refresh)
      if (state.teacherId.isNotEmpty && state.selectedClass.isNotEmpty) {
        await fetchTasks(
          teacherId: state.teacherId,
          classId: state.selectedClass,
        );
      }
    } catch (e) {
      print("DELETE ERROR = $e");
      state = state.copyWith(error: e.toString());
    }
  }
}

/// =============================
/// Provider
/// =============================
final teacherTasksNotifierProvider =
StateNotifierProvider<TeacherTasksNotifier, TeacherTasksState>((ref) {
  return TeacherTasksNotifier(
    getTeacherTasks: ref.watch(getTeacherTasksProvider),
    getTeacherStats: ref.watch(getTeacherStatsProvider),
    ref: ref,
  );
});