import 'package:dio/dio.dart';
import '../models/student_attendance_model.dart';
import '../../domain/entities/student_attendance_entity.dart';

abstract class AttendanceRemoteDataSource {
  Future<StudentAttendanceModel> getAttendance(int studentId,
      {int? month, int? year});
}

class AttendanceRemoteDataSourceImpl implements AttendanceRemoteDataSource {
  final Dio dio;

  AttendanceRemoteDataSourceImpl(this.dio);

  @override
  Future<StudentAttendanceModel> getAttendance(int studentId,
      {int? month, int? year}) async {
    final now = DateTime.now();
    final targetMonth = month ?? now.month;
    final targetYear = year ?? now.year;

    final response = await dio.get(
      '/api/Attendance/student/$studentId',
      queryParameters: {
        'month': targetMonth,
        'year': targetYear,
      },
    );

    return StudentAttendanceModel.fromJson(
      response.data as Map<String, dynamic>,
      targetMonth,
      targetYear,
    );
  }
}
