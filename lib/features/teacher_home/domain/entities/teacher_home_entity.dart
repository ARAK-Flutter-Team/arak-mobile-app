class TeacherHomeEntity {
  final String teacherName;
  final String subjectName;
  final double? performance;
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
}