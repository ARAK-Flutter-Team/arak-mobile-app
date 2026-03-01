import '../../domain/entities/teacher_home_entity.dart';

class TeacherHomeModel {
  final String teacherName;
  final String subjectName;
  final double performance;
  final List<String> assignedClasses;
  final bool hasNewTasks;
  final bool hasNewMessages;
  final int todayClassesCount;
  final NextClassModel? nextClass;
  final List<ActivityModel> recentActivities;

  TeacherHomeModel({
    required this.teacherName,
    required this.subjectName,
    required this.performance,
    required this.assignedClasses,
    required this.hasNewTasks,
    required this.hasNewMessages,
    required this.todayClassesCount,
    required this.nextClass,
    required this.recentActivities,
  });

  factory TeacherHomeModel.fromJson(Map<String, dynamic> json) {
    return TeacherHomeModel(
      teacherName: json['teacher_name'],
      subjectName: json['subject_name'],
      performance: (json['performance'] as num).toDouble(),
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

  TeacherHomeEntity toEntity() {
    return TeacherHomeEntity(
      teacherName: teacherName,
      subjectName: subjectName,
      performance: performance,
      assignedClasses: assignedClasses,
      hasNewTasks: hasNewTasks,
      hasNewMessages: hasNewMessages,
      todayClassesCount: todayClassesCount,
      nextClass: nextClass?.toEntity(),
      recentActivities:
      recentActivities.map((e) => e.toEntity()).toList(),
    );
  }
}

class NextClassModel {
  final String className;
  final String startTime;
  final String endTime;

  NextClassModel({
    required this.className,
    required this.startTime,
    required this.endTime,
  });

  factory NextClassModel.fromJson(Map<String, dynamic> json) {
    return NextClassModel(
      className: json['class_name'],
      startTime: json['start_time'],
      endTime: json['end_time'],
    );
  }

  NextClassEntity toEntity() {
    return NextClassEntity(
      className: className,
      startTime: startTime,
      endTime: endTime,
    );
  }
}

class ActivityModel {
  final String iconPath;
  final String title;

  ActivityModel({
    required this.iconPath,
    required this.title,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return ActivityModel(
      iconPath: json['icon_path'],
      title: json['title'],
    );
  }

  ActivityEntity toEntity() {
    return ActivityEntity(
      iconPath: iconPath,
      title: title,
    );
  }
}