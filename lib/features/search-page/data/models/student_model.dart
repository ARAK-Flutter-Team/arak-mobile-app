import '../../domain/entities/student.dart';

class StudentModel extends Student {
  const StudentModel({
    required super.name,
    required super.grade,
    required super.status,
    required super.date,
    required super.checkIn,
    required super.checkOut,
    required super.attendanceRate,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      name: json['name'] ?? "Unknown",
      grade: json['grade'] ?? "N/A",
      status: json['status'] ?? "Unknown",
      date: json['date'] ?? "N/A",
      checkIn: json['checkIn'] ?? "--:--",
      checkOut: json['checkOut'] ?? "--:--",
      attendanceRate: (json['attendanceRate'] ?? 0).toDouble(),
    );
  }
}
