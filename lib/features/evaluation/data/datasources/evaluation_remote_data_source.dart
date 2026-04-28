import 'package:dio/dio.dart';
import '../models/evaluation_model.dart';

abstract class EvaluationRemoteDataSource {
  Future<List<EvaluationModel>> getStudentEvaluations(int studentId);
}

class EvaluationRemoteDataSourceImpl implements EvaluationRemoteDataSource {
  final Dio dio;

  EvaluationRemoteDataSourceImpl(this.dio);

  @override
  Future<List<EvaluationModel>> getStudentEvaluations(int studentId) async {
    final response = await dio.get(
      '/api/evaluations',
      queryParameters: {'studentId': studentId},
    );

    final List data = response.data as List? ?? [];
    return data
        .map((e) => EvaluationModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
