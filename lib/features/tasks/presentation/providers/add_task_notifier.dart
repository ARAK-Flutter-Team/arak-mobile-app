import 'package:flutter_riverpod/flutter_riverpod.dart';

/// =======================
/// State
/// =======================
class AddTaskState {
  final String? selectedClassId;
  final String? selectedSubject;
  final DateTime? deadline;
  final bool isLoading;

  final String? classError;
  final String? subjectError;
  final String? deadlineError;
  final String? titleError;
  final String? descriptionError;

  const AddTaskState({
    this.selectedClassId,
    this.selectedSubject,
    this.deadline,
    this.isLoading = false,
    this.classError,
    this.subjectError,
    this.deadlineError,
    this.titleError,
    this.descriptionError,
  });

  AddTaskState copyWith({
    String? selectedClassId,
    String? selectedSubject,
    DateTime? deadline,
    bool? isLoading,
    String? classError,
    String? subjectError,
    String? deadlineError,
    String? titleError,
    String? descriptionError,
  }) {
    return AddTaskState(
      selectedClassId: selectedClassId ?? this.selectedClassId,
      selectedSubject: selectedSubject ?? this.selectedSubject,
      deadline: deadline ?? this.deadline,
      isLoading: isLoading ?? this.isLoading,
      classError: classError,
      subjectError: subjectError,
      deadlineError: deadlineError,
      titleError: titleError,
      descriptionError: descriptionError,
    );
  }
}

/// =======================
/// Notifier
/// =======================
class AddTaskNotifier extends StateNotifier<AddTaskState> {
  AddTaskNotifier() : super(const AddTaskState());

  // =======================
  // Setters
  // =======================
  void setClass(String classId) {
    state = state.copyWith(
      selectedClassId: classId,
      classError: null,
    );
  }

  void setSubject(String subject) {
    state = state.copyWith(
      selectedSubject: subject,
      subjectError: null,
    );
  }

  void setDeadline(DateTime date) {
    state = state.copyWith(
      deadline: date,
      deadlineError: null,
    );
  }

  void clearTitleError() {
    state = state.copyWith(titleError: null);
  }

  void clearDescriptionError() {
    state = state.copyWith(descriptionError: null);
  }

  // =======================
  // Validation
  // =======================
  bool validate({
    required String title,
    required String description,
  }) {
    state = state.copyWith(
      classError: null,
      subjectError: null,
      deadlineError: null,
      titleError: null,
      descriptionError: null,
    );

    if (title.isEmpty) {
      state = state.copyWith(titleError: "This field is required");
      return false;
    }

    if (description.isEmpty) {
      state = state.copyWith(descriptionError: "This field is required");
      return false;
    }

    if (state.selectedClassId == null) {
      state = state.copyWith(classError: "This field is required");
      return false;
    }

    if (state.selectedSubject == null) {
      state = state.copyWith(subjectError: "This field is required");
      return false;
    }

    if (state.deadline == null) {
      state = state.copyWith(deadlineError: "This field is required");
      return false;
    }

    return true;
  }
  // =======================
  // Submit Task
  // =======================
  Future<void> submitTask({
    required String title,
    required String description,
  }) async {
    final isValid = validate(title: title, description: description);

    if (!isValid) return;

    try {
      state = state.copyWith(isLoading: true);

      /// 🔹 Simulate API
      await Future.delayed(const Duration(seconds: 1));

      state = state.copyWith(isLoading: false);

    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }
}

/// =======================
/// Provider
/// =======================
final addTaskNotifierProvider =
StateNotifierProvider<AddTaskNotifier, AddTaskState>(
      (ref) => AddTaskNotifier(),
);