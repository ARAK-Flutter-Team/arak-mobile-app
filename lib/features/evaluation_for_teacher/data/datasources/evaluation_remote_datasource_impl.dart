import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/evaluation_model.dart';
import '../models/student_model.dart';
import 'evaluation_remote_datasource.dart';

class EvaluationRemoteDataSourceImpl
    implements EvaluationRemoteDataSource {
  final http.Client client;

  /// غيري دي بالـ Base URL بتاعك
  final String baseUrl;

  EvaluationRemoteDataSourceImpl({
    required this.client,
    required this.baseUrl,
  });

  @override
  Future<List<StudentModel>> getStudents(int classId) async {
    final uri = Uri.parse('$baseUrl/students?classId=$classId');

    final response = await client.get(uri);

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);

      return data.map((e) => StudentModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load students');
    }
  }

  @override
  Future<List<EvaluationModel>> getEvaluations({
    required int classId,
    required int subjectId,
  }) async {
    final uri = Uri.parse(
      '$baseUrl/evaluations?classId=$classId&subjectId=$subjectId',
    );

    final response = await client.get(uri);

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);

      return data.map((e) => EvaluationModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load evaluations');
    }
  }

  @override
  Future<void> saveEvaluations(
      List<EvaluationModel> evaluations) async {
    final uri = Uri.parse('$baseUrl/evaluations/batch');

    final response = await client.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(
        evaluations.map((e) => e.toJson()).toList(),
      ),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to save evaluations');
    }
  }
}