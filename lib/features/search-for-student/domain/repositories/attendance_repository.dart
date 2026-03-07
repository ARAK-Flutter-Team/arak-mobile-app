import '../entities/student_attendance_entity.dart';

abstract class AttendanceRepository {
  Future<StudentAttendance> getStudentAttendance();
}
