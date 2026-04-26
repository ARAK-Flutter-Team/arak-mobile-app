enum AttendanceSession {
  morning,
  afternoon,
}

enum AttendanceStatus {
  present,
  absent,
  late,
}

class AttendanceRecord {
  final int attendanceRecordId;
  final int studentId;
  final String studentName;
  final AttendanceStatus status;

  const AttendanceRecord({
    required this.attendanceRecordId,
    required this.studentId,
    required this.studentName,
    required this.status,
  });

  AttendanceRecord copyWith({
    int? attendanceRecordId,
    int? studentId,
    String? studentName,
    AttendanceStatus? status,
  }) {
    return AttendanceRecord(
      attendanceRecordId: attendanceRecordId ?? this.attendanceRecordId,
      studentId: studentId ?? this.studentId,
      studentName: studentName ?? this.studentName,
      status: status ?? this.status,
    );
  }
}