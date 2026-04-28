import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arak_app/features/tasks/domain/entities/task.dart';
import 'package:arak_app/features/tasks/domain/usecases/add_task.dart';
import 'package:arak_app/features/tasks/presentation/providers/teacher_tasks_notifier.dart';
import '../../../../core/utils/logger_utils.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import 'providers.dart';

class AddTaskState {
  final String? selectedClassId;
  final DateTime? deadline;
  final String? titleError;
  final String? descriptionError;
  final String? classError;
  final bool isLoading;
  final String? error;

  const AddTaskState({
    this.selectedClassId,
    this.deadline,
    this.titleError,
    this.descriptionError,
    this.classError,
    this.isLoading = false,
    this.error,
  });

  AddTaskState copyWith({
    String? selectedClassId,
    DateTime? deadline,
    String? titleError,
    String? descriptionError,
    String? classError,
    bool? isLoading,
    String? error,
  }) {
    return AddTaskState(
      selectedClassId: selectedClassId ?? this.selectedClassId,
      deadline: deadline ?? this.deadline,
      titleError: titleError,
      descriptionError: descriptionError,
      classError: classError ?? this.classError,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class AddTaskNotifier extends StateNotifier<AddTaskState> {
  final Ref ref;
  final AddTask addTask;

  AddTaskNotifier(this.ref, this.addTask) : super(const AddTaskState());

  void setClass(String classId) {
    AppLogger.logInfo(' AddTaskNotifier.setClass called with: "$classId"');
    if (classId.isNotEmpty) {
      state = state.copyWith(selectedClassId: classId, classError: null);
      AppLogger.logSuccess('selectedClassId updated to: "$classId"');
    } else {
      AppLogger.logWarning('setClass called with empty string, ignoring');
    }
  }

  void setDeadline(DateTime date) {
    AppLogger.logInfo(' AddTaskNotifier.setDeadline: $date');
    state = state.copyWith(deadline: date);
  }

  void clearTitleError() {
    state = state.copyWith(titleError: null);
  }

  void clearDescriptionError() {
    state = state.copyWith(descriptionError: null);
  }

  bool validate({required String title, required String description}) {
    AppLogger.logInfo(' AddTaskNotifier.validate - selectedClassId: "${state.selectedClassId}"');

    if (state.selectedClassId == null || state.selectedClassId!.isEmpty) {
      AppLogger.logError('Validation failed: No class selected');
      state = state.copyWith(classError: "Please select a class");
      return false;
    }
    if (title.trim().isEmpty) {
      AppLogger.logError('Validation failed: Title is empty');
      state = state.copyWith(titleError: "Title is required");
      return false;
    }
    if (description.trim().isEmpty) {
      AppLogger.logError('Validation failed: Description is empty');
      state = state.copyWith(descriptionError: "Description is required");
      return false;
    }
    AppLogger.logSuccess('Validation passed');
    return true;
  }

  Future<void> submitTask({
    required String title,
    required String description,
  }) async {
    AppLogger.logInfo('========== SUBMIT TASK STARTED ==========');
    AppLogger.logInfo('Title: "$title", Description: "$description"');

    if (!validate(title: title, description: description)) return;

    final classIdStr = state.selectedClassId!;
    final teacherIdInt = ref.read(currentTeacherIdProvider);

    AppLogger.logInfo('Class ID String: "$classIdStr"');
    AppLogger.logInfo('Teacher ID from provider: $teacherIdInt');

    if (teacherIdInt == 0) {
      AppLogger.logError('Teacher ID is 0, aborting');
      state = state.copyWith(error: "Teacher ID not found", isLoading: false);
      return;
    }

    final task = Task(
      id: "",
      title: title.trim(),
      description: description.trim(),
      dueDate: state.deadline ?? DateTime.now().add(const Duration(days: 7)),
      status: TaskStatus.pending,
      assignedTo: classIdStr,
      teacherId: teacherIdInt.toString(),
    );

    AppLogger.logInfo('Task to add: title=${task.title}, assignedTo=${task.assignedTo}, teacherId=${task.teacherId}');

    state = state.copyWith(isLoading: true, error: null);

    try {
      AppLogger.logInfo('Calling addTask...');
      await addTask(task);
      AppLogger.logSuccess('Task added successfully');

      final classIdInt = int.tryParse(classIdStr) ?? 0;
      AppLogger.logInfo('Class ID int: $classIdInt');

      if (classIdInt != 0) {
        AppLogger.logInfo('Fetching tasks again with teacherId: $teacherIdInt, classId: $classIdInt');
        await ref.read(teacherTasksNotifierProvider.notifier).fetchTasks(
          teacherId: teacherIdInt,
          classId: classIdInt,
        );
        AppLogger.logSuccess('Tasks fetched again');
      }

      state = state.copyWith(isLoading: false);
      AppLogger.logSuccess('========== SUBMIT TASK COMPLETED ==========');
    } catch (e) {
      AppLogger.logError('Submit task error: $e');
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

final addTaskNotifierProvider = StateNotifierProvider<AddTaskNotifier, AddTaskState>((ref) {
  final addTaskUseCase = ref.watch(addTaskProvider);
  return AddTaskNotifier(ref, addTaskUseCase);
});