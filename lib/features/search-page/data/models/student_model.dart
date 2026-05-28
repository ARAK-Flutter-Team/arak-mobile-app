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
    super.parentName,
    super.parentUserId,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      id: (json['id'] ?? json['Id'] ?? '').toString(),
      name: json['name'] ?? json['Name'] ?? 'Unknown',
      grade: json['grade'] ?? json['Grade'] ?? '',
      status: json['status'] ?? json['Status'] ?? 'Active',
      date: json['date'] ?? json['Date'] ?? '',
      checkIn: json['checkIn'] ?? json['CheckIn'] ?? '--:--',
      checkOut: json['checkOut'] ?? json['CheckOut'] ?? '--:--',
      attendanceRate: (json['attendanceRate'] ?? json['AttendanceRate'] as num?)
          ?.toDouble(),

      // 🚀 INTEGRATION: Safely decode nullable parent fields from backend
      parentName: json['parentName'] ?? json['ParentName'],
      parentUserId: json['parentUserId'] ?? json['ParentUserId'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'grade': grade,
      'status': status,
      'date': date,
      'checkIn': checkIn,
      'checkOut': checkOut,
      'attendanceRate': attendanceRate,
      'parentName': parentName,
      'parentUserId': parentUserId,
    };
  }
}
