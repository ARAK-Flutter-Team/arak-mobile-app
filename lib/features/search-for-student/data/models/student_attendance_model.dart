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
    super.records,
  });

  factory StudentAttendanceModel.fromJson(
      Map<String, dynamic> json, int month, int year) {
    // ✅ parse الـ records
    final rawRecords = json['records'] as List<dynamic>? ?? [];
    final parsedRecords = rawRecords.map((r) {
      final dateParts = (r['date'] as String).split('-');
      return AttendanceDayRecord(
        date: DateTime(
          int.parse(dateParts[0]),
          int.parse(dateParts[1]),
          int.parse(dateParts[2]),
        ),
        status: r['status'] ?? 'NotRecorded',
      );
    }).toList();

    return StudentAttendanceModel(
      name: json['studentName'] ?? '',
      grade: '${json['grade'] ?? ''} - ${json['className'] ?? ''}',
      status: json['todayStatus'] ?? 'NotRecorded',
      date: '$month/$year',
      checkIn: json['todayTimeIn']?.toString() ?? '--:--',
      checkOut: json['todayTimeOut']?.toString() ?? '--:--',
      attendanceRate: (json['attendanceRate'] ?? 0).toDouble(),
      lateTimes: json['lateArrivals'] ?? 0,
      absentTimes: json['absences'] ?? 0,
      records: parsedRecords, // ✅
    );
  }
}
