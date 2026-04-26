import '../entities/attendance_record.dart';
import '../repositories/attendance_repository.dart';

class SubmitAttendanceUseCase {
  final AttendanceRepository repository;

  SubmitAttendanceUseCase(this.repository);

  Future<void> call({
    required int classId,
    required String date,
    required String session,
    required List<AttendanceRecord> records,
  }) {
    return repository.submitAttendance(
      classId: classId,
      date: date,
      session: session,
      records: records,
    );
  }
}