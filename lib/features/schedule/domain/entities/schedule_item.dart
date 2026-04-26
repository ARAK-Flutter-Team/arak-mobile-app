/*class ScheduleItem {
  final String day;
  final String title;
  final String startTime;
  final String endTime;

  const ScheduleItem({
    required this.day,
    required this.title,
    required this.startTime,
    required this.endTime,
  });
}*/
class ScheduleItem {
  final int id;
  final int dayOfWeek;
  final String dayName;
  final String title;
  final String startTime;
  final String endTime;
  final String location;
  final int classId;
  final int subjectId;
  final int teacherId;
  final String subjectName;

  const ScheduleItem({
    required this.id,
    required this.dayOfWeek,
    required this.dayName,
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.location,
    required this.classId,
    required this.subjectId,
    required this.teacherId,
    required this.subjectName,
  });
}