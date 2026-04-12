import '../../domain/entities/student.dart';

class StudentModel extends Student {
  StudentModel({
    required super.id,
    required super.name,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      id: json['id'],
      name: json['name'],
    );
  }
}