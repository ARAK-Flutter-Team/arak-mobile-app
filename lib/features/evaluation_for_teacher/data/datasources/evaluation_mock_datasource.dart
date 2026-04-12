import 'dart:async';

import '../models/evaluation_model.dart';
import '../models/student_model.dart';
import 'evaluation_remote_datasource.dart';

class EvaluationMockDataSource implements EvaluationRemoteDataSource {
  @override
  Future<List<StudentModel>> getStudents(int classId) async {
    await Future.delayed(const Duration(milliseconds: 800));

    return [
      StudentModel(id: 1, name: "Ahmed"),
      StudentModel(id: 2, name: "Sara"),
      StudentModel(id: 3, name: "Omar"),
      StudentModel(id: 4, name: "Mona"),
    ];
  }

  @override
  Future<List<EvaluationModel>> getEvaluations({
    required int classId,
    required int subjectId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));

    return [
      EvaluationModel(
        studentId: 1,
        classId: classId,
        subjectId: subjectId,
        assessmentType: "Month1",
        marks: 40,
        maxMarks: 50,
        date: DateTime.now(),
        isAbsent: false,
      ),
      EvaluationModel(
        studentId: 2,
        classId: classId,
        subjectId: subjectId,
        assessmentType: "Month1",
        marks: null,
        maxMarks: 50,
        date: DateTime.now(),
        isAbsent: true,
      ),
    ];
  }

  @override
  Future<void> saveEvaluations(List<EvaluationModel> evaluations) async {
    await Future.delayed(const Duration(milliseconds: 800));

    ///  اطبعي الداتا عشان تشوفيها
    print("SAVED DATA:");
    for (var e in evaluations) {
      print(e.toJson());
    }
  }
}