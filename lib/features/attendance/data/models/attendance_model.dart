/*import '../../domain/entities/attendance_record.dart';

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
      "student_image": studentImageUrl,
      "classId": classId,
      "date": date.toIso8601String(),
      "session": session.name,
      "status": status.name,
    };
  }
 /* Map<String, dynamic> toJson() {
    return {
      "studentId": studentId,
      "studentName": studentName,
      "classId": classId,
      "date": date.toIso8601String(),
      "session": session.name,
      "status": status.name,
    };
  }*/
}*/
/*import '../../domain/entities/attendance_record.dart';

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
      studentId: json['studentId'].toString(),
      studentName: json['studentName'] ?? "",
      classId: json['classId'].toString(),
      date: DateTime.parse(json['date']),
      session: json['session'] == "Morning"
          ? AttendanceSession.morning
          : AttendanceSession.afternoon,
      status: _mapStatus(json['status']),
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
      default:
        return AttendanceStatus.present;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "studentId": int.parse(studentId),
      "studentName": studentName,
      "classId": int.parse(classId),
      "date": date.toIso8601String().split('T').first,
      "status": status.name,
      "session":
      session == AttendanceSession.morning ? "Morning" : "Afternoon",
    };
  }
}*/
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