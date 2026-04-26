/*import '../models/attendance_model.dart';
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
}*/
/*import '../models/attendance_response_model.dart';

abstract class AttendanceRemoteDataSource {
  Future<AttendanceResponseModel> getAttendanceForSession({
    required String classId,
    required DateTime date,
  });

  Future<void> submitAttendance({
    required int classId,
    required String date,
    required String session,
    required List<Map<String, dynamic>> records,
  });
}*/
import '../models/attendance_response_model.dart';

abstract class AttendanceRemoteDataSource {
  Future<AttendanceResponseModel> getAttendanceForSession({
    required String classId,
    required DateTime date,
  });

  Future<void> submitAttendance({
    required int classId,
    required String date,
    required String session,
    required List<Map<String, dynamic>> records,
  });
}