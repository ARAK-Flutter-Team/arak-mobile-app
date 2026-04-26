class AttendanceStudentModel {
  final int attendanceRecordId;
  final int studentId;
  final String studentName;
  final String status;

  AttendanceStudentModel({
    required this.attendanceRecordId,
    required this.studentId,
    required this.studentName,
    required this.status,
  });

  factory AttendanceStudentModel.fromJson(Map<String, dynamic> json) {
    return AttendanceStudentModel(
      attendanceRecordId: json['attendanceRecordId'],
      studentId: json['studentId'],
      studentName: json['studentName'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'studentId': studentId,
      'status': status,
    };
  }
}