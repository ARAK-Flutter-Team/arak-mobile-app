import 'package:dio/dio.dart';
import '../models/student_details_model.dart';

abstract class StudentDetailsRemoteDataSource {
  Future<StudentDetailsModel> getStudentDetails(String studentId);
}

class StudentDetailsRemoteDataSourceImpl
    implements StudentDetailsRemoteDataSource {
  final Dio dio;
  StudentDetailsRemoteDataSourceImpl(this.dio);

  @override
  Future<StudentDetailsModel> getStudentDetails(String studentId) async {
    final response = await dio.get('/Students/$studentId');
    final data = response.data as Map<String, dynamic>;
    return StudentDetailsModel.fromJson(data);
  }
}
