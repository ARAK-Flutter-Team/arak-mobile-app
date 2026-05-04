import '../../domain/entities/student.dart';

class StudentModel extends Student {
  const StudentModel({
    required super.id,
    required super.name,
    required super.grade,
    required super.status,
    required super.date,
    required super.checkIn,
    required super.checkOut,
    required super.attendanceRate,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    // Try to get UUID from userId, parentId, or id
    final id = json['userId']?.toString() ?? 
               json['parentId']?.toString() ?? 
               json['id']?.toString() ?? 
               "0";

    return StudentModel(
      id: id,
      name: json['name'] ?? json['Name'] ?? "Unknown",
      grade: json['grade'] ?? json['Grade'] ?? "N/A",
      status: json['status'] ?? json['Status'] ?? "Unknown",
      date: json['date'] ?? json['Date'] ?? "N/A",
      checkIn: json['checkIn'] ?? json['CheckIn'] ?? "--:--",
      checkOut: json['checkOut'] ?? json['CheckOut'] ?? "--:--",
      attendanceRate: (json['attendanceRate'] ?? json['AttendanceRate'] ?? 0).toDouble(),
    );
  }
}
