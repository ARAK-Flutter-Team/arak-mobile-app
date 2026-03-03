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
      parentName: json['parent_name'] ?? '',
      performancePercentage: (json['performance_percentage'] ?? 0).toDouble(),
      students: (json['students'] as List? ?? [])
          .map((s) => StudentModel.fromJson(s))
          .toList(),
    );
  }
}
