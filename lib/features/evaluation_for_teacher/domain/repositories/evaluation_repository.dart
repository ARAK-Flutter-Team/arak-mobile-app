import '../entities/evaluation.dart';
import '../entities/student.dart';

abstract class EvaluationRepository {
  Future<List<Student>> getStudents(int classId);

  Future<List<Evaluation>> getEvaluations({
    required int classId,
    required int subjectId,
  });

  Future<void> saveEvaluations(List<Evaluation> evaluations);
}