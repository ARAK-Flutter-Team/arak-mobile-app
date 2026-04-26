import 'package:dio/dio.dart';
import '../models/student_model.dart';

abstract class StudentRemoteDataSource {
  Future<List<StudentModel>> getStudents();
}

class StudentRemoteDataSourceImpl implements StudentRemoteDataSource {
  final Dio dio;

  StudentRemoteDataSourceImpl(this.dio);

  @override
  Future<List<StudentModel>> getStudents() async {
    final response = await dio.get('/api/students/SearchStudentsByClassId/0');

    final List<dynamic> data =
        response.data is List ? response.data as List : [];

    return data
        .map((json) => StudentModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
