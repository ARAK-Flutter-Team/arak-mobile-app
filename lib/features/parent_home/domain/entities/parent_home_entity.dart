import 'package:equatable/equatable.dart';
import 'student_entity.dart';

class ParentHomeEntity extends Equatable {
  final String parentName;
  final List<StudentEntity> students;
  final double performancePercentage;

  const ParentHomeEntity({
    required this.parentName,
    required this.students,
    required this.performancePercentage,
  });

  @override
  List<Object?> get props => [parentName, students, performancePercentage];
}
