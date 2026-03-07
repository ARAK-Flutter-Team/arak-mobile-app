import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/student_attendance_entity.dart';
import '../../domain/repositories/attendance_repository.dart';
import '../../data/datasources/attendance_remote_data_source.dart';
import '../../data/repositories/attendance_repository_impl.dart';

final attendanceRemoteDataSourceProvider =
    Provider<AttendanceRemoteDataSource>((ref) {
  return AttendanceRemoteDataSourceImpl();
});

final attendanceRepositoryProvider = Provider<AttendanceRepository>((ref) {
  return AttendanceRepositoryImpl(
    remoteDataSource: ref.watch(attendanceRemoteDataSourceProvider),
  );
});

final attendanceProvider = FutureProvider<StudentAttendance>((ref) async {
  final repository = ref.watch(attendanceRepositoryProvider);
  return repository.getStudentAttendance();
});
