import '../../domain/entities/attendance_record.dart';

class AttendanceModel extends AttendanceRecord {
  const AttendanceModel({
    required super.studentId,
    required super.studentName,
    required super.classId,
    required super.date,
    required super.session,
    super.studentImageUrl,
    required super.status,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      studentId: json['studentId'],
      studentImageUrl: json['student_image'],
      studentName: json['studentName'],
      classId: json['classId'],
      date: DateTime.parse(json['date']),
      session: AttendanceSession.values
          .firstWhere((e) => e.name == json['session']),
      status: AttendanceStatus.values
          .firstWhere((e) => e.name == json['status']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "studentId": studentId,
      "studentName": studentName,
      "classId": classId,
      "date": date.toIso8601String(),
      "session": session.name,
      "status": status.name,
    };
  }
}