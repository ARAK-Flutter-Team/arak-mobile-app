import '../../domain/entities/student_attendance_entity.dart';
import '../../domain/repositories/attendance_repository.dart';
import '../datasources/attendance_remote_data_source.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  final AttendanceRemoteDataSource remoteDataSource;

  AttendanceRepositoryImpl({required this.remoteDataSource});

  @override
  Future<StudentAttendance> getStudentAttendance(
    int studentId, {
    int? month,
    int? year,
  }) async {
    return await remoteDataSource.getAttendance(
      studentId,
      month: month,
      year: year,
    );
  }
}
