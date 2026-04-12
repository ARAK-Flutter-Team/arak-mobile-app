import '../entities/evaluation.dart';
import '../repositories/evaluation_repository.dart';

class GetEvaluations {
  final EvaluationRepository repository;

  GetEvaluations(this.repository);

  Future<List<Evaluation>> call({
    required int classId,
    required int subjectId,
  }) {
    return repository.getEvaluations(
      classId: classId,
      subjectId: subjectId,
    );
  }
}