/*class TeacherHomeEntity {
  final String teacherName;
  final String subjectName;
  final double performance;
  final List<String> assignedClasses;

  final bool hasNewTasks;
  final bool hasNewMessages;

  final int todayClassesCount;
  final NextClassEntity? nextClass;

  final List<ActivityEntity> recentActivities;

  TeacherHomeEntity({
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
}

class NextClassEntity {
  final String className;
  final String startTime;
  final String endTime;

  NextClassEntity({
    required this.className,
    required this.startTime,
    required this.endTime,
  });
}

class ActivityEntity {
  final String iconPath;
  final String title;

  ActivityEntity({
    required this.iconPath,
    required this.title,
  });
}*/
// lib/features/teacher_home/domain/entities/teacher_home_entity.dart

class TeacherHomeEntity {
  final int teacherId;
  final String teacherName;
  final String email;
  final String subject;
  final int subjectId;
  final List<String> assignedClasses;
  final int todayClassesCount;
  final bool hasNewTasks;

  TeacherHomeEntity({
    required this.teacherId,
    required this.teacherName,
    required this.email,
    required this.subject,
    required this.subjectId,
    required this.assignedClasses,
    required this.todayClassesCount,
    required this.hasNewTasks,
  });
}