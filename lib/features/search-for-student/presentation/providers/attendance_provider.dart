import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arak_app/core/network/dio_provider.dart';
import '../../domain/entities/student_attendance_entity.dart';
import '../../domain/repositories/attendance_repository.dart';
import '../../data/datasources/attendance_remote_data_source.dart';
import '../../data/repositories/attendance_repository_impl.dart';

final attendanceRemoteDataSourceProvider =
    Provider<AttendanceRemoteDataSource>((ref) {
  final dio = ref.watch(dioProvider);
  return AttendanceRemoteDataSourceImpl(dio);
});

final attendanceRepositoryProvider = Provider<AttendanceRepository>((ref) {
  return AttendanceRepositoryImpl(
    remoteDataSource: ref.watch(attendanceRemoteDataSourceProvider),
  );
});

final attendanceProvider = FutureProvider.family<StudentAttendance, int>(
  (ref, studentId) async {
    final repository = ref.watch(attendanceRepositoryProvider);
    return repository.getStudentAttendance(studentId);
  },
);
