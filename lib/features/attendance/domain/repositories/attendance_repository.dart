import '../entities/attendance_record.dart';

abstract class AttendanceRepository {
  Future<List<AttendanceRecord>> getAttendanceForSession({
    required String classId,
    required DateTime date,
    required AttendanceSession session,
  });

  Future<void> submitAttendance(
      List<AttendanceRecord> records,
      );
}