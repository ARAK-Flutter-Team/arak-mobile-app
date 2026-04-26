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
      '/api/attendance/student/$studentId',
      queryParameters: {
        'month': targetMonth,
        'year': targetYear,
      },
    );

    final data = response.data as Map<String, dynamic>;

    return StudentAttendanceModel(
      name: data['studentName'] ?? '',
      grade: '${data['grade'] ?? ''} - ${data['className'] ?? ''}',
      status: data['todayStatus'] ?? 'NotRecorded',
      date: '$targetMonth/$targetYear',
      checkIn: data['todayTimeIn']?.toString() ?? '--:--',
      checkOut: data['todayTimeOut']?.toString() ?? '--:--',
      attendanceRate: (data['attendanceRate'] as num?)?.toDouble() ?? 0.0,
      lateTimes: data['lateArrivals'] ?? 0,
      absentTimes: data['absences'] ?? 0,
    );
  }
}
