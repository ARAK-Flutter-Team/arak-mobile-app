// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class StudentEntity extends Equatable {
  final String id;
  final String name;
  final int grade;
  final int classNumber;
  final String? profileImage;
  final String? assetImage;
  final String parentUsername;
  final bool isVerified;

  const StudentEntity({
    required this.id,
    required this.name,
    required this.grade,
    required this.classNumber,
    this.profileImage,
    this.assetImage,
    required this.parentUsername,
    required this.isVerified,
  });

  @override
  List<Object?> get props => [id, name, grade, classNumber, parentUsername];
}
