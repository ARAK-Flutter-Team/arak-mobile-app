// lib/features/evaluation/data/repositories/evaluation_repository_impl.dart

import 'package:arak_app/features/evaluation/data/datasources/evaluation_remote_data_source.dart';
import 'package:arak_app/features/evaluation/data/models/evaluation_model.dart';
import 'package:arak_app/features/evaluation/domain/repositories/evaluation_repository.dart';

class EvaluationRepositoryImpl implements EvaluationRepository {
  final EvaluationRemoteDataSource remoteDataSource;

  EvaluationRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<EvaluationModel>> getStudentEvaluations(int classId) async {
    return remoteDataSource.getStudentEvaluations(classId);
  }
}
