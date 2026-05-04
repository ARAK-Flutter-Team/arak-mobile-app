/*import '../../domain/entities/teacher_home_entity.dart';

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
}*/
// lib/features/teacher_home/data/models/teacher_home_model.dart

import '../../domain/entities/teacher_home_entity.dart';

class TeacherHomeModel {
  final int teacherId;
  final String teacherName;
  final String email;
  final String subject;
  final int subjectId;
  final List<String> assignedClasses;
  final int todayClassesCount;
  final bool hasNewTasks;

  TeacherHomeModel({
    required this.teacherId,
    required this.teacherName,
    required this.email,
    required this.subject,
    required this.subjectId,
    required this.assignedClasses,
    required this.todayClassesCount,
    required this.hasNewTasks,
  });

  // من JSON إلى Model
  factory TeacherHomeModel.fromJson(Map<String, dynamic> json) {
    return TeacherHomeModel(
      teacherId: json['teacherId'] ?? 0,
      teacherName: json['name'] ?? '',
      email: json['email'] ?? '',
      subject: json['subject'] ?? '',
      subjectId: json['subjectId'] ?? 0,
      assignedClasses: json['assignedClasses'] != null
          ? List<String>.from(json['assignedClasses'].map((e) => e.toString()))
          : [],
      todayClassesCount: json['todayClassesCount'] ?? 0,
      hasNewTasks: json['hasNewTasks'] ?? false,
    );
  }

  // من Model إلى Entity
  TeacherHomeEntity toEntity() {
    return TeacherHomeEntity(
      teacherId: teacherId,
      teacherName: teacherName,
      email: email,
      subject: subject,
      subjectId: subjectId,
      assignedClasses: assignedClasses,
      todayClassesCount: todayClassesCount,
      hasNewTasks: hasNewTasks,
    );
  }
}