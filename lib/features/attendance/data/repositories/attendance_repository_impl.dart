import 'package:http/http.dart' as _api;
import '../../domain/entities/attendance_record.dart';
import '../../domain/repositories/attendance_repository.dart';
import '../datasources/attendance_remote_datasource.dart';
import '../models/attendance_model.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  final AttendanceRemoteDataSource remote;

  AttendanceRepositoryImpl(this.remote);

  @override
  Future<List<AttendanceRecord>> getAttendanceForSession({
    required String classId,
    required DateTime date,
    required AttendanceSession session,
  }) async {
    return await remote.getAttendanceForSession(
      classId: classId,
      date: date,
      session: session,
    );
  }

  @override
  Future<void> submitAttendance(
      List<AttendanceRecord> records,
      ) async {
    final models = records.map(
          (e) => AttendanceModel(
        studentId: e.studentId,
        studentName: e.studentName,
        classId: e.classId,
        date: e.date,
        session: e.session,
        status: e.status,
      ),
    ).toList();

    await remote.submitAttendance(models);
  }

}