import '../../domain/entities/teacher_home_entity.dart';

class TeacherHomeModel extends TeacherHomeEntity {
  TeacherHomeModel({
    required super.teacherName,
    required super.subjectName,
    required super.performance,
    required super.assignedClasses,
    required super.hasNewTasks,
    required super.hasNewMessages,
    required super.todayClassesCount,
    required super.nextClass,
    required super.recentActivities,
  });

  factory TeacherHomeModel.fromJson(Map<String, dynamic> json) {
    return TeacherHomeModel(
      teacherName: json['teacher_name'],
      subjectName: json['subject_name'],
      performance: json['performance']?.toDouble(),
      assignedClasses: List<String>.from(json['assigned_classes']),
      hasNewTasks: json['has_new_tasks'],
      hasNewMessages: json['has_new_messages'],
      todayClassesCount: json['today_classes_count'],
      nextClass: json['next_class'] != null
          ? NextClassModel.fromJson(json['next_class'])
          : null,
      recentActivities: (json['recent_activities'] as List)
          .map((e) => ActivityModel.fromJson(e))
          .toList(),
    );
  }
}
class NextClassModel extends NextClassEntity {
  NextClassModel({
    required super.className,
    required super.startTime,
    required super.endTime,
  });

  factory NextClassModel.fromJson(Map<String, dynamic> json) {
    return NextClassModel(
      className: json['class_name'],
      startTime: json['start_time'],
      endTime: json['end_time'],
    );
  }
}
class ActivityModel extends ActivityEntity {
  ActivityModel({
    required super.iconPath,
    required super.title,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return ActivityModel(
      iconPath: json['icon_path'],
      title: json['title'],
    );
  }
}