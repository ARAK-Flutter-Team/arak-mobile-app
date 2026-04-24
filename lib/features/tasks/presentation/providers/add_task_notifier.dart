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
import 'package:arak_app/features/tasks/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arak_app/features/tasks/domain/entities/task.dart';
import 'package:arak_app/features/tasks/presentation/providers/teacher_tasks_notifier.dart'; // استدعاء teacherTasksNotifierProvider

/// =============================
/// State
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
  final String? error;

  const AddTaskState({
    this.selectedClassId,
    this.selectedSubject,
    this.deadline,
    this.titleError,
    this.descriptionError,
    this.classError,
    this.subjectError,
    this.isLoading = false,
    this.error,
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
    String? error,
    bool clearError = false,
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
      error: clearError ? null : (error ?? this.error),
    );
  }
}

/// =============================
/// Notifier
/// =============================
class AddTaskNotifier extends StateNotifier<AddTaskState> {
  final Ref ref;

  AddTaskNotifier(this.ref) : super(const AddTaskState());

  /// Setters
  void setClass(String classId) {
    state = state.copyWith(selectedClassId: classId, classError: null, clearError: true);
  }

  void setSubject(String subject) {
    state = state.copyWith(selectedSubject: subject, subjectError: null, clearError: true);
  }

  void setDeadline(DateTime date) {
    state = state.copyWith(deadline: date, clearError: true);
  }

  void clearTitleError() {
    state = state.copyWith(titleError: null, clearError: true);
  }

  void clearDescriptionError() {
    state = state.copyWith(descriptionError: null, clearError: true);
  }

  /// Validation
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

  ///  Submit Task
  Future<void> submitTask({
    required String teacherId,
    required String title,
    required String description,
  }) async {
    try {
      state = state.copyWith(error: null);

      if (!validate(title: title, description: description)) return;

      if (state.selectedClassId == null || state.selectedSubject == null) {
        print("Missing fields");
        return;
      }

      state = state.copyWith(isLoading: true);

      final task = Task(
        id: "",
        title: title,
        description: description,
        subject: state.selectedSubject!,
        dueDate: state.deadline ?? DateTime.now().add(const Duration(days: 7)),
        status: TaskStatus.pending,
        assignedTo: state.selectedClassId!,
        teacherName: teacherId,
      );

      // الاتصال بالباك إند
      await ref.read(taskRepositoryProvider).addTask(task);

      // تحديث ليست التاسكات باستخدام ref مباشرة
      if (state.selectedClassId != null) {
        // هنا بنستخدم الـ Import اللي فوق مباشرة
        await ref.read(teacherTasksNotifierProvider.notifier).fetchTasks(
          teacherId: teacherId,
          classId: state.selectedClassId!,
        );
      }

      state = state.copyWith(isLoading: false);

    } catch (e) {
      print("SUBMIT TASK ERROR = $e");
      state = state.copyWith(
        isLoading: false,
        error: e.toString().replaceFirst("Exception: ", ""),
      );
      rethrow;
    }
  }
}

/// Provider
final addTaskNotifierProvider =
StateNotifierProvider<AddTaskNotifier, AddTaskState>((ref) {
  return AddTaskNotifier(ref);
});