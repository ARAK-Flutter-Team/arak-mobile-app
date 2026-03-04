import '../entities/attendance_record.dart';
import '../repositories/attendance_repository.dart';

class SubmitAttendanceUseCase {
  final AttendanceRepository repository;

  SubmitAttendanceUseCase(this.repository);

  Future<void> call(
      List<AttendanceRecord> records,
      ) {
    return repository.submitAttendance(records);
  }
}