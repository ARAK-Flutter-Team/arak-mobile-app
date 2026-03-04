import '../entities/schedule_item.dart';

abstract class ScheduleRepository {
  Future<List<ScheduleItem>> getTeacherSchedule(int teacherId);
}