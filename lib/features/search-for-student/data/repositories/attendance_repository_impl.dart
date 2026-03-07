import 'package:arak_app/features/search-for-student/domain/entities/student_attendance_entity.dart';
import 'package:arak_app/features/search-for-student/domain/repositories/attendance_repository.dart';
import 'package:arak_app/features/search-for-student/data/datasources/attendance_remote_data_source.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  final AttendanceRemoteDataSource remoteDataSource;

  AttendanceRepositoryImpl({required this.remoteDataSource});

  @override
  Future<StudentAttendance> getStudentAttendance() async {
    return await remoteDataSource.getAttendance();
  }
}
