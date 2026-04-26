import 'attendance_student_model.dart';

class AttendanceResponseModel {
  final int classId;
  final String date;
  final List<AttendanceStudentModel> students;

  AttendanceResponseModel({
    required this.classId,
    required this.date,
    required this.students,
  });

  factory AttendanceResponseModel.fromJson(Map<String, dynamic> json) {
    return AttendanceResponseModel(
      classId: json['classId'],
      date: json['date'],
      students: (json['students'] as List)
          .map((e) => AttendanceStudentModel.fromJson(e))
          .toList(),
    );
  }
}