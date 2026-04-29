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