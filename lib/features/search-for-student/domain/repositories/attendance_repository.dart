import '../entities/student_attendance_entity.dart';

abstract class AttendanceRepository {
  Future<StudentAttendance> getStudentAttendance(int studentId,
      {int? month, int? year});
}
