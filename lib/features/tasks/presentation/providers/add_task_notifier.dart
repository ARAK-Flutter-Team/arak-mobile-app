/*import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/task_remote_data_source_impl.dart';
import '../../data/models/task_model.dart';
import '../../domain/entities/task.dart';
import 'teacher_tasks_notifier.dart';

/// =============================
/// State for Add Task Page
/// =============================
class AddTaskState {
  final String? selectedClassId;
  final String? selectedSubject;
  final DateTime? deadline;
  final String? titleError;
  final String? descriptionError;
  final String? classError;
  final String? subjectError;
  final bool isLoading;

  const AddTaskState({
    this.selectedClassId,
    this.selectedSubject,
    this.deadline,
    this.titleError,
    this.descriptionError,
    this.classError,
    this.subjectError,
    this.isLoading = false,
  });

  AddTaskState copyWith({
    String? selectedClassId,
    String? selectedSubject,
    DateTime? deadline,
    String? titleError,
    String? descriptionError,
    String? classError,
    String? subjectError,
    bool? isLoading,
  }) {
    return AddTaskState(
      selectedClassId: selectedClassId ?? this.selectedClassId,
      selectedSubject: selectedSubject ?? this.selectedSubject,
      deadline: deadline ?? this.deadline,
      titleError: titleError,
      descriptionError: descriptionError,
      classError: classError,
      subjectError: subjectError,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

/// =============================
/// Notifier
/// =============================
class AddTaskNotifier extends StateNotifier<AddTaskState> {
  final Ref ref;

  AddTaskNotifier(this.ref) : super(const AddTaskState());

  /// =============================
  /// Setters
  /// =============================
  void setClass(String classId) {
    state = state.copyWith(selectedClassId: classId, classError: null);
  }

  void setSubject(String subject) {
    state = state.copyWith(selectedSubject: subject, subjectError: null);
  }

  void setDeadline(DateTime date) {
    state = state.copyWith(deadline: date);
  }

  void clearTitleError() {
    state = state.copyWith(titleError: null);
  }

  void clearDescriptionError() {
    state = state.copyWith(descriptionError: null);
  }

  /// =============================
  /// Validation
  /// =============================
  bool validate({
    required String title,
    required String description,
  }) {

    if (state.selectedClassId == null) {
      state = state.copyWith(classError: "Please select class");
      return false;
    }

    if (state.selectedSubject == null) {
      state = state.copyWith(subjectError: "Please select subject");
      return false;
    }

    if (title.isEmpty) {
      state = state.copyWith(titleError: "Title is required");
      return false;
    }

    if (description.isEmpty) {
      state = state.copyWith(descriptionError: "Description is required");
      return false;
    }

    return true;
  }

  /// =============================
  /// Submit Task
  /// =============================
  Future<void> submitTask({
    required String teacherId,
    required String title,
    required String description,
  }) async {

    try {
      state = state.copyWith(isLoading: true);

      final newTask = TaskModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        description: description,
        subject: state.selectedSubject!,
        dueDate: state.deadline ?? DateTime.now().add(const Duration(days: 7)),
        status: TaskStatus.pending,
        imageUrl: '',
        assignedTo: state.selectedClassId!,
        teacherName: teacherId,
      );

      await ref
          .read(teacherTasksNotifierProvider.notifier)
          .addTask(newTask);

    } catch (e) {
      print("Add Task Error: $e");
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}

/// =============================
/// Provider
/// =============================
final addTaskNotifierProvider =
StateNotifierProvider<AddTaskNotifier, AddTaskState>(
      (ref) => AddTaskNotifier(ref),
);

/// =============================
/// Remote DataSource Provider
/// =============================
final taskRemoteDataSourceProvider =
Provider((ref) => TaskRemoteDataSourceImpl());*/
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/task_remote_data_source_impl.dart';
import '../../data/models/task_model.dart';
import '../../domain/entities/task.dart';
import 'teacher_tasks_notifier.dart';

/// =============================
/// State for Add Task Page
/// =============================
class AddTaskState {
  final String? selectedClassId;
  final String? selectedSubject;
  final DateTime? deadline;
  final String? titleError;
  final String? descriptionError;
  final String? classError;
  final String? subjectError;
  final bool isLoading;

  const AddTaskState({
    this.selectedClassId,
    this.selectedSubject,
    this.deadline,
    this.titleError,
    this.descriptionError,
    this.classError,
    this.subjectError,
    this.isLoading = false,
  });

  AddTaskState copyWith({
    String? selectedClassId,
    String? selectedSubject,
    DateTime? deadline,
    String? titleError,
    String? descriptionError,
    String? classError,
    String? subjectError,
    bool? isLoading,
  }) {
    return AddTaskState(
      selectedClassId: selectedClassId ?? this.selectedClassId,
      selectedSubject: selectedSubject ?? this.selectedSubject,
      deadline: deadline ?? this.deadline,
      titleError: titleError,
      descriptionError: descriptionError,
      classError: classError,
      subjectError: subjectError,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

/// =============================
/// Notifier
/// =============================
class AddTaskNotifier extends StateNotifier<AddTaskState> {
  final Ref ref;

  AddTaskNotifier(this.ref) : super(const AddTaskState());

  /// =============================
  /// Setters
  /// =============================
  void setClass(String classId) {
    state = state.copyWith(selectedClassId: classId, classError: null);
  }

  void setSubject(String subject) {
    state = state.copyWith(selectedSubject: subject, subjectError: null);
  }

  void setDeadline(DateTime date) {
    state = state.copyWith(deadline: date);
  }

  void clearTitleError() {
    state = state.copyWith(titleError: null);
  }

  void clearDescriptionError() {
    state = state.copyWith(descriptionError: null);
  }

  /// =============================
  /// Validation
  /// =============================
  bool validate({
    required String title,
    required String description,
  }) {

    if (state.selectedClassId == null) {
      state = state.copyWith(classError: "Please select class");
      return false;
    }

    if (state.selectedSubject == null) {
      state = state.copyWith(subjectError: "Please select subject");
      return false;
    }

    if (title.isEmpty) {
      state = state.copyWith(titleError: "Title is required");
      return false;
    }

    if (description.isEmpty) {
      state = state.copyWith(descriptionError: "Description is required");
      return false;
    }

    return true;
  }

  /// =============================
  /// Submit Task
  /// =============================
  Future<void> submitTask({
    required String teacherId,
    required String title,
    required String description,
  }) async {

    try {
      state = state.copyWith(isLoading: true);

      final newTask = TaskModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        description: description,
        subject: state.selectedSubject!,
        dueDate: state.deadline ?? DateTime.now().add(const Duration(days: 7)),
        status: TaskStatus.pending,
        imageUrl: '',
        assignedTo: state.selectedClassId!,
        teacherName: teacherId,
      );

      await ref
          .read(teacherTasksNotifierProvider.notifier)
          .addTask(newTask);

    } catch (e) {
      print("Add Task Error: $e");
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}

/// =============================
/// Provider
/// =============================
final addTaskNotifierProvider =
StateNotifierProvider<AddTaskNotifier, AddTaskState>(
      (ref) => AddTaskNotifier(ref),
);

/// =============================
/// Remote DataSource Provider
/// =============================
final taskRemoteDataSourceProvider =
Provider((ref) => TaskRemoteDataSourceImpl());