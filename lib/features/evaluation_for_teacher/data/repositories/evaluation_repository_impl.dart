import '../../domain/entities/evaluation.dart';
import '../../domain/entities/student.dart';
import '../../domain/repositories/evaluation_repository.dart';
import '../datasources/evaluation_remote_datasource.dart';
import '../models/evaluation_model.dart';

class EvaluationRepositoryImpl implements EvaluationRepository {
  final EvaluationRemoteDataSource remote;

  EvaluationRepositoryImpl(this.remote);

  @override
  Future<List<Student>> getStudents(int classId) async {
    final models = await remote.getStudents(classId);

    return models
        .map(
          (e) => Student(
        id: e.id,
        name: e.name,
      ),
    )
        .toList();
  }

  @override
  Future<List<Evaluation>> getEvaluations({
    required int classId,
    required int subjectId,
  }) async {
    final models = await remote.getEvaluations(
      classId: classId,
      subjectId: subjectId,
    );

    return models
        .map(
          (e) => Evaluation(
        studentId: e.studentId,
        classId: e.classId,
        subjectId: e.subjectId,
        assessmentType: e.assessmentType,
        marks: e.marks,
        maxMarks: e.maxMarks,
        date: e.date,
        isAbsent: e.isAbsent,
      ),
    )
        .toList();
  }

  @override
  Future<void> saveEvaluations(
      List<Evaluation> evaluations) async {
    final models = evaluations
        .map(
          (e) => EvaluationModel(
        studentId: e.studentId,
        classId: e.classId,
        subjectId: e.subjectId,
        assessmentType: e.assessmentType,
        marks: e.marks,
        maxMarks: e.maxMarks,
        date: e.date,
        isAbsent: e.isAbsent,
      ),
    )
        .toList();

    await remote.saveEvaluations(models);
  }
}