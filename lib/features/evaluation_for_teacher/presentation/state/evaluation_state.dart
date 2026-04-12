/*import '../../domain/entities/student.dart';

class EvaluationState {
  final bool isLoading;
  final bool isSaving;
  final bool gradesLocked;

  final int? selectedClassId;
  final int? selectedSubjectId;
  final String? selectedAssessmentType;

  final List<Student> students;
  final Map<int, int?> marks; // studentId -> marks
  final Map<int, bool> absent; // studentId -> isAbsent

  final String? error;
  final String? successMessage;
  EvaluationState({
    this.isLoading = false,
    this.isSaving = false,
    this.gradesLocked = false,
    this.selectedClassId,
    this.selectedSubjectId,
    this.selectedAssessmentType,
    this.students = const [],
    this.marks = const {},
    this.absent = const {},
    this.error,
    this.successMessage,
  });

  EvaluationState copyWith({
    bool? isLoading,
    bool? isSaving,
    bool? gradesLocked,
    int? selectedClassId,
    int? selectedSubjectId,
    String? selectedAssessmentType,
    List<Student>? students,
    Map<int, int?>? marks,
    Map<int, bool>? absent,
    String? error,
    String? successMessage,
  }) {
    return EvaluationState(
      isLoading: isLoading ?? this.isLoading,
      isSaving: isSaving ?? this.isSaving,
      gradesLocked: gradesLocked ?? this.gradesLocked,
      selectedClassId: selectedClassId ?? this.selectedClassId,
      selectedSubjectId: selectedSubjectId ?? this.selectedSubjectId,
      selectedAssessmentType:
      selectedAssessmentType ?? this.selectedAssessmentType,
      students: students ?? this.students,
      marks: marks ?? this.marks,
      absent: absent ?? this.absent,
      error: error,
      successMessage: successMessage,
    );
  }
}*/
import '../../domain/entities/student.dart';

class EvaluationState {
  final bool isLoading;
  final bool isSaving;
  final bool gradesLocked;

  final int? selectedClassId;
  final int? selectedSubjectId;
  final String? selectedAssessmentType;

  final List<Student> students;
  final Map<int, int?> marks; // studentId -> marks
  final Map<int, bool> absent; // studentId -> isAbsent
  final Map<int, String?> statuses;

  final String? error;
  final String? successMessage;

  EvaluationState({
    this.isLoading = false,
    this.isSaving = false,
    this.gradesLocked = false,
    this.selectedClassId,
    this.selectedSubjectId,
    this.selectedAssessmentType,
    this.students = const [],
    this.marks = const {},
    this.absent = const {},
    this.statuses = const {},
    this.error,
    this.successMessage,
  });

  EvaluationState copyWith({
    bool? isLoading,
    bool? isSaving,
    bool? gradesLocked,
    int? selectedClassId,
    int? selectedSubjectId,
    String? selectedAssessmentType,
    List<Student>? students,
    Map<int, int?>? marks,
    Map<int, bool>? absent,
    Map<int, String?>? statuses,
    String? error,
    String? successMessage,
  }) {
    return EvaluationState(
      isLoading: isLoading ?? this.isLoading,
      isSaving: isSaving ?? this.isSaving,
      gradesLocked: gradesLocked ?? this.gradesLocked,
      selectedClassId: selectedClassId ?? this.selectedClassId,
      selectedSubjectId: selectedSubjectId ?? this.selectedSubjectId,
      selectedAssessmentType:
      selectedAssessmentType ?? this.selectedAssessmentType,
      students: students ?? this.students,
      marks: marks ?? this.marks,
      absent: absent ?? this.absent,
      statuses: statuses ?? this.statuses,
      error: error,
      successMessage: successMessage,
    );
  }
}