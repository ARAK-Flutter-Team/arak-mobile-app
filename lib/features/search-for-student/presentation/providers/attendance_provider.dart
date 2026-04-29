import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arak_app/core/network/dio_provider.dart';
import '../../domain/entities/student_attendance_entity.dart';
import '../../domain/repositories/attendance_repository.dart';
import '../../data/datasources/attendance_remote_data_source.dart';
import '../../data/repositories/attendance_repository_impl.dart';

class AttendanceParams {
  final int studentId;
  final int month;
  final int year;

  const AttendanceParams({
    required this.studentId,
    required this.month,
    required this.year,
  });

  @override
  bool operator ==(Object other) =>
      other is AttendanceParams &&
      other.studentId == studentId &&
      other.month == month &&
      other.year == year;

  @override
  int get hashCode => Object.hash(studentId, month, year);
}

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

final attendanceProvider =
    FutureProvider.family<StudentAttendance, AttendanceParams>(
  (ref, params) async {
    final repository = ref.watch(attendanceRepositoryProvider);
    return repository.getStudentAttendance(
      params.studentId,
      month: params.month,
      year: params.year,
    );
  },
);
