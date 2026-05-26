import 'package:equatable/equatable.dart';

class StudentDetailsEntity extends Equatable {
  final String id;
  final String name;
  final int grade;
  final dynamic classNumber; // may be int or String
  final String? email;
  final String? profileImage;
  final String? parentUsername;
  final bool isVerified;

  const StudentDetailsEntity({
    required this.id,
    required this.name,
    required this.grade,
    required this.classNumber,
    this.email,
    this.profileImage,
    this.parentUsername,
    required this.isVerified,
  });

  @override
  List<Object?> get props => [id, name, grade, classNumber, email];
}
