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
      name: json['studentName'] ?? json['name'] ?? '',
      grade: json['grade'] ?? '',
      status: json['todayStatus'] ?? json['status'] ?? '',
      date: json['date'] ?? '',
      checkIn: json['todayTimeIn']?.toString() ?? json['checkIn'] ?? '--:--',
      checkOut: json['todayTimeOut']?.toString() ?? json['checkOut'] ?? '--:--',
      attendanceRate: (json['attendanceRate'] ?? 0).toDouble(),
      lateTimes: json['lateArrivals'] ?? json['lateTimes'] ?? 0,
      absentTimes: json['absences'] ?? json['absentTimes'] ?? 0,
    );
  }
}
