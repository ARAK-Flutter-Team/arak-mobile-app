import '../../domain/entities/student_entity.dart';

class StudentModel extends Student {
  const StudentModel({
    required super.name,
    required super.grade,
    required super.subjects,
  });

  // لو هتجيب من API حقيقي
  factory StudentModel.fromJson(Map<String, dynamic> json) {
    // هنا هتطبق الـ parsing بتاعك لو الداتا جاية من سيرفر
    return StudentModel(
      name: json['name'] ?? '',
      grade: json['grade'] ?? '',
      subjects: [], // هسترها دلوقتي عشان التعقيد
    );
  }
}
