import '../../domain/entities/student_details_entity.dart';

class StudentDetailsModel extends StudentDetailsEntity {
  const StudentDetailsModel({
    required super.id,
    required super.name,
    required super.grade,
    required super.classNumber,
    super.email,
    super.profileImage,
    super.parentUsername,
    required super.isVerified,
  });

  factory StudentDetailsModel.fromJson(Map<String, dynamic> json) {
    final rawId = json['id'];
    return StudentDetailsModel(
      id: rawId?.toString() ?? '',
      name: json['name'] ?? '',
      grade: int.tryParse(json['grade']?.toString() ?? '') ?? 0,
      classNumber: json['class_number'] ??
          json['classnumber'] ??
          json['classId'] ??
          json['classNumber'] ??
          0,
      email: json['email'],
      profileImage: json['profileImage'],
      parentUsername: json['parent_username'] ?? json['parentUsername'],
      isVerified: json['is_verified'] ?? json['isVerified'] ?? false,
    );
  }
}
