import '../../domain/entities/attendance_record.dart';

class AttendanceModel extends AttendanceRecord {
  const AttendanceModel({
    required super.attendanceRecordId,
    required super.studentId,
    required super.studentName,
    required super.status,
    this.classId,
    this.date,
    this.session,
    this.timeIn,
    this.timeOut,
    this.notes,
  });

  final int? classId;
  final String? date;
  final String? session;
  final String? timeIn;
  final String? timeOut;
  final String? notes;

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    print(" Parsing JSON: $json");

    return AttendanceModel(
      attendanceRecordId: json['attendanceRecordId'] ?? 0,
      studentId: json['studentId'] ?? 0,
      studentName: json['studentName'] ?? 'Student',
      status: _mapStatus(json['status'] ?? 'NotRecorded'),
      classId: json['classId'],
      date: json['date'],
      session: json['session'],
      timeIn: json['timeIn'],
      timeOut: json['timeOut'],
      notes: json['notes'],
    );
  }

  static AttendanceStatus _mapStatus(String status) {
    switch (status.toLowerCase()) {
      case "present":
        return AttendanceStatus.present;
      case "late":
        return AttendanceStatus.late;
      case "absent":
        return AttendanceStatus.absent;
      case "notrecorded":
        return AttendanceStatus.present; // Default for new records
      default:
        return AttendanceStatus.present;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "studentId": studentId,
      "status": status.name,
    };
  }

  @override
  String toString() {
    return "AttendanceModel(studentId: $studentId, studentName: $studentName, status: ${status.name})";
  }
}
