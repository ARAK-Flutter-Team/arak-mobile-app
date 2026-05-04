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
    final path = '/students/SearchStudentsByClassId/0';
    print('DEBUG: Calling Parent Search API: $path');
    
    try {
      final response = await dio.get(path);
      print('DEBUG: Parent Search Status: ${response.statusCode}');
      print('DEBUG: Parent Search Response: ${response.data}');

      final dynamic responseData = response.data;
      List<dynamic> data = [];

      if (responseData is List) {
        data = responseData;
      } else if (responseData is Map && responseData.containsKey('data')) {
        data = responseData['data'] as List;
      }

      return data
          .map((json) => StudentModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('DEBUG: Parent Search Error: $e');
      return [];
    }
  }
}
