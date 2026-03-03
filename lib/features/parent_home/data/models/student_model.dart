import '../../domain/entities/student_entity.dart';

class StudentModel extends StudentEntity {
  const StudentModel({
    required super.id,
    required super.name,
    required super.grade,
    required super.classNumber,
    super.profileImage,
    super.assetImage,
    required super.parentUsername,
    required super.isVerified,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      grade: json['grade'] ?? 0,
      classNumber: json['class_number'] ?? 0,
      profileImage: json['profile_image'],
      parentUsername: json['parent_username'] ?? '',
      isVerified: json['is_verified'] ?? false,
    );
  }
}
