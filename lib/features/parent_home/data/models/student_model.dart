import '../../domain/entities/student_entity.dart';

class StudentModel extends StudentEntity {
  const StudentModel({
    required super.id,
    required super.numericId, // ← أضف ده
    required super.name,
    required super.grade,
    required super.classNumber,
    super.profileImage,
    super.assetImage,
    required super.parentUsername,
    required super.isVerified,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    final rawId = json['id'];
    return StudentModel(
      id: rawId?.toString() ?? '',
      numericId:
          rawId is int ? rawId : int.tryParse(rawId?.toString() ?? '') ?? 0,
      name: json['name'] ?? '',
      grade:
          int.tryParse(json['grade']?.toString() ?? '') ?? 0, // ← string → int
      classNumber: json['classNumber'] ?? 0,
      profileImage: json['profileImage'],
      parentUsername: '',
      isVerified: false,
    );
  }
}
