import '../entities/day_schedule.dart';

abstract class ScheduleRepository {
  Future<List<DaySchedule>> getDisplaySchedule(
    int viewTypeIndex, {
    int? classId,
    int? teacherId,
  });
}
