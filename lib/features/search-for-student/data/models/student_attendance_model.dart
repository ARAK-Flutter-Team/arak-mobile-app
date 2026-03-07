import '../../domain/entities/student_attendance_entity.dart';

class StudentAttendanceModel extends StudentAttendance {
  const StudentAttendanceModel({
    required super.name,
    required super.grade,
    required super.status,
    required super.date,
    required super.checkIn,
    required super.checkOut,
    required super.attendanceRate,
    required super.lateTimes,
    required super.absentTimes,
  });

  factory StudentAttendanceModel.fromJson(Map<String, dynamic> json) {
    return StudentAttendanceModel(
      name: json['name'] ?? '',
      grade: json['grade'] ?? '',
      status: json['status'] ?? '',
      date: json['date'] ?? '',
      checkIn: json['checkIn'] ?? '',
      checkOut: json['checkOut'] ?? '',
      attendanceRate: (json['attendanceRate'] ?? 0).toDouble(),
      lateTimes: json['lateTimes'] ?? 0,
      absentTimes: json['absentTimes'] ?? 0,
    );
  }
}
