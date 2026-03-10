import 'dart:convert';
import '../models/student_model.dart';

abstract class StudentRemoteDataSource {
  Future<List<StudentModel>> getStudents();
}

class StudentRemoteDataSourceImpl implements StudentRemoteDataSource {
  @override
  Future<List<StudentModel>> getStudents() async {
    // محاكاة للـ API (Mock)
    await Future.delayed(const Duration(seconds: 2));

    String fakeJsonResponse = '''
    [
      {"name": "Ahmed Khaled", "grade": "Grade 9 - Class 3", "status": "Present", "date": "October 2025", "checkIn": "08:00 AM", "checkOut": "02:00 PM", "attendanceRate": 90},
      {"name": "Sara Ali", "grade": "Grade 9 - Class 3", "status": "Absent", "date": "October 2025", "checkIn": "--:--", "checkOut": "--:--", "attendanceRate": 85}
    ]
    ''';

    final List<dynamic> jsonData = jsonDecode(fakeJsonResponse);
    return jsonData.map((json) => StudentModel.fromJson(json)).toList();
  }
}
