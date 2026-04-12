/*import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/evaluation.dart';
import '../../domain/usecases/get_students.dart';
import '../../domain/usecases/get_evaluations.dart';
import '../../domain/usecases/save_evaluations.dart';
import '../state/evaluation_state.dart';

class EvaluationController extends StateNotifier<EvaluationState> {
  final GetStudents getStudents;
  final GetEvaluations getEvaluations;
  final SaveEvaluations saveEvaluations;

  EvaluationController({
    required this.getStudents,
    required this.getEvaluations,
    required this.saveEvaluations,
  }) : super(EvaluationState());

  //  Load Data
  Future<void> loadData({
    required int classId,
    required int subjectId,
    required String assessmentType,
  }) async {
    state = state.copyWith(isLoading: true);

    try {
      final students = await getStudents(classId);

      final evaluations = await getEvaluations(
        classId: classId,
        subjectId: subjectId,
      );

      final marksMap = <int, int?>{};
      final absentMap = <int, bool>{};

      for (var student in students) {
        final eval = evaluations.firstWhere(
              (e) => e.studentId == student.id,
          orElse: () => Evaluation(
            studentId: student.id,
            classId: classId,
            subjectId: subjectId,
            assessmentType: assessmentType,
            marks: null,
            maxMarks: 50,
            date: DateTime.now(),
            isAbsent: false,
          ),
        );

        marksMap[student.id] = eval.marks;
        absentMap[student.id] = eval.isAbsent;
      }

      state = state.copyWith(
        isLoading: false,
        students: students,
        marks: marksMap,
        absent: absentMap,
        selectedClassId: classId,
        selectedSubjectId: subjectId,
        selectedAssessmentType: assessmentType,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  //  Update Marks
  void updateMark(int studentId, int? mark) {
    final newMarks = {...state.marks};
    newMarks[studentId] = mark;

    state = state.copyWith(marks: newMarks);
  }

  //  Toggle Absent
  void toggleAbsent(int studentId, bool value) {
    final newAbsent = {...state.absent};
    final newMarks = {...state.marks};

    newAbsent[studentId] = value;

    if (value) {
      newMarks[studentId] = null;
    }

    state = state.copyWith(
      absent: newAbsent,
      marks: newMarks,
    );
  }

  //  Save
  Future<void> save() async {
    if (state.gradesLocked) return;

    state = state.copyWith(
      isSaving: true,
      error: null,
      successMessage: null,
    );

    try {
      final List<Evaluation> list = [];

      for (var student in state.students) {
        final mark = state.marks[student.id];
        final isAbsent = state.absent[student.id] ?? false;

        if (!isAbsent && (mark == null)) {
          throw Exception("All students must have marks");
        }

        if (mark != null && mark > 50) {
          throw Exception("Marks exceed max");
        }

        list.add(
          Evaluation(
            studentId: student.id,
            classId: state.selectedClassId!,
            subjectId: state.selectedSubjectId!,
            assessmentType: state.selectedAssessmentType!,
            marks: isAbsent ? null : mark,
            maxMarks: 50,
            date: DateTime.now(),
            isAbsent: isAbsent,
          ),
        );
      }

      await saveEvaluations(list);

      //  SUCCESS HERE
      state = state.copyWith(
        isSaving: false,
        successMessage: "Saved successfully",
      );
    } catch (e) {
      state = state.copyWith(
        isSaving: false,
        error: e.toString(),
      );
    }
  }
}*/
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/evaluation.dart';
import '../../domain/usecases/get_students.dart';
import '../../domain/usecases/get_evaluations.dart';
import '../../domain/usecases/save_evaluations.dart';
import '../state/evaluation_state.dart';

class EvaluationController extends StateNotifier<EvaluationState> {
  final GetStudents getStudents;
  final GetEvaluations getEvaluations;
  final SaveEvaluations saveEvaluations;

  EvaluationController({
    required this.getStudents,
    required this.getEvaluations,
    required this.saveEvaluations,
  }) : super(EvaluationState());

  //  Load Data
  Future<void> loadData({
    required int classId,
    required int subjectId,
    required String assessmentType,
  }) async {
    state = state.copyWith(isLoading: true);

    try {
      final students = await getStudents(classId);

      final evaluations = await getEvaluations(
        classId: classId,
        subjectId: subjectId,
      );

      final marksMap = <int, int?>{};
      final absentMap = <int, bool>{};
      final statusesMap = <int, String?>{};

      for (var student in students) {
        final eval = evaluations.firstWhere(
              (e) => e.studentId == student.id,
          orElse: () => Evaluation(
            studentId: student.id,
            classId: classId,
            subjectId: subjectId,
            assessmentType: assessmentType,
            marks: null,
            maxMarks: 50,
            date: DateTime.now(),
            isAbsent: false,
            status: null,
          ),
        );

        marksMap[student.id] = eval.marks;
        absentMap[student.id] = eval.isAbsent;
        statusesMap[student.id] = eval.status;
      }

      state = state.copyWith(
        isLoading: false,
        students: students,
        marks: marksMap,
        absent: absentMap,
        statuses: statusesMap,
        selectedClassId: classId,
        selectedSubjectId: subjectId,
        selectedAssessmentType: assessmentType,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  //  Update Marks
  void updateMark(int studentId, int? mark) {
    final newMarks = {...state.marks};
    newMarks[studentId] = mark;
    state = state.copyWith(marks: newMarks);
  }

  void updateStatus(int studentId, String? status) {
    final newStatuses = {...state.statuses};
    newStatuses[studentId] = status;
    state = state.copyWith(statuses: newStatuses);
  }

  //  Toggle Absent
  void toggleAbsent(int studentId, bool value) {
    final newAbsent = {...state.absent};
    final newMarks = {...state.marks};
    final newStatuses = {...state.statuses};
    newAbsent[studentId] = value;

    if (value) {
      newMarks[studentId] = null;
      newStatuses[studentId] = null;
    }

    state = state.copyWith(
      absent: newAbsent,
      marks: newMarks,
      statuses: newStatuses,
    );
  }

  //  Save
  Future<void> save() async {
    if (state.gradesLocked) return;

    state = state.copyWith(
      isSaving: true,
      error: null,
      successMessage: null,
    );

    try {
      final List<Evaluation> list = [];

      for (var student in state.students) {
        final mark = state.marks[student.id];
        final isAbsent = state.absent[student.id] ?? false;
        final status = state.statuses[student.id];

        if (!isAbsent && (mark == null)) {
          throw Exception("All students must have marks");
        }

        if (mark != null && mark > 50) {
          throw Exception("Marks exceed max");
        }

        list.add(
          Evaluation(
            studentId: student.id,
            classId: state.selectedClassId!,
            subjectId: state.selectedSubjectId!,
            assessmentType: state.selectedAssessmentType!,
            marks: isAbsent ? null : mark,
            maxMarks: 50,
            date: DateTime.now(),
            isAbsent: isAbsent,
            status: status,
          ),
        );
      }

      await saveEvaluations(list);

      //  SUCCESS HERE
      state = state.copyWith(
        isSaving: false,
        successMessage: "Saved successfully",
      );
    } catch (e) {
      state = state.copyWith(
        isSaving: false,
        error: e.toString(),
      );
    }
  }
}