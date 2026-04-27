import '../../domain/entities/parent_home_entity.dart';
import 'student_model.dart';

class ParentHomeModel extends ParentHomeEntity {
  const ParentHomeModel({
    required super.parentName,
    required super.students,
    required super.performancePercentage,
  });

  factory ParentHomeModel.fromJson(Map<String, dynamic> json) {
    return ParentHomeModel(
      parentName: json['name'] ?? '',
      performancePercentage: 0,
      students: (json['students'] as List? ?? [])
          .map((s) => StudentModel.fromJson(s as Map<String, dynamic>))
          .toList(),
    );
  }
}
