import '../models/attendance_model.dart';
import '../../domain/entities/attendance_record.dart';

/// ========================================
/// Abstract Definition
/// ========================================
abstract class AttendanceRemoteDataSource {
  Future<List<AttendanceModel>> getAttendanceForSession({
    required String classId,
    required DateTime date,
    required AttendanceSession session,
  });

  Future<void> submitAttendance(
      List<AttendanceModel> records,
      );
}

