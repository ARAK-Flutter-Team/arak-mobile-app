import '../entities/evaluation.dart';
import '../repositories/evaluation_repository.dart';

class SaveEvaluations {
  final EvaluationRepository repository;

  SaveEvaluations(this.repository);

  Future<void> call(List<Evaluation> evaluations) {
    return repository.saveEvaluations(evaluations);
  }
}