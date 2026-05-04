import '../../domain/entities/attendance_record.dart';
import '../../domain/repositories/attendance_repository.dart';
import '../datasources/attendance_remote_datasource.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  final AttendanceRemoteDataSource remote;

  AttendanceRepositoryImpl(this.remote);

  @override
  Future<List<AttendanceRecord>> getAttendanceForSession({
    required String classId,
    required DateTime date,
  }) async {
    final response = await remote.getAttendanceForSession(
      classId: classId,
      date: date,
    );

    return response.students.map((student) {
      return AttendanceRecord(
        attendanceRecordId: student.attendanceRecordId,
        studentId: student.studentId,
        studentName: student.studentName,
        status: _mapStatus(student.status),
      );
    }).toList();
  }

// أضيفي الـ mapStatus داخل الـ Repository
  AttendanceStatus _mapStatus(String status) {
    switch (status.toLowerCase()) {
      case "present":
        return AttendanceStatus.present;
      case "late":
        return AttendanceStatus.late;
      case "absent":
        return AttendanceStatus.absent;
      default:
        return AttendanceStatus.present;
    }
  }

  @override
  Future<void> submitAttendance({
    required int classId,
    required String date,
    required String session,
    required List<AttendanceRecord> records,
  }) async {
    final recordsData = records.map((record) {
      return {
        "studentId": record.studentId,
        "status": record.status.name,
      };
    }).toList();

    await remote.submitAttendance(
      classId: classId,
      date: date,
      session: session,
      records: recordsData,
    );
  }
}
