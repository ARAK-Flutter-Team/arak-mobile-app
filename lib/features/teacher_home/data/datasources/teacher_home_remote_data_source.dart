/*import '../models/teacher_home_model.dart';

abstract class TeacherHomeRemoteDataSource {
  Future<TeacherHomeModel> getTeacherHomeData();
}*/
// lib/features/teacher_home/data/datasources/teacher_home_remote_data_source.dart

import 'package:dio/dio.dart';
import '../models/teacher_home_model.dart';

abstract class TeacherHomeRemoteDataSource {
  Future<TeacherHomeModel> getTeacherHomeData();
}

class TeacherHomeRemoteDataSourceImpl implements TeacherHomeRemoteDataSource {
  final Dio dio;

  TeacherHomeRemoteDataSourceImpl(this.dio);

  @override
  Future<TeacherHomeModel> getTeacherHomeData() async {
    try {
      final response = await dio.get('/api/Teachers/me');

      if (response.statusCode == 200) {
        return TeacherHomeModel.fromJson(response.data);
      } else {
        throw Exception('فشل في تحميل البيانات: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('خطأ في الشبكة: ${e.message}');
    }
  }
}