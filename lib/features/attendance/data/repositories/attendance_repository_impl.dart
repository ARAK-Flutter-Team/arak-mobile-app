/*import '../../domain/entities/attendance_record.dart';
import '../../domain/repositories/attendance_repository.dart' hide AttendanceRecord, AttendanceSession;
import '../datasources/attendance_remote_datasource.dart';
import '../models/attendance_model.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  final AttendanceRemoteDataSource remote;

  AttendanceRepositoryImpl(this.remote);

  @override
  Future<List<AttendanceRecord>> getAttendance({
    required String classId,
    required DateTime date,
    required AttendanceSession session,
  }) {
    return remote.getAttendance(classId, date, session);
  }

  @override
  Future<void> submitAttendance(List<AttendanceRecord> records) {
    final models =
    records.map((e) => AttendanceModel(
      studentId: e.studentId,
      studentName: e.studentName,
      classId: e.classId,
      date: e.date,
      session: e.session,
      status: e.status,
    )).toList();

    return remote.submitAttendance(models);
  }
}*/