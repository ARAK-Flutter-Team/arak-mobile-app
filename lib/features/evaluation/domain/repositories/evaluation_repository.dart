// lib/features/evaluation/domain/repositories/evaluation_repository.dart

import '../../data/models/evaluation_model.dart';

abstract class EvaluationRepository {
  Future<List<EvaluationModel>> getStudentEvaluations(int studentId);
}
