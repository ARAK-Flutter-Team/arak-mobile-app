import '../entities/attendance_record.dart';

abstract class AttendanceRepository {
  Future<List<AttendanceRecord>> getAttendanceForSession({
    required String classId,
    required DateTime date,
  });

  Future<void> submitAttendance({
    required int classId,
    required String date,
    required String session,
    required List<AttendanceRecord> records,
  });
}