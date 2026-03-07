// lib/features/evaluation/data/repositories/evaluation_repository_impl.dart

import 'package:arak_app/features/evaluation/domain/entities/student_entity.dart';
import 'package:arak_app/features/evaluation/domain/repositories/evaluation_repository.dart';
import 'package:arak_app/features/evaluation/data/datasources/evaluation_remote_data_source.dart';

class EvaluationRepositoryImpl implements EvaluationRepository {
  final EvaluationRemoteDataSource remoteDataSource;

  EvaluationRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Student> getStudentData() async {
    final studentModel = await remoteDataSource.getStudentEvaluation();
    return studentModel;
  }
}
