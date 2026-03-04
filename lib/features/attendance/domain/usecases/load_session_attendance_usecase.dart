import '../entities/attendance_record.dart';
import '../repositories/attendance_repository.dart';

class LoadAttendanceUseCase {
  final AttendanceRepository repository;

  LoadAttendanceUseCase(this.repository);

  Future<List<AttendanceRecord>> call({
    required String classId,
    required DateTime date,
    required AttendanceSession session,
  }) {
    return repository.getAttendanceForSession(
      classId: classId,
      date: date,
      session: session,
    );
  }
}