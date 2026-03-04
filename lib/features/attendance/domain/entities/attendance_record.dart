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
  final String studentId;
  final String studentName;
  final String classId;
  final DateTime date;
  final AttendanceSession session;
  final AttendanceStatus status;
  final String? studentImageUrl;
  const AttendanceRecord({
    required this.studentId,
    required this.studentName,
    required this.classId,
    required this.date,
    required this.session,
    required this.status,
    this.studentImageUrl,
  });

  AttendanceRecord copyWith({
    AttendanceStatus? status,
  }) {
    return AttendanceRecord(
      studentId: studentId,
      studentName: studentName,
      classId: classId,
      date: date,
      session: session,
      status: status ?? this.status,
      studentImageUrl: studentImageUrl,
    );
  }
}